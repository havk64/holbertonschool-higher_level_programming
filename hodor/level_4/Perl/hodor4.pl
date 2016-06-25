#!/usr/bin/perl
use strict;
use warnings;
use LWP::UserAgent;	# Used to the http requests.
use HTTP::Request::Common qw(POST);
use Data::Dump "pp";	# Used to print the request object, if desired.
use HTTP::Cookies;

=pod
 * ===---Description------------------------------------------------------------===
 *   Solution for the Hodor Project, Level 4 by Julien Barbier.
 *   Using a simple Perl script through Tor network(socks5 proxy).
 *   Besides Tor network active you also needs to install a Perl module
 *   in order to be able to use the Tor socks 5 proxy:
 *   $ sudo cpan LWP::Protocol::socks
 *
 *   by Alexandro de Oliveira, for Holberton School
 * ===--------------------------------------------------------------------------===
=cut

# LWP is the "Library for WWW in Perl":
my $ua  = LWP::UserAgent->new();

# Defining the URL:
my $url = 'http://173.246.108.142/level4.php';

# Setting the header:
my $headers = HTTP::Headers->new(
    user_agent => "havk64 - Perl script requests through Tor network",
    referer => $url,
    timeout => 10,
);
$ua->default_headers($headers);

#Cookie management:
my $cookie_jar = HTTP::Cookies->new(
   file     => "cookies.lwp",
   autosave => 1,
   ignore_discard => 1,
);
$ua->cookie_jar( $cookie_jar );

# Setting the proxy(Tor socks5):
$ua->proxy([qw/ http https /] => 'socks://127.0.0.1:9050');
# Check the IP(Tor exit).
# my $myip = $ua->get('https://api.ipify.org');
# print "\n" . $myip->decoded_content() . "\n";

# Request Tor Controller password:
print "Tor Controller password: => ";
chomp (my $torpass = <STDIN>);

my $count = 0; # Initializing the vote counter.
print "How many votes? => ";
chomp (my $total = <STDIN>);

while($count < $total) {
    my $myip = $ua->get('https://api.ipify.org');
    print "\n" . $myip->decoded_content() . "\n";
    # HEAD request to get the cookie value:
    my $reqh    = HTTP::Request->new(HEAD => $url);
    my $head    = $ua->request($reqh);
    # Check the header:
    # print $head->headers_as_string . "\n";

    # Parsing the cookie to make the POST request:
    my $params  = bodyrequest($head->header('Set-Cookie'));
    # Setting the request:
    my $req = POST $url, $params;
    # Optionally print the request header(great for learning purposes):
    # print pp($ua);
    # Our POST request:
    my $request = $ua->request($req);

    # To print the server headers:
    # print $request->headers_as_string;
    my $check = $request->header('Set-Cookie');
    my $pattern = 'HoldTheDoor';
    if(defined($check) && $check =~ m/$pattern/) { # Using regexp to check if the vote was confirmed.
        print "Vote number: @{[$count + 1]}\n";  # Evaluation and string interpolation.
                $count++;
    } else {
        print "Failed...\n";
    }
    # To print the body:
    # print $request->decoded_content();

    # Requesting new Tor identity(new Tor exit/IP).
    newIdentity(); # <<<<<<<=== <<<
}

# Printing the total of valid votes.
print "Total of valid votes: $count\n";

# Function to set the body request:
sub bodyrequest {
    my ($str) = @_; # Perl function parameters.
    my $cookie  = (split(/;/,$str))[0];
    my $value   = (split(/=/,$cookie))[1];
    # Setting the body of http request:
    my $params = [
        id          => "23", # => The ID number to vote(23 is my id number).
        holdthedoor => 'submit',
        key         => $value,
    ];
    return $params;
}
# Function to request new Tor identity:
sub newIdentity {
    my $socket = IO::Socket::INET->new(
                'PeerHost'  => '127.0.0.1',
                'PeerPort'  => '9051',
                'Proto'     =>  'tcp',
            ) or die "Problem making socket: $!";
    print $socket 'AUTHENTICATE "' . $torpass . '"' . "\n";
    print $socket 'SIGNAL NEWNYM' . "\n";
    my $var = <$socket>;# Checking the response to our request to new identity.
    print $var . "\n";  # and printing it to the screen.
    $socket->close();
    sleep 1;
}

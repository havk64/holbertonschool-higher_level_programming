use strict;
use warnings;
use LWP::UserAgent;	# Used to the http requests.
use HTTP::Request::Common qw(POST);
use Data::Dump "pp";	# Used to print the request object, if desired.
use HTTP::Cookies;

=pod
 * ===---Description------------------------------------------------------------===
 *   Solution for the Hodor Project, Level 3 by Julien Barbier.
 *   The goal is to vote 1024 times in this URL: http://173.246.108.142/level3.php
 *   Using Perl script and Tesseract-OCR to decode img captcha.
 *
 *   by Alexandro de Oliveira, for Holberton School
 * ===--------------------------------------------------------------------------===
=cut

# LWP is the "Library for WWW in Perl":
my $ua       = LWP::UserAgent->new();
my $url      = 'http://173.246.108.142/level3.php';
my $ucaptcha = 'http://173.246.108.142/captcha.php';

# Setting the header:
my $headers  = HTTP::Headers->new(
    user_agent => "Windows NT 100000000000000 (spoofing the User-Agent) havk64 - Perl script requests",
    referer => $url,
);
$ua->default_headers($headers);

#Cookie management:
my $cookie_jar = HTTP::Cookies->new(
   file     => "cookies.lwp",
   autosave => 1,
   ignore_discard => 1,
);
$ua->cookie_jar( $cookie_jar );
# print pp($ua);
my $count = 0;
print "How many votes? => ";
chomp (my $total = <STDIN>);
while( $count < $total) {
    # Fetching the captcha:
    my $req     = HTTP::Request->new(GET => $ucaptcha);
    my $res     = $ua->request($req);

    if ($res->is_success) {
        writefile($res->decoded_content);
    }
    # Sending the captcha to Tesseract OCR to be decoded:
    my $captcha = `tesseract tmp.png - 2> /dev/null | tr -d '\040\012'`;
    # Prints the captcha:
    print "\n" . "Decoded captcha => " . $captcha . "\n";
    # HEAD request to get the cookie value:
    my $reqh    = HTTP::Request->new(HEAD => $url);
    my $head    = $ua->request($reqh);
    # Check the header:
    # print $head->headers_as_string . "\n";
    # Parsing the cookie:
    my $value   = getCookie($head->header('Set-Cookie'));
    # Using cookie and captcha to make the POST request:
    my $params  = bodyrequest($value, $captcha);
    my $reqpost = POST $url, $params;
    # The POST request:
    my $request = $ua->request($reqpost);
    # Check if the vote was computed:
    my $test = $request->header('Set-Cookie');
    my $pattern = 'HoldTheDoor';
    if(defined($test) && $test =~ m/$pattern/) { # Using regexp to check if the vote was confirmed.
        print "Vote number: @{[$count + 1]}\n";  # Evaluation and string interpolation.
                $count++;
    } else {
        print "Vote invalid...\n";
    }
    # Optionally print the request header(great for learning purposes):
    # print pp($ua);
    # or the response Body:
    # print $request->decoded_content();
}

# Function to parse the Cookie from header:
sub getCookie {
    my ($str)   = @_;
    my $cookie  = (split(/;/,$str))[0];
    my $value   = (split(/=/,$cookie))[1];
    return $value;
}

sub writefile {
    my ($str)   = @_;
    my $file    = 'tmp.png';
    # Opening the file:
    open(my $fh, '>', $file) or die "Could not open file: '$file' $!\n";
    # Writing to the disk:
    print $fh $str or die "Error writing to the file $file $!\n";
    # Closing the file:
    close $fh;
}

sub bodyrequest {
    my ($value, $captcha) = @_;
    # Setting the body of http request:
    my $params = [
        id => "23", # => The ID number to vote(23 is my id number).
        holdthedoor => 'submit',
        key => $value,
        captcha => $captcha,
    ];
    return $params;
}

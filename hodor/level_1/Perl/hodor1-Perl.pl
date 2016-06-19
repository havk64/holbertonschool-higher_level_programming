#!/usr/bin/perl
use strict;
use warnings;
use LWP::UserAgent;

=pod
 * ===---Description------------------------------------------------------------===
 *   Solution for the Hodor Project, Level 1 by Julien Barbier.
 *   Using a simple Perl script.
 *
 *   by Alexandro de Oliveira, for Holberton School
 * ===--------------------------------------------------------------------------===
=cut

# LWP is the "Library for WWW in Perl":
my $ua  = LWP::UserAgent->new();
$ua->timeout(10);

# Defining the User-Agent:
$ua->agent("havk64 - Perl script requests");

my $url = 'http://173.246.108.142/level1.php';

my $cookie = "6b695713db9b371a855adf1e229264c681f2e48";

$ua->default_header('Cookie' => "HoldTheDoor=$cookie");

my $params = {
    id => "23",
    holdthedoor => 'submit',
    key => $cookie
};
my $counter = 0; # Initializing the counter.
for(my $i = 0; $i < (1 << 4); $i++) {
    my $request = $ua->post($url, $params);
    # To print the server headers:
    # print $request->headers_as_string;
    my $check = $request->header('Set-Cookie');
    my $pattern = 'HoldTheDoor';
    if(defined($check) && $check =~ m/$pattern/) { # Using regexp to check if the vote was confirmed.
        print "Vote number: @{[$counter + 1]}\n";  # Evaluation and string interpolation.
                $counter++;
    } else {
        print "Connection error...(vote not computed)\n";
    }
    # To print the body:
    # print $request->decoded_content();
}
# Printing the total of valid votes.
print "Total of valid votes: $counter\n";

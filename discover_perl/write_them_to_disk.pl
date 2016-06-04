#!/usr/bin/perl

=pod
* ===---Description------------------------------------------------------------===
*   Github Perl most popular Projects, based on Rudy Rigoy projects.
*   Using a Perl script to get the 30 most popular Perl Github repositories
*
*   by Alexandro de Oliveira, for Holberton School
* ===--------------------------------------------------------------------------===
=cut

use strict;
use warnings;
use LWP::UserAgent;
use Data::Dump "pp";	# Used to print and analize complex objects.


my $url = 'https://api.github.com/search/repositories?q=language:perl&sort=stars&order=desc';

my $headers = HTTP::Headers->new(
'User-Agent'=> 'Holberton_School',
'Authorization' => 'token 6a54def2525aa32b003337b31487e321d6a2bb59',
);

my $ua = LWP::UserAgent->new(ssl_opts => { verify_hostname => 0}); # bypass SSL authentication checks.

my $req = HTTP::Request->new(GET => $url, $headers);
# Print the request object:
#print pp($req);

# Requesting:
my $res = $ua->request($req);
# print pp($res);
die "Error getting $url\n", $res->status_line
unless $res->is_success( );

my $file = '/tmp/23';
# Opening the file:
open(my $fh, '>', $file) or die "Could not open file: '$file' $!\n";
# Writing to the disk:
print $fh $res->decoded_content or die "Error writing to the file $file $!\n";
# Closing the file:
close $fh;
# I will print this line just if the file was written with success:
print "The file was saved!\n";
# Offer possibility to open the file to check its content:
print "Do you want to open the file just created?\n";
my $question = <STDIN>;
if($question == "yes") {
    open(DATA, "<", "/tmp/23") or die "Error opening this file!, $!";
    print <DATA>;
}
print "Done!";
=pod
print "HTTP status: ", $res->code( ), "\n";
# Print the whole raw header:
# print $res->headers_as_string . "\n";
# Print the content body:
print $res->decoded_content;
=cut

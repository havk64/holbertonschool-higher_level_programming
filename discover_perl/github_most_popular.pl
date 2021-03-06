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


print "HTTP status: ", $res->code( ), "\n";
# Print the whole raw header:
# print $res->headers_as_string . "\n";
# Print the content body:
print $res->decoded_content;

#!/usr/bin/perl

=pod
* ===---Description------------------------------------------------------------===
*   Github Perl most popular Projects, based on Rudy Rigoy projects.
*   Using a Perl script to get the 30 most popular Perl Github repositories.
*
*   by Alexandro de Oliveira, for Holberton School
* ===--------------------------------------------------------------------------===
=cut

use strict;
use warnings;
use LWP::UserAgent;
use Data::Dump "pp";            # Used to print and analize complex objects.
use JSON;

my $url = 'https://api.github.com/search/repositories?q=language:perl&sort=stars&order=desc';

my $headers = HTTP::Headers->new(
'User-Agent'=> 'Holberton_School',
'Authorization' => 'token 6a54def2525aa32b003337b31487e321d6a2bb59',
);

my $ua = LWP::UserAgent->new(ssl_opts => { verify_hostname => 0}); # bypass SSL authentication checks.

my $req = HTTP::Request->new(GET => $url, $headers);
# Print the request object:
# print pp($req);

# Requesting/Connecting:
my $res = $ua->request($req);
# print pp($res);
die "Error getting $url\n", $res->status_line
unless $res->is_success();

my $myjson = decode_json($res->content());
my @result;
foreach my $item (@{$myjson -> {items}})
{
    my $login = $item->{owner}->{login};
    my $full_name = $item->{full_name};
    my $location = fetchData($login);
    my %obj = (full_name => $login, location => $location);
    push @result, \%obj;
}

print encode_json(\@result);

# Fetching the location of each user:
sub fetchData
{
    my $login = shift; # Defining the parameter to this subroutine.
    my $url = "https://api.github.com/users/" . $login;
    my $ua = LWP::UserAgent->new(ssl_opts => {verify_hostname => 0 });
    my $req = HTTP::Request->new( GET => $url, $headers);
    my $res = $ua->request($req);
    die "Error requesting $login $!\n", $res->status_line
    unless $res->is_success();
    my $data = decode_json($res->content);
    return $data->{location};
}

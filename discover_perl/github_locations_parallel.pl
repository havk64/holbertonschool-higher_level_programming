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
require LWP::Parallel::UserAgent;
#use LWP::Debug qw(+);          # display tons of debugging messages. See 'perldoc LWP::Debug'
use Data::Dump "pp";            # Used to print and analize complex objects.
use JSON;                       # JSON parse/encode.
use Time::HiRes;

my $start = Time::HiRes::gettimeofday();
print "Starting...";
my $url = 'https://api.github.com/search/repositories?q=language:perl&sort=stars&order=desc';

my $headers = HTTP::Headers->new(
'User-Agent'=> 'Holberton_School',
'Authorization' => 'token 6a54def2525aa32b003337b31487e321d6a2bb59',
);

my $ua = LWP::UserAgent->new(ssl_opts => { verify_hostname => 0}); # bypass SSL authentication checks.
my $pua = LWP::Parallel::UserAgent->new(); # The parallel request instantiated.
# Setting parameters to parallel requests.
$pua->in_order  (1);  # handle requests in order of registration
$pua->duplicates(0);  # ignore duplicates
$pua->timeout   (2);  # in seconds
$pua->redirect  (1);  # follow redirects
my $req = HTTP::Request->new(GET => $url, $headers);
# Print the request object:
#print pp($req);

# Requesting:
my $res = $ua->request($req);
# print pp($res);
die "Error getting $url\n", $res->status_line
unless $res->is_success();

my $myjson = decode_json($res->content());
my @result;
print "starting...\n";

my $middle = Time::HiRes::gettimeofday();
printf("%.2f\n", $middle - $start);
foreach my $item (@{$myjson -> {items}})
{
    my $login = $item->{owner}->{login};
    my $full_name = $item->{full_name};
    register($login);
    #my $location = register($login);
    #my %obj = (full_name => $login, location => $location);
    #push @result, \%obj;
}

my $entries = $pua->wait();
#fetch($entries);
print "Fetching users!\n";
foreach (keys %$entries) {
    my $res = $entries->{$_}->response;

    print "Answer for '",$res->request->url, "' was \t", $res->code,": ", $res->message,"\n";
    #die "Error requesting $login $!\n", $res->status_line unless $res->is_success();
    my $data = decode_json($res->content);
    my $loc = $data->{location};
    print $loc;
}
=pod
sub fetch
{
    my $entries = shift;

}
=cut

print encode_json(\@result);
my $end = Time::HiRes::gettimeofday();
printf("%.2f\n", $end - $start);
# Fetching the location of each user:
sub register
{
    my $login = shift; # Defining the parameter to this subroutine.
    my $url = "https://api.github.com/users/" . $login;
    #my $pua = LWP::Parallel::UserAgent->new(ssl_opts => {verify_hostname => 0 });
    my $req = HTTP::Request->new( GET => $url, $headers);
    if(my $res = $pua->register($req)) {
        print STDERR $res->error_as_HTML;
    }
}

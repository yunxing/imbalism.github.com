-module(ring).
-export([start/2]).

gen(0, Y)->
    spawn(fun()->loop(Y) end);
gen(N, Y)->
    gen(N - 1, spawn(fun()->loop(Y) end)).
gen(N)->
    gen(N, spawn(fun loop/0)).

start(N, M)->
    Pid = gen(N),
    io:format("start time:~p~n", [erlang:now()]),
    Pid ! {Pid, M, self()},
    receive
	finished->
	    io:format("end time:~p~n", [erlang:now()])
    end.

loop() ->
    receive
	{_Next, 1, Dist}->
	    Dist!finished;
	{Next, M, Dist}->
	    io:format("loop ~p finished~n", [M]),
	    Next ! {Next, M - 1, Dist},
	    loop()
    end.

loop(X)->
    receive	
	{Src, M, Dist} ->
	    X ! {Src, M, Dist},
	    loop(X)
    end.

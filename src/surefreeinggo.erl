-module(surefreeinggo).
-export([start/0]).

start() ->
	io:format("Hello my name is surefreeinggo~n"),
	Handle = bitcask:open("surefreeinggo_db", [read_write]),
	N = fetch(Handle),
	store(Handle, N+1),
	io:format("surefreeinggo has been run ~p times~n", [N]),
	bitcask:close(Handle),
	init:stop().

store(Handle, N) ->
	bitcask:put(Handle, <<"surefreeinggo_executions">>, term_to_binary(N)).

fetch(Handle) ->
	case bitcask:get(Handle, <<"surefreeinggo_executions">>) of 
		not_found -> 1;
		{ok, Bin} -> binary_to_term(Bin)
	end.
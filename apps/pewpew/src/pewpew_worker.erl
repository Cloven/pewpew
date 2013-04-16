-module(pewpew_worker).
-behaviour(gen_server).

%% API.
-export([start_link/0]).
-export([stop/0]).

%% gen_server.
-export([init/1]).
-export([handle_call/3]).
-export([handle_cast/2]).
-export([handle_info/2]).
-export([terminate/2]).
-export([code_change/3]).

-define(SERVER, ?MODULE).

start_link() ->
	gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

stop() ->
	gen_server:call(?SERVER, stop).

init([]) ->
  {ok, cheerful}.

handle_call(stop, _From, State) ->
	{stop, normal, stopped, State};
handle_call(ping, _From, State) ->
        io:format("PONG!~n"),
        {reply, ignored, State};
handle_call(_Request, _From, State) ->
	{reply, ignored, State}.

handle_cast(_Msg, State) ->
	{noreply, State}.

handle_info(_Info, State) ->
	{noreply, State}.

terminate(_Reason, _State) ->
	ok.

code_change(_OldVsn, State, _Extra) ->
	{ok, State}.

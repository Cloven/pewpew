-module(pewpew_ws).

-export([start/1, init/3, handle/2, terminate/2, terminate/3]).

start(Port) ->
  application:start(crypto),
  application:start(ranch),
  application:start(cowboy),
  N_acceptors = 1000,
  Dispatch = cowboy_router:compile(
    [
      {'_',[{'_', pewpew_ws, []}]}
    ]),
  cowboy:start_http(my_simple_web_server, N_acceptors, [{port, Port}],
    [{env, [{dispatch, Dispatch}]}]
  ).

init({tcp, http}, Req, Opts) ->
  {ok, Req, undefined}.

handle(Req, State) ->
  {Path, Req1} = cowboy_req:path(Req),
  Response = "hello world",
  {ok, Req2} = cowboy_req:reply(200,[],Response,Req1),
  {ok, Req2, State}.

read_file(Path) ->
  File = ["."|binary_to_list(Path)], 
  case file:read_file(File) of
    {ok, Bin} -> Bin;
    _ -> ["<pre>cannot read:", File, "</pre>"] 
  end.

terminate(_,_) -> ok.

terminate(_,_,_) -> ok.

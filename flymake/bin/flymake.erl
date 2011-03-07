-module(flymake).

-export([main/1]).

-define(REBARS, ["..", "../..", "../../.."]).

file_exists(FileName) ->
    case file:read_file_info(FileName) of
        {error, _} ->
            false;
        _ ->
            true
    end.

locate_build_tool([]) ->
    not_found;
locate_build_tool([H|T]) ->
    FileName = filename:join([H, "rebar"]),
    case file_exists(FileName) of
        true ->
            filename:absname(FileName);
        false ->
            locate_build_tool(T)
    end.

can_build_with_rebar([]) ->
    false;
can_build_with_rebar([H|T]) ->
    FileName = filename:join([H, "rebar.config"]),
    case file_exists(FileName) of
        true ->
            {true, H};
        false ->
            can_build_with_rebar(T)
    end.

manual_compile(FileName) ->
    Result = compile:file(FileName, [warn_obsolete_guard, warn_unused_import,
                                     warn_shadow_vars, warn_export_vars,
                                     strong_validation, report_errors,
                                     report_warnings,
                                     {i, "../include"},
                                     {outdir, "/tmp"}]),
    log("Manual compile result: ~p~n", [Result]),
    Result.

normalize_rebar_error(Err, FileName0) ->
    FileName = filename:basename(FileName0),
    case string:tokens(Err, ":") of
        [FName0, Line, ErrMsg] ->
            FName = filename:basename(FName0),
            if
                FName =:= FileName ->
                    lists:flatten([FileName, ":", Line, ":", ErrMsg]);
                true ->
                    []
            end;
        _ ->
            []
    end.

rebar_build(Rebar, ConfigPath, FileName) ->
    log("Setting working dir: ~p~n", [ConfigPath]),
    file:set_cwd(ConfigPath),
    Cmd = Rebar ++ " compile 2>&1",
    log("rebar command: ~p~n", [Cmd]),
    [_|T] = string:tokens(os:cmd(Cmd), "\n"),
    log("Errors: ~p~n",  [T]),
    Errors0 = [normalize_rebar_error(Err, FileName) || Err <- T],
    Errors = [Err || Err <- Errors0,
                     Err /= []],
    log("Final errors: ~p~n", [Errors]),
    io:format("~s", [string:join(Errors, "\n") ++ "\n"]).

main([FileName]) ->
    Path = string:tokens(os:getenv("PATH"), ":"),
    case can_build_with_rebar(?REBARS) of
        {true, ConfigDir} ->
            case locate_build_tool(?REBARS ++ Path) of
                not_found ->
                    log("Manually compiling: ~p~n", [FileName]),
                    manual_compile(FileName);
                Rebar ->
                   log("rebar: ~p, ~p, ~p~n", [Rebar, ConfigDir, FileName]),
                    rebar_build(Rebar, ConfigDir, FileName)
            end;
        false ->
            log("Manually compiling: ~p~n", [FileName]),
            manual_compile(FileName)
    end.

log(Format, Data) ->
    IsDebug = case os:getenv("FLYMAKE_DEBUG") of
                  "false" ->
                      false;
                  false ->
                      false;
                  _ ->
                      true
              end,
    log(Format, Data, IsDebug).

log(Format, Data, true) ->
    file:write_file("/tmp/build.log",
                    io_lib:format(Format, Data),
                    [append]);
log(_, _, false) ->
    ok.

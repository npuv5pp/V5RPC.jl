# V5RPC.jl

V5RPC module for the Simuro5v5 platform. Written in Julia.

# Install

1. Install [Julia](https://julialang.org).
2. Run following command in Julia REPL:

   ```
   ]add https://github.com/npuv5pp/V5RPC.jl
   ```

# Usage

Every strategy type is a subtype of `Strategy`.
Suppose we have

```julia
struct MyStrategy <: Strategy end
```

Then the following overloaded methods can be given. For more information, refer to the [V5RPC] documentation.

[V5RPC]: https://github.com/npuv5pp/V5RPC

```julia
on_event(::MyStrategy, ::Int32, ::V5RPC.EventArguments)::Nothing
get_team_info(::MyStrategy, ::V5RPC.ServerInfo)::String
get_instruction(::MyStrategy, ::V5RPC.Field) # returns [(l, r), ...] or (wheels, V5RPC.ControlType.Reset)
get_placement(::MyStrategy, ::V5RPC.Field) # returns [(x, y, rotation), ...]
```

Then construct a `V5Server` and run it.

```julia
run(V5Server(MyStrategy(), 20000))
```


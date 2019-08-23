module V5RPC
export Strategy,V5Server

module PB
(filename->include(joinpath(@__DIR__, "..", "deps", "julia_pb", filename))).(["DataStructures_pb.jl","Events_pb.jl","API_pb.jl"])
end
using .PB

abstract type Strategy end

function on_event(::Strategy, ::Int32, ::EventArguments)
    @warn "on_event not implemented"
    nothing
end

function get_team_info(::Strategy)
    @warn "get_team_info not implemented"
    ""
end

function get_instruction(::Strategy, ::Field)
    @warn "get_instruction not implemented"
    fill((0, 0), 5)
end

function get_placement(::Strategy, ::Field)
    @warn "get_placement not implemented"
    fill((0, 0, 0), 5)
end

struct EmptyStrategy <: Strategy end
on_event(::EmptyStrategy, ::Int32, ::EventArguments) = nothing
get_team_info(::EmptyStrategy) = "Empty Strategy"
get_instruction(::EmptyStrategy, ::Field) = fill((0, 0), 5)
get_placement(::EmptyStrategy, ::Field) = fill((0, 0, 0), 5)

include("V5Packet.jl")
using .ModV5Packet
include("V5Server.jl")
using .ModV5Server

end # module

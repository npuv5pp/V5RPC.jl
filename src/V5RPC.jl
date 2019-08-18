module V5RPC
export Strategy,V5Server

module PB
(filename->include(joinpath(@__DIR__, "..", "deps", "julia_pb", filename))).(["DataStructures_pb.jl","Events_pb.jl","API_pb.jl"])
end
using .PB

abstract type Strategy end

function on_event(::Strategy, ::Int32, ::EventArguments)
    @warn "on_event not implemented"
end

function get_team_info(::Strategy)
    @warn "get_team_info not implemented"
    TeamInfo(team_name = "")
end

function get_instruction(::Strategy, ::Field)
    @warn "get_instruction not implemented"
    fill(Wheel(left_speed = 0, right_speed = 0), 5)
end

function get_placement(::Strategy, ::Field)
    @warn "get_placement not implemented"
    robots = fill(Robot(position = Vector2(x = 0, y = 0), rotation = 0, wheel = Wheel(left_speed = 0, right_speed = 0)), 5)
    ball = Ball(position = Vector2(x = 0, y = 0))
    Placement(robots = robots, ball = ball)
end

include("V5Packet.jl")
using .ModV5Packet
include("V5Server.jl")
using .ModV5Server

end # module

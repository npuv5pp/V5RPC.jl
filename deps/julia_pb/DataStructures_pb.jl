# syntax: proto3
using ProtoBuf
import ProtoBuf.meta

struct __enum_Version <: ProtoEnum
    V1_0::Int32
    V1_1::Int32
    __enum_Version() = new(0,1)
end #struct __enum_Version
const Version = __enum_Version()

struct __enum_Team <: ProtoEnum
    Self::Int32
    Opponent::Int32
    Nobody::Int32
    __enum_Team() = new(0,1,2)
end #struct __enum_Team
const Team = __enum_Team()

struct __enum_ControlType <: ProtoEnum
    Continue::Int32
    Reset::Int32
    __enum_ControlType() = new(0,1)
end #struct __enum_ControlType
const ControlType = __enum_ControlType()

mutable struct Vector2 <: ProtoType
    x::Float32
    y::Float32
    Vector2(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct Vector2

mutable struct TeamInfo <: ProtoType
    team_name::AbstractString
    version::Int32
    TeamInfo(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct TeamInfo

mutable struct Ball <: ProtoType
    position::Vector2
    Ball(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct Ball

mutable struct Wheel <: ProtoType
    left_speed::Float32
    right_speed::Float32
    Wheel(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct Wheel

mutable struct Robot <: ProtoType
    position::Vector2
    rotation::Float32
    wheel::Wheel
    Robot(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct Robot

mutable struct Field <: ProtoType
    self_robots::Base.Vector{Robot}
    opponent_robots::Base.Vector{Robot}
    ball::Ball
    tick::Int32
    Field(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct Field

mutable struct Placement <: ProtoType
    robots::Base.Vector{Robot}
    ball::Ball
    Placement(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct Placement

mutable struct ControlInfo <: ProtoType
    command::Int32
    ControlInfo(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct ControlInfo

export Version, Team, ControlType, Vector2, TeamInfo, Ball, Wheel, Robot, Field, Placement, ControlInfo

# syntax: proto3
using ProtoBuf
import ProtoBuf.meta

mutable struct OnEventCall <: ProtoType
    _type::Int32
    arguments::EventArguments
    OnEventCall(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct OnEventCall

mutable struct GetTeamInfoCall <: ProtoType
    GetTeamInfoCall(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct GetTeamInfoCall

mutable struct GetTeamInfoResult <: ProtoType
    team_info::TeamInfo
    GetTeamInfoResult(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct GetTeamInfoResult

mutable struct GetInstructionCall <: ProtoType
    field::Field
    GetInstructionCall(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct GetInstructionCall

mutable struct GetInstructionResult <: ProtoType
    wheels::Base.Vector{Wheel}
    GetInstructionResult(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct GetInstructionResult

mutable struct GetPlacementCall <: ProtoType
    field::Field
    GetPlacementCall(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct GetPlacementCall

mutable struct RPCCall <: ProtoType
    on_event::OnEventCall
    get_team_info::GetTeamInfoCall
    get_instruction::GetInstructionCall
    get_placement::GetPlacementCall
    RPCCall(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct RPCCall
const __oneofs_RPCCall = Int[1,1,1,1]
const __oneof_names_RPCCall = [Symbol("method")]
meta(t::Type{RPCCall}) = meta(t, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, true, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, __oneofs_RPCCall, __oneof_names_RPCCall, ProtoBuf.DEF_FIELD_TYPES)

mutable struct GetPlacementResult <: ProtoType
    placement::Placement
    GetPlacementResult(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct GetPlacementResult

export RPCCall, OnEventCall, GetTeamInfoCall, GetTeamInfoResult, GetInstructionCall, GetInstructionResult, GetPlacementCall, GetPlacementResult

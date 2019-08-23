# syntax: proto3
using ProtoBuf
import ProtoBuf.meta

struct __enum_EventType <: ProtoEnum
    JudgeResult::Int32
    MatchStart::Int32
    MatchStop::Int32
    FirstHalfStart::Int32
    SecondHalfStart::Int32
    OvertimeStart::Int32
    PenaltyShootoutStart::Int32
    __enum_EventType() = new(0,1,2,3,4,5,6)
end #struct __enum_EventType
const EventType = __enum_EventType()

struct __enum_JudgeResultEvent_ResultType <: ProtoEnum
    PlaceKick::Int32
    GoalKick::Int32
    PenaltyKick::Int32
    FreeKickRightTop::Int32
    FreeKickRightBot::Int32
    FreeKickLeftTop::Int32
    FreeKickLeftBot::Int32
    __enum_JudgeResultEvent_ResultType() = new(0,1,2,3,4,5,6)
end #struct __enum_JudgeResultEvent_ResultType
const JudgeResultEvent_ResultType = __enum_JudgeResultEvent_ResultType()

mutable struct JudgeResultEvent <: ProtoType
    _type::Int32
    offensive_team::Int32
    reason::AbstractString
    JudgeResultEvent(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct JudgeResultEvent

mutable struct EventArguments <: ProtoType
    judge_result::JudgeResultEvent
    field::Field
    EventArguments(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct EventArguments
const __oneofs_EventArguments = Int[1,1]
const __oneof_names_EventArguments = [Symbol("argument")]
meta(t::Type{EventArguments}) = meta(t, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, true, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, __oneofs_EventArguments, __oneof_names_EventArguments, ProtoBuf.DEF_FIELD_TYPES)

export EventType, EventArguments, JudgeResultEvent_ResultType, JudgeResultEvent

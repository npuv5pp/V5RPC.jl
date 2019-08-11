module Packet

using UUIDs

const MAGIC = 0x2b2b3556
const REPLY_MASK = 0x1

mutable struct V5Packet
    magic::UInt32
    requestid::UUID
    flags::UInt8
    length::UInt16
    payload::Vector{UInt8}
end # struct

function V5Packet(payload::Vector{UInt8}, replyto::UUID)::V5Packet
    len = length(payload)
    len > typemax(UInt16) && throw(ArgumentError("Payload too large: $len"))
    V5Packet(replyto, 0, len, payload)
end

getflag(pkt, mask) = (pkt.flags & mask) != 0
setflag(pkt, mask, x) = x ? pkt.flags |= mask : pkt.flags &= ~mask

function Base.getproperty(pkt::V5Packet, sym::Symbol)
    if sym == :REPLY
        getflag(pkt, REPLY_MASK)
    else
        getfield(pkt, sym)
    end
end

function Base.setproperty!(pkt::V5Packet, sym::Symbol, x)
    if sym == :REPLY
        setflag(pkt, REPLY_MASK, x)
    else
        setfield!(pkt, sym, x)
    end
end

function Base.read(io::IO, ::Type{V5Packet})::V5Packet
    magic = read(io, UInt32)
    magic == MAGIC || throw(ErrorException("Invalid magic $magic"))
    requestid = read(io, UInt128) |> UUID
    flags = read(io, UInt8)
    len = read(io, UInt16)
    payload = read(io, length)
    V5Packet(magic, requestid, flags, len, payload)
end

function Base.write(io::IO, x::V5Packet)
    nb = write(io, x.magic)
    nb += write(io, x.requestid)
    nb += write(io, x.flags)
    nb += write(io, x.length)
    nb += write(io, x.payload)
end

end # module

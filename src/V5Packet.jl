module ModV5Packet
export V5Packet

using UUIDs

const MAGIC = 0x2b2b3556
const REPLY_MASK = 0x1

mutable struct V5Packet
    magic::UInt32
    requestid::UUID
    flags::UInt8
    length::UInt16
    payload::Vector{UInt8}

    function V5Packet(requestid, flags, payload)
        len = length(payload)
        len > typemax(UInt16) && throw(ArgumentError("Payload too large: $len"))
        new(MAGIC, requestid, flags, len, payload)
    end

end # struct

function V5Packet(payload::Vector{UInt8})::V5Packet
    V5Packet(uuid4(), 0, payload)
end

function V5Packet(payload::Vector{UInt8}, replyto::UUID)::V5Packet
    p = V5Packet(replyto, 0, payload)
    p.REPLY = true
    return p
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

function readguid(io::IO)
    a = read(io, 16)
    reverse!(a, 1, 4)
    reverse!(a, 5, 6)
    reverse!(a, 7, 8)
    reinterpret(UInt128, a)[1] |> ntoh |> UUID
end
    
function writeguid(io::IO, x::UUID)
    a = reinterpret(UInt8, [hton(x.value)])
    reverse!(a, 1, 4)
    reverse!(a, 5, 6)
    reverse!(a, 7, 8)
    write(io, a)
end

function Base.read(io::IO, ::Type{V5Packet})::V5Packet
    magic = read(io, UInt32)
    magic == MAGIC || throw(ErrorException("Invalid magic $magic"))
    requestid = readguid(io)
    flags = read(io, UInt8)
    len = read(io, UInt16)
    payload = read(io, len)
    V5Packet(requestid, flags, payload)
end

function Base.write(io::IO, x::V5Packet)
    nb = write(io, x.magic)
    nb += writeguid(io, x.requestid)
    nb += write(io, x.flags)
    nb += write(io, x.length)
    nb += write(io, x.payload)
end

end # module

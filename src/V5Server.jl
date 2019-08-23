module ModV5Server
export V5Server,run

using Sockets
using ProtoBuf
using ..V5RPC
import ..V5RPC:on_event,get_team_info
using ..PB
using ..ModV5Packet

struct V5Server
    strategy::Strategy
    endpoint::Tuple{IPAddr,Integer}
end # struct

V5Server(strategy::Strategy, port::Integer) = V5Server(strategy, (IPv4(0), port))

function recvpkt(sock::UDPSocket)
    (endpoint, data) = recvfrom(sock)
    io = IOBuffer(data)
    return (endpoint, read(io, V5Packet))
end

function sendpkt(sock::UDPSocket, pkt::V5Packet, endpoint::Sockets.InetAddr)
    io = IOBuffer()
    write(io, pkt)
    bytes = take!(io)
    send(sock, endpoint.host, endpoint.port, bytes)
end

function Base.run(srv::V5Server)
    sock = UDPSocket()
    (ip, port) = srv.endpoint
    bind(sock, ip, port) || error("Failed to bind socket on $ip:$port")
    lastid = nothing
    lastret = nothing
    try
        while true
            (ep, pkt) = recvpkt(sock)
            if pkt.requestid == lastid
                ret = lastret
            else
                ret = dispatch(srv, pkt)
                lastid = pkt.requestid
                lastret = ret
            end
            sendpkt(sock, ret, ep)
        end
    catch ex
        ex isa InterruptException || rethrow(ex)
    finally
        close(sock)
    end
end

function dispatch(srv::V5Server, pkt::V5Packet)::V5Packet
    io = PipeBuffer()
    write(io, pkt.payload)
    call = readproto(io, RPCCall())
    callsym = which_oneof(call, :method)
    callobj = get_field(call, callsym)
    params = fieldnames(typeof(callobj)) .|> n->getfield(callobj, n)
    fn = getfield(V5RPC, callsym)
    ret = fn(srv.strategy, params...)
    packed = pack(Val(callsym), ret)
    V5Packet(packed != nothing ? packed : UInt8[], pkt.requestid)
end

pack(data::ProtoType)::Vector{UInt8} = begin
    io = IOBuffer()
    writeproto(io, data)
    take!(io)
end

pack(::Val{:on_event}, data) = nothing

pack(::Val{:get_team_info}, data::TeamInfo) = pack(GetTeamInfoResult(team_info = data))
pack(m::Val{:get_team_info}, data::String) = pack(m, TeamInfo(team_name = data))

pack(::Val{:get_instruction}, data::Vector{Wheel}) = pack(GetInstructionResult(wheels = data))
function pack(m::Val{:get_instruction}, data::Vector)
    @assert length(data) == 5
    wheels = map(data) do (lspd, rspd)
        Wheel(left_speed = lspd, right_speed = rspd)
    end
    pack(m, wheels)
end

pack(::Val{:get_placement}, data::Placement) = pack(GetPlacementResult(placement = data))
function pack(m::Val{:get_placement}, data::Vector)
    @assert length(data) == 5
    robots = map(data) do (x, y, r)
        Robot(position = Vector2(x = x, y = y), rotation = r, wheel = Wheel(left_speed = 0, right_speed = 0))
    end
    ball = Ball(position = Vector2(x = 0, y = 0))
    pack(m, Placement(robots = robots, ball = ball))
end

end # module

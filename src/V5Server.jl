module ModV5Server

using Sockets
import ..V5RPC:Strategy
import ..ModV5Packet:V5Packet

struct V5Server
    strategy::Strategy
    sock::UDPSocket
end # struct

V5Server(strategy::Strategy, port::Integer) = V5Server(strategy, UDPSocket(IPv4(0), port))

Base.close(x::V5Server) = close(x.sock)

function nextpkt(srv::V5Server)::V5Packet
    data = recv(srv.sock)
    io = IOBuffer(data)
    read(io, V5Packet)
end

end # module

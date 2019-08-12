module V5RPC

(filename->include(joinpath(@__DIR__, "..", "deps", "julia_pb", filename))).(["DataStructures_pb.jl","Events_pb.jl","API_pb.jl"])

abstract type Strategy end

include("V5Packet.jl")
#V5Packet = ModV5Packet.V5Packet
include("V5Server.jl")


export Strategy

end # module

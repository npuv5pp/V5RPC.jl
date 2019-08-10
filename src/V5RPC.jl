module V5RPC

(filename->include(joinpath(@__DIR__, "..", "deps", "julia_pb", filename))).(["DataStructures_pb.jl","Events_pb.jl","API_pb.jl"])

include("V5Packet.jl")

abstract type Strategy end

export Strategy

end # module

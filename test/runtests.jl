using Test
using V5RPC
using UUIDs

@testset "V5Packet" begin
    d = Vector{UInt8}("Hello")
    i = uuid4()
    p = V5RPC.V5Packet(d, i)
    @test p.REPLY == true
    p.flags = 0x0
    @test p.REPLY == false
    io = IOBuffer()
    write(io, p)
    seekstart(io)
    q = read(io, V5RPC.V5Packet)
    @test p.requestid == q.requestid
    @test p.payload == q.payload
end #testset

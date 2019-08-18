try
    ver = readchomp(`protoc --version`)
    @info "ProtoBuf compiler found: $ver"
catch
    @warn "No ProtoBuf compiler present."
    exit()
end

using ProtoBuf

proto_path = abspath(joinpath(@__DIR__, "..", "src", "proto"))
plugin_path = abspath(joinpath(dirname(pathof(ProtoBuf)), "..", "plugin",
    Sys.iswindows() ? "protoc-gen-julia_win.bat" : "protoc-gen-julia"))
julia_out = abspath(joinpath(@__DIR__, "julia_pb"))

if !isdir(julia_out)
    mkdir(julia_out)
end

function genproto(filename)
    run(`protoc --proto_path=$proto_path --julia_out=$julia_out --plugin=protoc-gen-julia=$plugin_path $filename`)
end
@info "Generating proto files"
genproto("API.proto")

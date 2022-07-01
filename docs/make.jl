push!(LOAD_PATH,"../src/")
using BMesh
using LMesh
using Documenter

makedocs(
         sitename = "LMesh",
         modules  = [LMesh],
         pages=[
                "Home" => "index.md"
               ])
               
deploydocs(;
    versions = nothing,
    repo="github.com/CodeLenz/LMesh.jl",
)

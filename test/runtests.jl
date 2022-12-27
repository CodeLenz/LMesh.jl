using Test
#using BMesh, LMesh
using LinearAlgebra

# Material
include("test_material.jl")

# Geometry
include("test_geometry.jl")

# Base - Free_DOFs
include("test_base.jl")

# Structres
include("test_mesh.jl")

# Overload
include("test_overload.jl")

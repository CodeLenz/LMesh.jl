module LMesh

   # Dependency
   using BMesh
   using LinearAlgebra
   using Statistics:mean
   using Plots

   # Local includes
   include("overload_bmesh.jl")
   include("material.jl")
   include("geometry.jl")
   include("mesh.jl")
   include("base.jl")
   include("show.jl")

   # Exports
   export Conec,Coord,Length,DOFs,T_matrix
   export Material, Geometry
   export Mesh, Mesh2D, Mesh3D
   export Free_DOFs, Nodal_coordinates, Centroid
   export plot

end # module LMesh

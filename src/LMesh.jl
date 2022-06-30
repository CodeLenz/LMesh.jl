module LMesh

   # Dependency
   using BMesh
   using LinearAlgebra
   using Statistics:mean
   using Plots

   # Local includes

   include("mesh.jl")
   include("material.jl")
   include("geometry.jl")
   
   include("overload_bmesh.jl")
   include("base.jl")
   include("show.jl")

   # Exports
   export Mesh, Mesh2D, Mesh3D
   export Material, Geometry
   export Conec,Coord,Length,DOFs,T_matrix
   export Free_DOFs, Nodal_coordinates, Centroid
   export plot

end # module LMesh

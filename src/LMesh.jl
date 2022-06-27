module LMesh

   # Dependency
   using BMesh
   using LinearAlgebra
   using Plots

   # Local includes
   include("material.jl")
   include("geometry.jl")
   include("mesh.jl")
   include("base.jl")
   include("show.jl")

   # Exports
   export Material, Geometry
   export Mesh, Mesh2D, Mesh3D
   export Free_DOFs, Nodal_coordinates
   export plot

end # module LMesh

module LMesh

   # Dependency
   using BMesh
   using LinearAlgebra

   # Local includes
   include("material.jl")
   include("geometry.jl")
   include("mesh.jl")
   include("base.jl")

   # Exports
   export Material, Geometry
   export Mesh, Mesh2D, Mesh3D
   export Free_DOFs

end # module LMesh

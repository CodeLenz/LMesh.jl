module LMesh

   # Dependency
   using BMesh
   using LinearAlgebra
   using Statistics:mean
   using Plots

   # Local includes


   include("material.jl")
   include("geometry.jl")
   include("mesh.jl")
   include("iterator.j")
   
   include("overload_bmesh.jl")
   include("base.jl")
   include("show.jl")

   # Exports
   export Material, Geometry
   export Mesh, Mesh2D, Mesh3D
   export iterator
   export Conect,Coord,Length,DOFs,T_matrix
   export Free_DOFs, Nodal_coordinates, Centroid
   export Get_dim, Get_etype, Get_eclass
   export Get_material, Get_geometry
   export Get_material_number, Get_geometry_number
   export plot

end # module LMesh

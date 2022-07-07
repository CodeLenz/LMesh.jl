module LMesh

   # Dependency
   using BMesh
   using LinearAlgebra
   using Statistics:mean
   using Plots

   if isdefined(Base, :Experimental) && isdefined(Base.Experimental, Symbol("@optlevel"))
       @eval Base.Experimental.@optlevel 3
   end


   # Local includes
   include("material.jl")
   include("geometry.jl")
   include("mesh.jl")
   include("iterator.jl")
   
   include("overload_bmesh.jl")
   include("base.jl")
   include("show.jl")

   # Exports
   export Material, Geometry
   export Mesh, Mesh2D, Mesh3D
   export iterator
   export Conect,Coord,Length,DOFs,T_matrix
   export Free_DOFs, Nodal_coordinates, Centroid
   export Find_node, Find_nodes_in_rectangle, Find_nodes_in_box
   export Get_dim, Get_etype, Get_eclass
   export Get_material, Get_geometry
   export Get_material_number, Get_geometry_number
   export Get_ne, Get_nn
   export plot

   
end # module LMesh

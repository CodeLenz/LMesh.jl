
abstract type Mesh end

mutable struct Mesh2D <: Mesh

   # Background mesh 
   bmesh::Bmesh2D

   # Materials
   nmat::Int64
   materials::Vector{Material}

   # Geometries
   ngeom::Int64
   geometries::Vector{Geometry}

   # Supports (essential boundary conditions)
   # node gl value
   nebc::Int64
   ebc::Matrix{Float64}

   # Point Loads (natural boundary conditions)
   # node gl value
   nnbc::Int64
   nbc::Matrix{Float64}

   # Free dofs
   ngls::Int64
   free_dofs::Vector{Int64}
 
   # Dictionary
   options::Dict{Symbol,Matrix{Float64}}

   # Default constructor
   function Mesh2D(bmesh::Bmesh2D,materials::Vector{Material},
                   geometries::Vector{Geometry},ebc::Matrix{Float64},
                   nbc::Matrix{Float64};options=Dict{Symbol,Matrix{Float64}}())
    
            # Dimensions
            nmat = length(materials)
            ngeo = length(geometries)
            nebc = size(ebc,1)
            nnbc = size(nbc,1)

            # Basic tests
            nmat>=1 || throw("Mesh2D::number of material properties must be >=1")
            ngeo>=1 || throw("Mesh2D::number of geometries properties must be >=1")
            nebc>=3 || throw("Mesh2D:: at least three essential boundary conditions are needed in 2D ")
           
            # Free dofs and effective number of gls
            free_dofs, ngls = Free_DOFs(bmesh,nebc,ebc)

            # Create the type
            new(bmesh,nmat,materials,ngeo,geometries,nebc,ebc,nnbc,nbc,ngls,free_dofs,options)
   end
end



mutable struct Mesh3D <: Mesh

   # Background mesh 
   bmesh::Bmesh3D

   # Materials
   nmat::Int64
   materials::Vector{Material}

   # Geometries
   ngeom::Int64
   geometries::Vector{Geometry}

   # Supports (essential boundary conditions)
   # node gl value
   nebc::Int64
   ebc::Matrix{Float64}

   # Point Loads (natural boundary conditions)
   # node gl value
   nnbc::Int64
   nbc::Matrix{Float64}

   # Free dofs
   ngls::Int64
   free_dofs::Vector{Int64}

   # Dictionary
   options::Dict{Symbol,Matrix{Float64}}

   # Default constructor
   function Mesh3D(bmesh::Bmesh3D,materials::Vector{Material},
                   geometries::Vector{Geometry},ebc::Matrix{Float64},
                   nbc::Matrix{Float64};options=Dict{Symbol,Matrix{Float64}}())

      # Dimensions
      nmat = length(materials)
      ngeo = length(geometries)
      nebc = size(ebc,1)
      nnbc = size(nbc,1)

      # Basic tests
      nmat>=1 || throw("Mesh3D::number of material properties must be >=1")
      ngeo>=1 || throw("Mesh3D::number of geometries properties must be >=1")
      nebc>=6 || throw("Mesh3D:: at least six essential boundary conditions are needed in 3D ")

      # Free dofs and effective number of gls
      free_dofs, ngls = Free_DOFs(bmesh,nebc,ebc)

      # Create the type
      new(bmesh,nmat,materials,ngeo,geometries,nebc,ebc,nnbc,nbc,ngls,free_dofs,options)
   end

end


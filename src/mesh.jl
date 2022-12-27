"""
  Supertype for Mesh2D and Mesh3D

"""
abstract type Mesh end

"""
Basic structure for 2D Meshes

   Mesh2D(bmesh::Bmesh2D,materials::Vector{Material},
          geometries::Vector{Geometry},hebc::Matrix{Int64},
          nbc::Matrix{Float64} ;
          mat_ele = Int64[], geo_ele = Int64[], 
          options=Dict{Symbol,Matrix{Float64}}())

where <br/>

   bmesh      = Background mesh (2D) <br/>

   materials  = Vector with Materials definitions

   geometries = Vector with Geometries definitions

   hebc        = Matrix with homogeneous essential boundary conditions

   nbc        = Matrix with natural boundary conditions

   mat_ele    = Vector linking each element to a given material

   geo_ele    = Vector linking each element to a given geometry

   options    = Dictionary with optional data
"""
mutable struct Mesh2D <: Mesh

   # Background mesh 
   bmesh::Bmesh2D

   # Materials
   nmat::Int64
   materials::Vector{Material}

   # Geometries
   ngeom::Int64
   geometries::Vector{Geometry}

   # Number of load cases
   nload::Int64

   # Supports (essential boundary conditions)
   # node gl value loadcase
   nhebc::Int64
   ebc::Matrix{Int64}

   # Point Loads (natural boundary conditions)
   # node gl value loadcase 
   nnbc::Int64
   nbc::Matrix{Float64}

   # Free dofs
   ngls::Vector{Int64}
   free_dofs::Vector{Vector{Int64}}

   # Map element to material
   mat_ele::Vector{Int64}
  
   # Map element to geometry
   geo_ele::Vector{Int64}
  
   # Dictionary
   options::Dict{Symbol,Matrix{Float64}}

   # Default constructor
   function Mesh2D(bmesh::Bmesh2D,materials::Vector{Material},
                   geometries::Vector{Geometry},hebc::Matrix{Int64},
                   nbc::Matrix{Float64} ;
                   mat_ele = Int64[], geo_ele = Int64[], 
                   options=Dict{Symbol,Matrix{Float64}}())
    
            # Dimensions
            nmat  = length(materials)
            ngeo  = length(geometries)
            nhebc = size(hebc,1)
            nnbc  = size(nbc,1)
    
            # Basic tests
            nmat>=1  || throw("Mesh2D::number of material properties must be >=1")
            ngeo>=1  || throw("Mesh2D::number of geometries properties must be >=1")
            nhebc>=3 || throw("Mesh2D:: at least three homogeneous essential boundary conditions are needed in 2D ")

            
            # Process mat_ele 
            if isempty(mat_ele)
               resize!(mat_ele,bmesh.ne)
               fill!(mat_ele,1)
            else
               length(mat_ele)==bmesh.ne || throw("Mesh2D::mat_ele should have the same size of the number of elements")
               minimum(mat_ele)>0 || throw("Mesh2D::mat_ele should point to a valid material (>0)")
               maximum(mat_ele)<=nmat || throw("Mesh2D::mat_ele should point to a valid material (<$nmat)")
            end
      
            # Process geo_ele 
            if isempty(geo_ele)
               resize!(geo_ele,bmesh.ne)
               fill!(geo_ele,1)
            else
               length(geo_ele)==bmesh.ne || throw("Mesh2D::geo_ele should have the same size of the number of elements")
               minimum(geo_ele)>0 || throw("Mesh2D::geo_ele should point to a valid geometry (>0)")
               maximum(geo_ele)<=ngeo || throw("Mesh2D::geo_ele should point to a valid geometry (<$ngeo)")
            end
      
            # Compatibility with older versions
            # nbc has 3 collumns (node,dof,value)
            # if it is the case, add a fourth column with ones - loadcases
            if size(nbc,2)==3 
               nbc = [nbc ones(nnbc)]
            end
           
            # Some basic assertions to hebc
            for i=1:nhebc
               0<hebc[i,1]<= bmesh.nn || throw("Mesh2D:: ebc line $i :: incorrect node ")
               0<hebc[i,2]<= 2        || throw("Mesh2D:: ebc line $i :: incorrect dof ")
            end   

            # Some basic assertions to nbc
            for i=1:nnbc
               0<nbc[i,1]<= bmesh.nn || throw("Mesh2D:: nbc line $i :: incorrect node ")
               0<nbc[i,2]<= 2        || throw("Mesh2D:: nbc line $i :: incorrect dof ")
               0<=nbc[i,4]           || throw("Mesh2D:: nbc line $i :: incorrect load case ")
            end   

            # Find the maximum loadcase
            max_load_nbc = maximum(nbc[:,4])
            nload = Int(max_load_nbc)

            # Now both ngl and free_dofs will be
            ngls = Int64[]
            free_dofs = Vector{Int64}[]

            # Free dofs and effective number of gls
            for load=1:nload
               freedo, ngl = Free_DOFs(bmesh,nhebc,hebc,load)
               push!(ngls,ngl)
               push!(free_dofs,freedo)
            end 

            # Create the type
            new(bmesh,nmat,materials,ngeo,geometries,nload,nhebc,hebc,nnbc,nbc,ngls,free_dofs,mat_ele,geo_ele,options)
   end
end


"""
Basic structure for 3D Meshes

   Mesh3D(bmesh::Bmesh3D,materials::Vector{Material},
          geometries::Vector{Geometry},hebc::Matrix{Int64},
          nbc::Matrix{Float64} ;
          mat_ele = Int64[], geo_ele = Int64[], 
          options=Dict{Symbol,Matrix{Float64}}())

where

   bmesh      = Background mesh (3D)

   materials  = Vector with Materials definitions

   geometries = Vector with Geometries definitions

   hebc        = Matrix with homogeneous essential boundary conditions

   nbc        = Matrix with natural boundary conditions

   mat_ele    = Vector linking each element to a given material

   geo_ele    = Vector linking each element to a given geometry

   options    = Dictionary with optional data
"""
mutable struct Mesh3D <: Mesh

   # Background mesh 
   bmesh::Bmesh3D

   # Materials
   nmat::Int64
   materials::Vector{Material}

   # Geometries
   ngeom::Int64
   geometries::Vector{Geometry}

   # Number of load cases
   nload::Int64

   # Supports (essential boundary conditions)
   # node gl value loadcase
   nhebc::Int64
   hebc::Matrix{Int64}

   # Point Loads (natural boundary conditions)
   # node gl value loadcase
   nnbc::Int64
   nbc::Matrix{Float64}

   # Free dofs
   ngls::Vector{Int64}
   free_dofs::Vector{Vector{Int64}}

   # Map element to material
   mat_ele::Vector{Int64}
  
   # Map element to geometry
   geo_ele::Vector{Int64}
 
   # Dictionary
   options::Dict{Symbol,Matrix{Float64}}

   # Default constructor
   function Mesh3D(bmesh::Bmesh3D,materials::Vector{Material},
                   geometries::Vector{Geometry},hebc::Matrix{Int64},
                   nbc::Matrix{Float64} ;
                   mat_ele = Int64[], geo_ele = Int64[] ,  options=Dict{Symbol,Matrix{Float64}}())

      # Dimensions
      nmat  = length(materials)
      ngeo  = length(geometries)
      nhebc = size(hebc,1)
      nnbc  = size(nbc,1)

      # Basic tests
      nmat>=1  || throw("Mesh3D::number of material properties must be >=1")
      ngeo>=1  || throw("Mesh3D::number of geometries properties must be >=1")
      nhebc>=5 || throw("Mesh3D:: at least five homogeneous essential boundary conditions are needed in 3D ")

      
      # Process mat_ele and geo_ele
      if isempty(mat_ele)
         resize!(mat_ele,bmesh.ne)
         fill!(mat_ele,1)
      else
          length(mat_ele)==bmesh.ne || throw("Mesh3D::mat_ele should have the same size of the number of elements")
          minimum(mat_ele)>0 || throw("Mesh3D::mat_ele should point to a valid material (>0)")
          maximum(mat_ele)<=nmat || throw("Mesh3D::mat_ele should point to a valid material (<$nmat)")
      end
      
      # Process geo_ele 
      if isempty(geo_ele)
          resize!(geo_ele,bmesh.ne)
          fill!(geo_ele,1)
      else
          length(geo_ele)==bmesh.ne || throw("Mesh3D::geo_ele should have the same size of the number of elements")
          minimum(geo_ele)>0 || throw("Mesh2D::geo_ele should point to a valid geometry (>0)")
          maximum(geo_ele)<=ngeo || throw("Mesh2D::geo_ele should point to a valid geometry (<$ngeo)")
       end

      # Compatibility with older versions
      # nbc has 3 collumns (node,dof,value)
      # if it is the case, add a fourth column with ones - loadcases
      if size(nbc,2)==3 
          nbc = [nbc ones(nnbc)]
      end
      
      # Some basic assertions to ebc
      for i=1:nhebc
         0<hebc[i,1]<= bmesh.nn || throw("Mesh3D:: hebc line $i :: incorrect node ")
         0<hebc[i,2]<= 3        || throw("Mesh3D:: hebc line $i :: incorrect dof ")
      end   

      # Some basic assertions to nbc
      for i=1:nnbc
         0<nbc[i,1]<= bmesh.nn || throw("Mesh3D:: nbc line $i :: incorrect node ")
         0<nbc[i,2]<= 3        || throw("Mesh3D:: nbc line $i :: incorrect dof ")
         0<=nbc[i,4]           || throw("Mesh3D:: nbc line $i :: incorrect load case ")
      end   

      # Find the maximum loadcase
      max_load_nbc = maximum(nbc[:,4])
      nload = Int(max_load_nbc)

      # Now both ngl and free_dofs will be
      ngls = Int64[]
      free_dofs = Vector{Int64}[]

      # Free dofs and effective number of gls
      for load=1:nload
          freedo, ngl = Free_DOFs(bmesh,nhebc,hebc,load)
          push!(ngls,ngl)
          push!(free_dofs,freedo)
      end 

      # Create the type
      new(bmesh,nmat,materials,ngeo,geometries,nload,nhebc,hebc,nnbc,nbc,ngls,free_dofs,mat_ele,geo_ele,options)
   end

end


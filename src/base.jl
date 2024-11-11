
#
# Usando os dados de apoios, monta o vetor de gls livres do problema
#
"""
Return a vector with all the free (not constrained) DOFs in the mesh. 
This function is used to build Mesh.free_dofs

   Free_DOFs(bmesh::Bmesh2D,nhebc::Int64,hebc::Matrix{Int64},loadcase::Int64)

where

   bmesh    = background mesh
   nhebc     = number of essential boundary conditions
   hebc      = matrix with essential boundary condition data
   loadcase = the load case to consider
"""
function Free_DOFs(bmesh::Bmesh2D,nhebc::Int64,hebc::Matrix{Int64},loadcase::Int64)
  
  # Dimensão da malha
  nnos = bmesh.nn

  # Se for 2D ou 3D mudamos o número de gls por nó
  dim = 2
  
  # Gerar um vetor de 1 até dim*nnos
  todos = collect(1:dim*nnos)
   

  # Olha quem está sendo preso e coloca um -1 no lugar
  # Verifica loadcase
  @inbounds for i=1:nhebc
       no   = hebc[i,1]
       gl   = hebc[i,2]
       todos[dim*(no-1)+gl] = -1
  end     
   
  # Pega todos os valores que são maiores do que zero
  livres = todos[todos.>0]

  return livres, length(livres)
     
end



"""
Return a vector with all the free (not constrained) DOFs in the mesh. 
This function is used to build Mesh.free_dofs

   Free_DOFs(bmesh::Bmesh3D,nhebc::Int64,hebc::Matrix{Int64},loadcase::Int64)

where

   bmesh    = background mesh
   nhebc     = number of homogeneous essential boundary conditions
   hebc      = matrix with homogeneous essential boundary condition data
   loadcase = the load case to consider
"""
function Free_DOFs(bmesh::Bmesh3D,nhebc::Int64,hebc::Matrix{Int64},loadcase::Int64)
  
  # Dimensão da malha
  nnos = bmesh.nn

  # Dimension
  dim = 3

  # Gerar um vetor de 1 até dim*nnos
  todos = collect(1:dim*nnos)
   
  # Olha quem está sendo preso e coloca um -1 no lugar
  # Verifica loadcase
  @inbounds for i=1:nhebc
       no   = hebc[i,1]
       gl   = hebc[i,2]
       todos[dim*(no-1)+gl] = -1
  end     
   
  # Pega todos os valores que são maiores do que zero
  livres = todos[todos.>0]

  return livres, length(livres)
     
end



#
# Dimensionality 
#
"""
Return 2 for 2D problems and 3 for 3D problems
   
   Get_dim(mesh::Mesh)

"""
@inline function Get_dim(mesh::Mesh2D)
  
    return 2 
  
end

@inline function Get_dim(mesh::Mesh3D)
  
   return 3 
 
end


#
# Element type
#
"""
Return element type
   
   Get_etype(mesh::Mesh)

"""
@inline function Get_etype(mesh::Mesh)
  
    mesh.bmesh.etype
  
end

#
# Element class
#
"""
Return truss or solid
   
   Get_eclass(mesh::Mesh)

"""
function Get_eclass(mesh::Mesh)
  
    etype = Get_etype(mesh)
    ifelse(etype==:solid2D || etype==:solid3D, :solid,  :truss)
   
end


#
# Return material number for element ele
#
"""
Material number for element ele

   Get_material(mesh::Mesh,ele::Int64)

"""
@inline function Get_material_number(mesh::Mesh,ele::Int64)
   mesh.mat_ele[ele]
end

#
# Return material data for element ele
#
"""
Material data for element ele

   Get_material(mesh::Mesh,ele::Int64)

"""
function Get_material(mesh::Mesh,ele::Int64)
   mn = Get_material_number(mesh,ele)
   mesh.materials[mn]
end


#
# Return geometry number for element ele
#
"""
Geometry number for element ele

   Get_geometry_number(mesh::Mesh,ele::Int64)

"""
@inline function Get_geometry_number(mesh::Mesh,ele::Int64)
   mesh.geo_ele[ele]
end

#
# Return geometry data for element ele
#
"""
Geometry data for element ele

   Get_geometry(mesh::Mesh,ele::Int64)

"""
function Get_geometry(mesh::Mesh,ele::Int64)
   gn = Get_geometry_number(mesh,ele)
   mesh.geometries[gn]
end


"""
Number of elements in this mesh

   Get_ne(mesh::Mesh)

"""
@inline function Get_ne(mesh::Mesh)
   mesh.bmesh.ne
end

"""
Number of nodes in this mesh

   Get_nn(mesh::Mesh)

"""
@inline function Get_nn(mesh::Mesh)
   mesh.bmesh.nn
end


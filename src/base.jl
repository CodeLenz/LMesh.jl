
#
# Usando os dados de apoios, monta o vetor de gls livres do problema
#
"""
Return a vector with all the free (not constrained) DOFs in the mesh. 
This function is used to build Mesh.free_dofs

   Free_DOFs(bmesh::Bmesh,nebc::Int64,ebc::Matrix{Float64})

where

   bmesh    = background mesh
   nebc     = number of essential boundary conditions
   ebc      = matrix with essential boundary condition data
"""
function Free_DOFs(bmesh::Bmesh,nebc::Int64,ebc::Matrix{Float64})
  
  # Dimensão da malha
  nnos = bmesh.nn

  # Se for 2D ou 3D mudamos o número de gls por nó
  dim = 2
  if isa(bmesh,Bmesh3D)
    dim=3
  end

  # Gerar um vetor de 1 até dim*nnos
  todos = collect(1:dim*nnos)
   
  # Olha quem está sendo preso e coloca um -1 no lugar
  @inbounds for i=1:nebc
       no = Int(ebc[i,1])
       gl = Int(ebc[i,2])
       todos[dim*(no-1)+gl] = -1
  end     
   
  # Pega todos os valores que são maiores do que zero
  livres = todos[todos.>0]

  return livres, length(livres)
     
end

#
# Find the coordinates x and y of a given element
#
"""
Return vectors x and y with the nodal coordinates of element ele

   Nodal_coordinates(m::Mesh2D,ele)

where m is a 2D Mesh and ele a valid element.
"""
function Nodal_coordinates(m::Mesh2D,ele)

    # Alias
    bm = m.bmesh

    # Nodes
    nodes = Connect(bm,ele)

    # Number of nodes
    nn = length(nodes)

    # Coordinates 
    x = Vector{Float64}(undef,nn)
    y = Vector{Float64}(undef,nn)
    @inbounds for i=1:nn

        # Local coordinates
        x[i],y[i] = Coord(bm,nodes[i])

    end

   return x, y
end


#
# Find the coordinates x and y of a given element
#
"""
Return vectors x, y and z with the nodal coordinates of element ele

   Nodal_coordinates(m::Mesh3D,ele)

where m is a 3D Mesh and ele a valid element.
"""
function Nodal_coordinates(m::Mesh3D,ele)

    # Alias
    bm = m.bmesh

    # Nodes
    nodes = Connect(bm,ele)

    # Number of nodes
    nn = length(nodes)

    # Coordinates 
    x = Vector{Float64}(undef,nn)
    y = Vector{Float64}(undef,nn)
    z = Vector{Float64}(undef,nn)
    
    @inbounds for i=1:nn

        # Local coordinates
        x[i],y[i],z[i] = Coord(bm,nodes[i])

    end

   return x, y, z
end

# Centroid for a given element
"""
Return a vector with the centroidal coordinates of element ele

   Centroid(mesh::Mesh2D,ele::Int64)

"""
function Centroid(mesh::Mesh2D,ele::Int64)

    # Coordinates
    x,y = Nodal_coordinates(mesh,ele)

    # Return mean values
    [mean(x); mean(y)]

end

# Centroid for a given element
"""
Return a vector with the centroidal coordinates of element ele

   Centroid(mesh::Mesh3D,ele::Int64)
   
"""
function Centroid(mesh::Mesh3D,ele)

    # Coordinates
    x,y,z = Nodal_coordinates(mesh,ele)

    # Return mean values
    [mean(x); mean(y); mean(z)]

end

#
# Dimensionality 
#
"""
Return 2 for 2D problems and 3 for 3D problems
   
   Get_dim(mesh::Mesh)

"""
function Get_dim(mesh::Mesh)
  
    ifelse(isa(mesh,Mesh2D),2,3)
  
end

#
# Element type
#
"""
Return element type
   
   Get_etype(mesh::Mesh)

"""
function Get_etype(mesh::Mesh)
  
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
  
    class = :truss
    etype = Get_etype(mesh)
    if etype==:solid2D || etype==:solid3D
       class = :solid
    end
    return class
end


#
# Return material number for element ele
#
"""
Material number for element ele

   Get_material(mesh::Mesh,ele::Int64)

"""
function Get_material_number(mesh::Mesh,ele::Int64)
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
function Get_geometry_number(mesh::Mesh,ele::Int64)
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
function Get_ne(mesh::Mesh)
   mesh.bmesh.ne
end

"""
Number of nodes in this mesh

   Get_nn(mesh::Mesh)

"""
function Get_nn(mesh::Mesh)
   mesh.bmesh.nn
end

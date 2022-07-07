#
# Overload some functions defined in BMesh
#
import BMesh:Connect
"""
(Overloaded from BMesh)
Return the connectivities of element ele

    Connect(mesh::Mesh,ele::Int64)

as an Int64 vector.  
"""
function Connect(mesh::Mesh,ele::Int64)

    BMesh.Connect(mesh.bmesh,ele)

end


import BMesh:Coord
"""
(Overloaded from BMesh)
Return the coordinates of node 

    Coord(mesh::Mesh,node::Int64)

as a vector [x;y;(z)]
"""
function Coord(mesh::Mesh,node::Int64)

   BMesh.Coord(mesh.bmesh,node)
    
end

import BMesh:Length
"""
(Overloaded from BMesh)
Return the distance between two nodes of the element

    Length(mesh::Mesh,ele::Int64;nodes=(1,2))

where the default is the distance between (local) nodes 1 and 2
"""
function Length(mesh::Mesh,ele::Int64;nodes=(1,2))

    BMesh.Length(mesh.bmesh,ele;nodes=nodes)

end


import BMesh:DOFs
"""
(Overloaded from BMesh)
Return a dim*n vector with the global DOFs of element ele

    DOFs(mesh::Mesh,ele::Int64)

where n is the number of nodes of ele and dim=2 or 3.
"""
function DOFs(mesh::Mesh,ele::Int64)

    BMesh.DOFs(mesh.bmesh,ele)

end


import BMesh.Nodal_coordinates
"""
Return vectors x and y with the nodal coordinates of element ele

   Nodal_coordinates(mesh::Mesh2D,ele::Int64)

where mesh is a 2D Mesh and ele a valid element.
"""
function Nodal_coordinates(mesh::Mesh2D,ele::Int64)
    BMesh.Nodal_coordinates(mesh.bmesh,ele)
end

"""
Return vectors x, y and z with the nodal coordinates of element ele

   Nodal_coordinates(mesh::Mesh3D,ele::Int64)

where mesh is a 3D Mesh and ele a valid element.
"""
function Nodal_coordinates(mesh::Mesh3D,ele::Int64)
    BMesh.Nodal_coordinates(mesh.bmesh,ele)
end


import BMesh:Centroid
"""
Return a vector with the centroidal coordinates of element ele

   Centroid(mesh::Mesh2D,ele::Int64)

"""
function Centroid(mesh::Mesh2D,ele::Int64)
    Centroid(mesh.bmesh,ele)
end

"""
Return a vector with the centroidal coordinates of element ele

   Centroid(mesh::Mesh3D,ele::Int64)

"""
function Centroid(mesh::Mesh3D,ele::Int64)
    Centroid(mesh.bmesh,ele)
end


import BMesh:T_matrix
"""
(Overloaded from BMesh)
Evaluate the rotation matrix T that maps from global to local reference systems. This version
evaluates Rotation internally.

    T_matrix(mesh::Mesh, ele::Int64, α=0.0)

"""
function T_matrix(mesh::Mesh, ele::Int64, α=0.0)
    
    BMesh.T_matrix(mesh.bmesh,ele,α)
    
end


"""
(Overloaded from BMesh)
Find the closest node to a given coordinate (x,y)

    Find_node(mesh::Mesh2D,x,y;atol=1E-5)


"""
import BMesh.Find_node
function Find_node(mesh::Mesh,x::Float64,y::Float64;atol=1E-5)
   BMesh.Find_node(mesh.bmesh,x,y,atol=atol)
end


"""
(Overloaded from BMesh)
Find the closest node to a given coordinate (x,y,z)

    Find_node(mesh::Mesh3D,x,y,z;atol=1E-5)


"""
function Find_node(mesh::Mesh3D,x::Float64,y::Float64,z::Float64;atol=1E-5)
   BMesh.Find_node(mesh.bmesh,x,y,z,atol=atol)
end


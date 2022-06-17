# LMesh
Basic building block for other codes

```julia

using BMesh, LMesh

#Create two backgound meshes
b2 = Bmesh_truss_2D(1.0,2,1.0,2)
b3 = Bmesh_truss_3D(1.0,2,1.0,2,1.0,2)

#Create a vector with two materials
mat = [Material(Ex=210E9) ; Material(Ex=110E9)]

#Create a vector with two geometries
geo = [Geometry(A=1E-4) ; Geometry(A=1E-5)]

#Supports for 2D
apoios2 = [1 1 0.0 ; 1 2 0.0; 2 1 0.0; 2 2 0.0]

#Supports for 3D
apoios3 = [1 1 0.0 ; 1 2 0.0; 1 3 0.0;
           2 1 0.0;  2 2 0.0; 2 3 0.0]


#Point loads
forcas = [4 2 100.0 ; 4 1 -100.0]

#Create a 2D mesh
m2D = Mesh2D(b2,mat,geo,apoios2,forcas)

#Create a 3D mesh
m3D = Mesh3D(b3,mat,geo,apoios3,forcas)

```

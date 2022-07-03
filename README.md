# LMesh
Basic building block for other codes

https://codelenz.github.io/LMesh.jl/

Basic example - 2D
```julia

using BMesh, LMesh, Plots

# Create a background mesh
b2 = Bmesh_truss_2D(1.0,2,1.0,2)

# Create a vector with material definitions
mat = [Material(Ex=210E9,density=7850.0) ]

# Create a vector with  geometry dedfinitions
geo = [Geometry(A=1E-4)]

# Essential boundary conditions (Supports)
ebc = [1 1 0.0 ; 1 2 0.0; 2 1 0.0; 2 2 0.0]

# Point loads
forces = [4 2 100.0 ; 4 1 -100.0]

# Create a 2D mesh
m2D = Mesh2D(b2,mat,geo,ebc,forces)

# Plots:plot is also overloaded and shows 
# both essential and natural boundary conditions
plot(m2D)

```

Basic example - 2D with more than one material and geometry 
```julia

using BMesh, LMesh, Plots

# Create a background mesh
b2 = Bmesh_truss_2D(1.0,2,1.0,2)

# Create a vector with two materials
mat = [Material(Ex=210E9,density=7850.0) ; Material(Ex=110E9,density=4150.0)]

# Create a vector with two geometries
geo = [Geometry(A=1E-4) ; Geometry(A=1E-5)]

# Essential boundary conditions (Supports)
ebc = [1 1 0.0 ; 1 2 0.0; 2 1 0.0; 2 2 0.0]

# Point loads
forces = [4 2 100.0 ; 4 1 -100.0]

# Map elements 1 to 6 to the second material
mat = ones(b2.ne)
mat[1:6] .= 2

# Map elements 7 to 12 to the second geometry
geo = ones(b2.ne)
geo[7:12] .= 2

# Create a 2D mesh
m2D = Mesh2D(b2,mat,geo,ebc,forces,mat_ele=mat, geo_ele=geo)

# Plots:plot is also overloaded and shows 
# both essential and natural boundary conditions
plot(m2D)

```

3D mesh with optional arguments (Dictionary)
```julia

using BMesh, LMesh, Plots

# Create the backgound meshe
b3 = Bmesh_truss_3D(1.0,2,1.0,2,1.0,2)

# Create a vector with material definitions
mat = [Material(Ex=210E9,density=7850.0) ]

# Create a vector with  geometry dedfinitions
geo = [Geometry(A=1E-4)]

# Essential boundary conditions (Supports)
ebc = [1 1 0.0 ; 1 2 0.0; 1 3 0.0;
       2 1 0.0;  2 2 0.0; 2 3 0.0]

# Point loads
forces = [4 2 100.0 ; 4 1 -100.0]

#Create a 3D mesh
m3D = Mesh3D(b3,mat,geo,ebc,forces)

# It is possible to define general inputs 
# as a dictionary {Symbol,Matrix{Float64}}
options = Dict{Symbol,Matrix{Float64}}()

options[:Stiffness] = [1 1 1E5 ; 10 1 1E3]
options[:Displacement] = [1 1 1E-3]

m3opt = Mesh3D(b3,mat,geo,apoios2,forcas; options=options)

# Plots:plot is also overloaded and shows 
# both essential and natural boundary conditions
plot(m3D)



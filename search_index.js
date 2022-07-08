var documenterSearchIndex = {"docs":
[{"location":"#LMesh.jl","page":"Home","title":"LMesh.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"*Basic building block for other codes *","category":"page"},{"location":"#Basic-types","page":"Home","title":"Basic types","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Mesh","category":"page"},{"location":"#LMesh.Mesh","page":"Home","title":"LMesh.Mesh","text":"Supertype for Mesh2D and Mesh3D\n\n\n\n\n\n","category":"type"},{"location":"","page":"Home","title":"Home","text":"Mesh2D","category":"page"},{"location":"#LMesh.Mesh2D","page":"Home","title":"LMesh.Mesh2D","text":"Basic structure for 2D Meshes\n\nMesh2D(bmesh::Bmesh2D,materials::Vector{Material},           geometries::Vector{Geometry},ebc::Matrix{Float64},           nbc::Matrix{Float64} ;           matele = Int64[], geoele = Int64[],            options=Dict{Symbol,Matrix{Float64}}())\n\nwhere <br/>\n\nbmesh      = Background mesh (2D) <br/>\n\nmaterials  = Vector with Materials definitions\n\ngeometries = Vector with Geometries definitions\n\nebc        = Matrix with essential boundary conditions\n\nnbc        = Matrix with natural boundary conditions\n\nmat_ele    = Vector linking each element to a given material\n\ngeo_ele    = Vector linking each element to a given geometry\n\noptions    = Dictionary with optional data\n\n\n\n\n\n","category":"type"},{"location":"","page":"Home","title":"Home","text":"Mesh3D","category":"page"},{"location":"#LMesh.Mesh3D","page":"Home","title":"LMesh.Mesh3D","text":"Basic structure for 3D Meshes\n\nMesh3D(bmesh::Bmesh3D,materials::Vector{Material},           geometries::Vector{Geometry},ebc::Matrix{Float64},           nbc::Matrix{Float64} ;           matele = Int64[], geoele = Int64[],            options=Dict{Symbol,Matrix{Float64}}())\n\nwhere\n\nbmesh      = Background mesh (3D)\n\nmaterials  = Vector with Materials definitions\n\ngeometries = Vector with Geometries definitions\n\nebc        = Matrix with essential boundary conditions\n\nnbc        = Matrix with natural boundary conditions\n\nmat_ele    = Vector linking each element to a given material\n\ngeo_ele    = Vector linking each element to a given geometry\n\noptions    = Dictionary with optional data\n\n\n\n\n\n","category":"type"},{"location":"#Iterator","page":"Home","title":"Iterator","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"iterate","category":"page"},{"location":"#Base.iterate","page":"Home","title":"Base.iterate","text":"Iterator for Mesh.      Iterates from 1 to the number of elements in the mesh.      To be used in loops like           for ele in m             ...          end   \n\n\n\n\n\n","category":"function"},{"location":"#Material","page":"Home","title":"Material","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Material","category":"page"},{"location":"#LMesh.Material","page":"Home","title":"LMesh.Material","text":"Basic structure to store material data\n\nMaterial(;Ex=1.0,νxy=0.0, α_T=0.0, density=1.0, model=:EPT,\n          limit_stress=1.0, α_c=0.0,β_c=0.0,\n          custom=[1.0 1.0 ; 1.0 1.0])\n\nwhere all inputs are named. \n\nEx = Young's mudule (in X) [Pa] νxy = Poisson's ratio αT = Thermal expansion 1/Temperature density = material density [Kg/m³] model =  2D elasticity (:EPT or :EPD) or :Custom  limitstress = limit stress (von-Mises criteria) [Pa] αc = Mass parameter for proportional damping βc = Stiffness parameter for proportional damping\n\nCustom is a custom constitutive Matrix given  by the user. \n\n\n\n\n\n","category":"type"},{"location":"#Geometry","page":"Home","title":"Geometry","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Geometry","category":"page"},{"location":"#LMesh.Geometry","page":"Home","title":"LMesh.Geometry","text":"Basic structure to store geometrical data\n\nGeometry(;A=1.0,thickness=1.0)\n\nwhere all inputs are named.\n\n\n\n\n\n","category":"type"},{"location":"#Base","page":"Home","title":"Base","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Free_DOFs","category":"page"},{"location":"#LMesh.Free_DOFs","page":"Home","title":"LMesh.Free_DOFs","text":"Return a vector with all the free (not constrained) DOFs in the mesh.  This function is used to build Mesh.free_dofs\n\nFree_DOFs(bmesh::Bmesh,nebc::Int64,ebc::Matrix{Float64},loadcase::Int64)\n\nwhere\n\nbmesh    = background mesh    nebc     = number of essential boundary conditions    ebc      = matrix with essential boundary condition data    loadcase = the load case to consider\n\n\n\n\n\n","category":"function"},{"location":"","page":"Home","title":"Home","text":"Nodal_coordinates","category":"page"},{"location":"#BMesh.Nodal_coordinates","page":"Home","title":"BMesh.Nodal_coordinates","text":"(Overloaded from BMesh) Return vectors x and y with the nodal coordinates of element ele\n\nNodal_coordinates(mesh::Mesh2D,ele::Int64)\n\nwhere mesh is a 2D Mesh and ele a valid element.\n\n\n\n\n\n(Overloaded from BMesh) Return vectors x, y and z with the nodal coordinates of element ele\n\nNodal_coordinates(mesh::Mesh3D,ele::Int64)\n\nwhere mesh is a 3D Mesh and ele a valid element.\n\n\n\n\n\n","category":"function"},{"location":"","page":"Home","title":"Home","text":"Centroid","category":"page"},{"location":"#BMesh.Centroid","page":"Home","title":"BMesh.Centroid","text":"(Overloaded from BMesh) Return a vector with the centroidal coordinates of element ele\n\nCentroid(mesh::Mesh2D,ele::Int64)\n\n\n\n\n\nReturn a vector with the centroidal coordinates of element ele\n\nCentroid(mesh::Mesh3D,ele::Int64)\n\n\n\n\n\n","category":"function"},{"location":"","page":"Home","title":"Home","text":"Get_dim","category":"page"},{"location":"#LMesh.Get_dim","page":"Home","title":"LMesh.Get_dim","text":"Return 2 for 2D problems and 3 for 3D problems\n\nGet_dim(mesh::Mesh)\n\n\n\n\n\n","category":"function"},{"location":"","page":"Home","title":"Home","text":"Get_etype","category":"page"},{"location":"#LMesh.Get_etype","page":"Home","title":"LMesh.Get_etype","text":"Return element type\n\nGet_etype(mesh::Mesh)\n\n\n\n\n\n","category":"function"},{"location":"","page":"Home","title":"Home","text":"Get_eclass","category":"page"},{"location":"#LMesh.Get_eclass","page":"Home","title":"LMesh.Get_eclass","text":"Return truss or solid\n\nGet_eclass(mesh::Mesh)\n\n\n\n\n\n","category":"function"},{"location":"","page":"Home","title":"Home","text":"Get_material_number","category":"page"},{"location":"#LMesh.Get_material_number","page":"Home","title":"LMesh.Get_material_number","text":"Material number for element ele\n\nGet_material(mesh::Mesh,ele::Int64)\n\n\n\n\n\n","category":"function"},{"location":"","page":"Home","title":"Home","text":"Get_material","category":"page"},{"location":"#LMesh.Get_material","page":"Home","title":"LMesh.Get_material","text":"Material data for element ele\n\nGet_material(mesh::Mesh,ele::Int64)\n\n\n\n\n\n","category":"function"},{"location":"","page":"Home","title":"Home","text":"Get_geometry_number","category":"page"},{"location":"#LMesh.Get_geometry_number","page":"Home","title":"LMesh.Get_geometry_number","text":"Geometry number for element ele\n\nGetgeometrynumber(mesh::Mesh,ele::Int64)\n\n\n\n\n\n","category":"function"},{"location":"","page":"Home","title":"Home","text":"Get_geometry","category":"page"},{"location":"#LMesh.Get_geometry","page":"Home","title":"LMesh.Get_geometry","text":"Geometry data for element ele\n\nGet_geometry(mesh::Mesh,ele::Int64)\n\n\n\n\n\n","category":"function"},{"location":"","page":"Home","title":"Home","text":"Get_ne","category":"page"},{"location":"#LMesh.Get_ne","page":"Home","title":"LMesh.Get_ne","text":"Number of elements in this mesh\n\nGet_ne(mesh::Mesh)\n\n\n\n\n\n","category":"function"},{"location":"","page":"Home","title":"Home","text":"Get_nn","category":"page"},{"location":"#LMesh.Get_nn","page":"Home","title":"LMesh.Get_nn","text":"Number of nodes in this mesh\n\nGet_nn(mesh::Mesh)\n\n\n\n\n\n","category":"function"},{"location":"#Overloaded-from-BMesh","page":"Home","title":"Overloaded from BMesh","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Connect","category":"page"},{"location":"#BMesh.Connect","page":"Home","title":"BMesh.Connect","text":"(Overloaded from BMesh) Return the connectivities of element ele\n\nConnect(mesh::Mesh,ele::Int64)\n\nas an Int64 vector.  \n\n\n\n\n\n","category":"function"},{"location":"","page":"Home","title":"Home","text":"Coord","category":"page"},{"location":"#BMesh.Coord","page":"Home","title":"BMesh.Coord","text":"(Overloaded from BMesh) Return the coordinates of node \n\nCoord(mesh::Mesh,node::Int64)\n\nas a vector [x;y;(z)]\n\n\n\n\n\n","category":"function"},{"location":"","page":"Home","title":"Home","text":"Length","category":"page"},{"location":"#BMesh.Length","page":"Home","title":"BMesh.Length","text":"(Overloaded from BMesh) Return the distance between two nodes of the element\n\nLength(mesh::Mesh,ele::Int64;nodes=(1,2))\n\nwhere the default is the distance between (local) nodes 1 and 2\n\n\n\n\n\n","category":"function"},{"location":"","page":"Home","title":"Home","text":"DOFs","category":"page"},{"location":"#BMesh.DOFs","page":"Home","title":"BMesh.DOFs","text":"(Overloaded from BMesh) Return a dim*n vector with the global DOFs of element ele\n\nDOFs(mesh::Mesh,ele::Int64)\n\nwhere n is the number of nodes of ele and dim=2 or 3.\n\n\n\n\n\n","category":"function"},{"location":"","page":"Home","title":"Home","text":"T_matrix","category":"page"},{"location":"#BMesh.T_matrix","page":"Home","title":"BMesh.T_matrix","text":"(Overloaded from BMesh) Evaluate the rotation matrix T that maps from global to local reference systems. This version evaluates Rotation internally.\n\nT_matrix(mesh::Mesh, ele::Int64, α=0.0)\n\n\n\n\n\n","category":"function"},{"location":"#Plot","page":"Home","title":"Plot","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"plot","category":"page"},{"location":"#RecipesBase.plot","page":"Home","title":"RecipesBase.plot","text":"Overload plot to show the mesh and boundary conditions. Just for truss elements.\n\nplot(mesh::Mesh2D; name=\"\", factor=6.0)\n\nfactor is used to scale arrows to a fraction of the total dimension.\n\n\n\n\n\n","category":"function"}]
}

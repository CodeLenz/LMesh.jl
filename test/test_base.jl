@testset "Base" begin

  
    ####################    2D BMesh ######################
    #
    #    Valid inputs (no error) 
    #
    nn = 4
    ne = 6
    coord = [0.0 0.0 ;
             1.0 0.0 ;
             1.0 1.0 ;
             0.0 1.0 ]
    connect = [1 2 ; 2 3 ; 3 4 ; 4 1; 1 3 ; 4 2]
    Lx = 1.0
    Ly = 1.0
    nx = 1
    ny = 1
    etype = :truss2D

    # truss2D
    b2 = Bmesh2D(etype,nn,ne,coord,connect,Lx,Ly,nx,ny)

    # Essential boundary conditions
    nebc = 4
    ebc = [1 1 0.0 ; 
           2 2 0.0 ; 
           3 2 0.0 ; 
           4 1 0.0]
 
    
    # Free_DOFs 
    gls, ngls =  Free_DOFs(b2,nebc,ebc,1)

    # Reference values
    # 1 2 3 4 5 6 7 8
    # X     X   X X
    # 2 3 5 8
    refer = [2;3;5;8]

    # Check if it is correct
    @test ngls==4
    @test all(gls.==refer)
 
    # Check inferred
    @isinferred Free_DOFs(b2,nebc,ebc,1)


    ####################   3D BMesh ######################
    #
    #    Valid inputs (no error) 
    #
    nn = 8
    ne = 12
    coord = [0.0 0.0 0.0;
             1.0 0.0 0.0;
             1.0 1.0 0.0;
             0.0 1.0 0.0;
             0.0 0.0 1.0;
             1.0 0.0 1.0;
             1.0 1.0 1.0;
             0.0 1.0 1.0    
             ]
    connect = [1 2 ; 2 3 ; 3 4 ; 4 1;
               5 6 ; 6 7 ; 7 8 ; 8 5;
               1 5; 2 6; 3 7; 4 8]
    Lx = 1.0
    Ly = 1.0
    Lz = 1.0
    nx = 1
    ny = 1
    nz = 1
    etype = :truss3D

    # truss3D
    b3 = Bmesh3D(etype,nn,ne,coord,connect,Lx,Ly,Lz,nx,ny,nz)

    # Essential boundary conditions
    nebc = 6
    ebc = [1 1 0.0 ; 
           1 3 0.0 ;  
           2 2 0.0 ;
           5 1 0.0 ; 
           7 3 0.0 ; 
           8 1 0.0 ]

    # Free_DOFs 
    gls, ngls =  Free_DOFs(b3,nebc,ebc,1)

    # Reference values
    # 1 2 3   4 5 6   7 8 9   10 11 12   13 14 15   16 17 18  19 20 21  22 23 24
    # X   X     X                         X                         X   X 
    refer = [2;4;6;7;8;9;10;11;12;14;15;16;17;18;19;20;23;24]

    # Check if it is correct
    @test ngls==18
    @test all(gls.==refer)

    # Check inferred
    @isinferred Free_DOFs(b3,nebc,ebc,1)

    #
    # Nodal coordinates
    #
    # Nodal_coordinates(m::Mesh2D,ele)

    ####################  2D BMesh ######################
    # Single bar in tension (L=0.1m F=100.0 A=1.0 E=100.0)
    #
    #    Valid inputs (no error) 
    #
    nn = 2
    ne = 1
    coord = [0.0 0.0 ;
             0.1 0.0 ]
    connect = [1 2 ]
    Lx = 1.0
    Ly = 1.0
    nx = 1
    ny = 1
    etype = :truss2D

    # truss2D
    b2 = Bmesh2D(etype,nn,ne,coord,connect,Lx,Ly,nx,ny)

    # Essential boundary conditions
    ebc = [1 1 0.0 ; 
           1 2 0.0 ; 
           2 2 0.0 ]

    # Natural boundary conditions
    nbc = [2 1 100.0]

    # Material and geometry
    materials = [Material(Ex=100.0,density=1.0)]
    geometries = [Geometry(A=1.0)]
           
    # Mesh
    m2 = Mesh2D(b2,materials,geometries,ebc,nbc)

    # Nodal coordinates of element 1 
    x,y=Nodal_coordinates(m2,1)
    xref = [0.0;0.1]
    yref = [0.0;0.0]
    @assert all(x.==xref)
    @assert all(y.==yref)

    # Check inferred
    @isinferred Nodal_coordinates(m2,1)

    # Check output
    @test Get_dim(m2)==2
    @test Get_etype(m2)==:truss2D
    @test Get_eclass(m2)==:truss

    # Check inferences
    @isinferred Get_dim(m2)
    @isinferred Get_etype(m2)
    @isinferred Get_eclass(m2)

    ####################  2D BMesh ######################
    # Square
    #
    #    Valid inputs (no error) 
    #
    nn = 4
    ne = 1
    coord = [0.0 0.0 ;
             1.0 0.0 ;
             1.1 1.1 ;
             0.0 1.0]
    connect = [1 2 3 4]
    Lx = 1.0
    Ly = 1.0
    nx = 1
    ny = 1
    etype = :solid2D

    # truss2D
    b2 = Bmesh2D(etype,nn,ne,coord,connect,Lx,Ly,nx,ny)

    # Essential boundary conditions
    ebc = [1 1 0.0 ; 
           1 2 0.0 ; 
           2 1 0.0 ]

    # Natural boundary conditions
    nbc = [3 1 100.0]

    # Material and geometry
    materials = [Material(Ex=100.0,density=1.0)]
    geometries = [Geometry(thickness=1.0)]
           
    # Mesh
    m2 = Mesh2D(b2,materials,geometries,ebc,nbc)

    # Check output
    @test Get_dim(m2)==2
    @test Get_etype(m2)==:solid2D
    @test Get_eclass(m2)==:solid
  
    # Check inferences
    @isinferred Get_dim(m2)
    @isinferred Get_etype(m2)
    @isinferred Get_eclass(m2)
  
    # Check output
    @test Get_material_number(m2,1)==1
    @test Get_geometry_number(m2,1)==1
    @test isa(Get_material(m2,1),Material)
    @test isa(Get_geometry(m2,1),Geometry)
  
    # Check inferences
    @isinferred Get_material_number(m2,1)
    @isinferred Get_geometry_number(m2,1)
    @isinferred Get_material(m2,1)
    @isinferred Get_geometry(m2,1)
    
    # Nodal coordinates of element 1 
    x,y=Nodal_coordinates(m2,1)
    xref = [0.0;1.0;1.1;0.0]
    yref = [0.0;0.0;1.1;1.0]
    @assert all(x.==xref)
    @assert all(y.==yref)
    
    #
    # Test centoid
    # 
    cent = Centroid(m2,1)
    @test cent[1]==(1+1.1)/4        
    @test cent[2]==(1+1.1)/4
    
    # Check inference
    @isinferred Centroid(m2,1)

    # Check output
    @test Get_ne(m2)==m2.bmesh.ne
    @test Get_nn(m2)==m2.bmesh.nn

    # Check inference
    @isinferred Get_ne(m2)
    @isinferred Get_nn(m2)
    
end

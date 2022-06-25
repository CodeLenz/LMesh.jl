@testset "LMesh" begin

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
    nbc = [1 2 -100.0] 
 
    materials = [Material(Ex=1.0), Material(Ex=1.0,dens=7000.0) ]
    geometries = [Geometry(A=1.0), Geometry(A=2.0), Geometry(A=3.0)]

    # Valid tests
    @test isa(Mesh2D(b2,materials,geometries,ebc,nbc),Mesh2D)

    mat_ele = [1;1;1;1;1;1]
    @test Mesh2D(b2,materials,geometries,ee,nbc,mat_ele=mat_ele)
   
    mat_ele = [1;2;1;2;1;2]
    @test Mesh2D(b2,materials,geometries,ee,nbc,mat_ele=mat_ele)
    
    geo_ele = [1;1;1;1;1;1]
    @test Mesh2D(b2,materials,geometries,ee,nbc,mat_geo=mat_geo)
    
    geo_ele = [1;1;3;3;2;1]
    @test Mesh2D(b2,materials,geometries,ee,nbc,mat_geo=mat_geo)
    

    # # Basic tests
    # nmat>=1 || throw("Mesh2D::number of material properties must be >=1")
    mm = Material[]   
    @test_throws String Mesh2D(b2,mm,geometries,ebc,nbc)

    # ngeo>=1 || throw("Mesh2D::number of geometries properties must be >=1")
    gg = Geometry[]   
    @test_throws String Mesh2D(b2,materials,gg,ebc,nbc)

    # nebc>=3 || throw("Mesh2D:: at least three essential boundary conditions are needed in 2D ")
    ee = [1 2 0.0]
    @test_throws String Mesh2D(b2,materials,geometries,ee,nbc)

    ee = [1 2 0.0 ; 
          2 2 0.0]
    @test_throws String Mesh2D(b2,materials,geometries,ee,nbc)

    # Should throw (negative material pointer)
    mat_ele = [-1;1;1;1;1;1]
    @test_throws String Mesh2D(b2,materials,geometries,ee,nbc,mat_ele=mat_ele)
    
    # Should throw (invalid material)
    mat_ele = [1;1;3;1;1;1]
    @test_throws String Mesh2D(b2,materials,geometries,ee,nbc,mat_ele=mat_ele)
    
    # Should throw (invalid geometry)
    mat_geo = [1;1;1;4;1;1]
    @test_throws String Mesh2D(b2,materials,geometries,ee,nbc,mat_geo=mat_geo)
    
    
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

    materials = [Material(Ex=1.0), Material(Ex=1.0,dens=7000.0) ]
    geometries = [Geometry(A=1.0), Geometry(A=2.0), Geometry(A=3.0)]
       
    # Valid tests
    @test isa(Mesh3D(b3,materials,geometries,ebc,nbc),Mesh3D)
    
    mat_ele = [1;1;1;1;1;1]
    @test Mesh3D(b3,materials,geometries,ee,nbc,mat_ele=mat_ele)
   
    mat_ele = [1;2;1;2;1;2]
    @test Mesh3D(b3,materials,geometries,ee,nbc,mat_ele=mat_ele)
    
    geo_ele = [1;1;1;1;1;1]
    @test Mesh3D(b3,materials,geometries,ee,nbc,mat_geo=mat_geo)
    
    geo_ele = [1;1;3;3;2;1]
    @test Mesh3D(b3,materials,geometries,ee,nbc,mat_geo=mat_geo)
    
       
    #  Basic tests
    # nmat>=1 || throw("Mesh3D::number of material properties must be >=1")
    mm = Material[]   
    @test_throws String Mesh3D(b3,mm,geometries,ebc,nbc)
       
    # ngeo>=1 || throw("Mesh3D::number of geometries properties must be >=1")
    gg = Geometry[]   
    @test_throws String Mesh3D(b3,materials,gg,ebc,nbc)
       
    # nebc>=5 || throw("Mesh3D:: at least five essential boundary conditions are needed in 3D")
    ee = [1 2 0.0]
    @test_throws String Mesh3D(b3,materials,geometries,ee,nbc)
       
    # Should throw (negative material pointer)
    mat_ele = [-1;1;1;1;1;1]
    @test_throws String Mesh3D(b3,materials,geometries,ee,nbc,mat_ele=mat_ele)
    
    # Should throw (invalid material)
    mat_ele = [1;1;3;1;1;1]
    @test_throws String Mesh3D(b3,materials,geometries,ee,nbc,mat_ele=mat_ele)
    
    # Should throw (invalid geometry)
    mat_geo = [1;1;1;4;1;1]
    @test_throws String Mesh3D(b3,materials,geometries,ee,nbc,mat_geo=mat_geo)
    
end

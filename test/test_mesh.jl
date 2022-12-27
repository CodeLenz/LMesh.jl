@testset "LMesh - no loadcase" begin

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
    nhebc = 4
    hebc = [1 1; 
           2 2; 
           3 2; 
           4 1]
    nbc = [1 2 -100.0] 
 
    materials = [Material(Ex=1.0), Material(Ex=1.0,density=7000.0) ]
    geometries = [Geometry(A=1.0), Geometry(A=2.0), Geometry(A=3.0)]

    # Valid tests
    @test isa(Mesh2D(b2,materials,geometries,hebc,nbc),Mesh2D)

    mat_ele = [1;1;1;1;1;1]
    @test isa(Mesh2D(b2,materials,geometries,hebc,nbc,mat_ele=mat_ele),Mesh2D)
   
    mat_ele = [1;2;1;2;1;2]
    @test isa(Mesh2D(b2,materials,geometries,hebc,nbc,mat_ele=mat_ele),Mesh2D)
    
    geo_ele = [1;1;1;1;1;1]
    @test isa(Mesh2D(b2,materials,geometries,hebc,nbc,geo_ele=geo_ele),Mesh2D)
    
    geo_ele = [1;1;3;3;2;1]
    @test isa(Mesh2D(b2,materials,geometries,hebc,nbc,geo_ele=geo_ele),Mesh2D)
    

    # # Basic tests
    # nmat>=1 || throw("Mesh2D::number of material properties must be >=1")
    mm = Material[]   
    @test_throws String Mesh2D(b2,mm,geometries,hebc,nbc)

    # ngeo>=1 || throw("Mesh2D::number of geometries properties must be >=1")
    gg = Geometry[]   
    @test_throws String Mesh2D(b2,materials,gg,hebc,nbc)

    # nhebc>=3 || throw("Mesh2D:: at least three essential boundary conditions are needed in 2D ")
    ee = [1 2]
    @test_throws String Mesh2D(b2,materials,geometries,ee,nbc)

    ee = [1 2 ; 
          2 2 ]
    @test_throws String Mesh2D(b2,materials,geometries,ee,nbc)

    # Should throw (negative material pointer)
    mat_ele = [-1;1;1;1;1;1]
    @test_throws String Mesh2D(b2,materials,geometries,hebc,nbc,mat_ele=mat_ele)
    
    # Should throw (invalid material)
    mat_ele = [1;1;3;1;1;1]
    @test_throws String Mesh2D(b2,materials,geometries,hebc,nbc,mat_ele=mat_ele)
    
    # Should throw (negative geometry pointer)
    geo_ele = [1;1;1;-1;1;1]
    @test_throws String Mesh2D(b2,materials,geometries,hebc,nbc,geo_ele=geo_ele)
    
    # Should throw (invalid geometry)
    geo_ele = [1;1;1;4;1;1]
    @test_throws String Mesh2D(b2,materials,geometries,hebc,nbc,geo_ele=geo_ele)
    
    
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
    nhebc = 6
    hebc = [1 1 ; 
            1 3  ;  
            2 2  ;
            5 1  ; 
            7 3  ; 
            8 1  ]

    materials = [Material(Ex=1.0), Material(Ex=1.0,density=7000.0) ]
    geometries = [Geometry(A=1.0), Geometry(A=2.0), Geometry(A=3.0)]
       
    # Valid tests
    @test isa(Mesh3D(b3,materials,geometries,hebc,nbc),Mesh3D)
    
    mat_ele = [1;1;1;1;1;1;1;1;1;1;1;1]
    @test isa(Mesh3D(b3,materials,geometries,hebc,nbc,mat_ele=mat_ele),Mesh3D)
   
    mat_ele = [1;2;1;2;1;2;1;1;1;1;1;1]
    @test isa(Mesh3D(b3,materials,geometries,hebc,nbc,mat_ele=mat_ele),Mesh3D)
    
    geo_ele = [1;1;1;1;1;1;1;1;1;1;1;1]
    @test isa(Mesh3D(b3,materials,geometries,hebc,nbc,geo_ele=geo_ele),Mesh3D)
    
    geo_ele = [1;1;3;3;2;1;1;1;1;1;1;1]
    @test isa(Mesh3D(b3,materials,geometries,hebc,nbc,geo_ele=geo_ele),Mesh3D)
    
       
    #  Basic tests
    # nmat>=1 || throw("Mesh3D::number of material properties must be >=1")
    mm = Material[]   
    @test_throws String Mesh3D(b3,mm,geometries,hebc,nbc)
       
    # ngeo>=1 || throw("Mesh3D::number of geometries properties must be >=1")
    gg = Geometry[]   
    @test_throws String Mesh3D(b3,materials,gg,hebc,nbc)
       
    # nhebc>=5 || throw("Mesh3D:: at least five essential boundary conditions are needed in 3D")
    ee = [1 2]
    @test_throws String Mesh3D(b3,materials,geometries,ee,nbc)
       
    # Should throw (negative material pointer)
    mat_ele = [-1;1;1;1;1;1;1;1;1;1;1;1]
    @test_throws String Mesh3D(b3,materials,geometries,hebc,nbc,mat_ele=mat_ele)
    
    # Should throw (invalid material)
    mat_ele = [1;1;3;1;1;1;1;1;1;1;1;1]
    @test_throws String Mesh3D(b3,materials,geometries,hebc,nbc,mat_ele=mat_ele)
    
    # Should throw (negative pointer)
    geo_ele = [1;1;1;-1;1;1;1;1;1;1;1;1]
    @test_throws String Mesh3D(b3,materials,geometries,hebc,nbc,geo_ele=geo_ele)
    
    # Should throw (invalid geometry)
    geo_ele = [1;1;1;4;1;1;1;1;1;1;1;1]
    @test_throws String Mesh3D(b3,materials,geometries,hebc,nbc,geo_ele=geo_ele)
    
end


@testset "LMesh - loadcases" begin

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
       hebc = [1 1 ; 
              2 2 ; 
              3 2 ; 
              4 1 ;
              1 1 ; 
              2 2 ; 
              3 2 ]


       nbc = [1 2 -100.0 1;
              2 2 +200.0 2 ] 
    
       materials = [Material(Ex=1.0), Material(Ex=1.0,density=7000.0) ]
       geometries = [Geometry(A=1.0), Geometry(A=2.0), Geometry(A=3.0)]
   
       # Valid tests
       @test isa(Mesh2D(b2,materials,geometries,hebc,nbc),Mesh2D)
   
       m2 = Mesh2D(b2,materials,geometries,hebc,nbc)
       @test m2.nload == 2

       # Some invalid tests

       # EBC

       # Invalid node (-1)
       Xhebc = [-1 1;  # -1 < 0
              2 2 ; 
              3 2 ; 
              4 1 ;
              1 1 ; 
              2 2 ; 
              3 2 ]
       @test_throws String Mesh2D(b2,materials,geometries,Xhebc,nbc)


       # Invalid node (>nn)
       Xhebc = [1 1 ; 
              2 2 ; 
              5 2 ; #<- 5 > 4
              4 1 ;
              1 1 ; 
              2 2 ; 
              3 2 ]
       @test_throws String Mesh2D(b2,materials,geometries,Xhebc,nbc)

       # Invalid node (0)
       Xhebc = [1 1 ; 
              2 2 ; 
              0 2 ; #<- 
              4 1 ;
              1 1 ; 
              2 2 ; 
              3 2 ]
       @test_throws String Mesh2D(b2,materials,geometries,Xhebc,nbc)


        # Invalid dof
        Xhebc = [1 -1 ;  # -1 < 0
        2 2 ; 
        3 2 ; 
        4 1 ;
        1 1 ; 
        2 2 ; 
        3 2 ]
       @test_throws String Mesh2D(b2,materials,geometries,Xhebc,nbc)

       # Invalid dof
       Xhebc = [1 0;  # 0
       2 2; 
       3 2; 
       4 1;
       1 1; 
       2 2; 
       3 2]
       @test_throws String Mesh2D(b2,materials,geometries,Xhebc,nbc)

       # Invalid dof
       Xhebc = [1 3 ;  # 3 > 2
              2 2 ; 
              3 2 ; 
              4 1 ;
              1 1 ; 
              2 2 ; 
              3 2 ]
      @test_throws String Mesh2D(b2,materials,geometries,Xhebc,nbc)

      # NBC

      # Invalid node
      Xnbc = [10 2 -100.0 1;   # 10 
      2 2 +200.0 2 ] 
      @test_throws String Mesh2D(b2,materials,geometries,hebc,Xnbc)

      # Invalid node
      Xnbc = [0 2 -100.0 1;   # 0
      2 2 +200.0 2 ] 
      @test_throws String Mesh2D(b2,materials,geometries,hebc,Xnbc)

      # Invalid node
      Xnbc = [1 2 -100.0 1;   
      -1 2 +200.0 2 ]         # -1
      @test_throws String Mesh2D(b2,materials,geometries,hebc,Xnbc)

      # Invalid dof
      Xnbc = [1 0 -100.0 1;   # 0
      2 2 +200.0 2 ] 
      @test_throws String Mesh2D(b2,materials,geometries,hebc,Xnbc)

      # Invalid dof
      Xnbc = [1 -1 -100.0 1;   # -1
      2 2 +200.0 2 ] 
      @test_throws String Mesh2D(b2,materials,geometries,hebc,Xnbc)

      # Invalid dof
      Xnbc = [1 2 -100.0 1;   
      2 3 +200.0 2 ]         # 3
      @test_throws String Mesh2D(b2,materials,geometries,hebc,Xnbc)

      # Invalid loadcase
      Xnbc = [1 1 -100.0 1;   
      2 2 +200.0 -1 ] #-1
      @test_throws String Mesh2D(b2,materials,geometries,hebc,Xnbc)


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
       hebc = [1 1 ; 
              1 3 ;  
              2 2 ;
              5 1 ; 
              7 3 ; 
              8 1 ;
              1 1 ; 
              1 3 ;  
              2 2 ;
              5 1 ; 
              7 3 ]
   
       nbc = [1 2 -100.0 1;
              2 2 +200.0 2 ] 
    
       materials = [Material(Ex=1.0), Material(Ex=1.0,density=7000.0) ]
       geometries = [Geometry(A=1.0), Geometry(A=2.0), Geometry(A=3.0)]
          
       # Valid tests
       @test isa(Mesh3D(b3,materials,geometries,hebc,nbc),Mesh3D)
           
       m3 =  Mesh3D(b3,materials,geometries,hebc,nbc)
       @test m3.nload == 2

       # INVALID TESTS

       # EBC

       # Invalid node   (-1)
       Xhebc = [1 1; 
              1 3;  
              2 2;
              5 1; 
              7 3; 
              -1 1;  #<-
              1 1 ; 
              1 3 ;  
              2 2 ;
              5 1 ; 
              7 3 ]
       @test_throws String Mesh3D(b3,materials,geometries,Xhebc,nbc)


       # Invalid node   (0)
       Xhebc = [1 1 ; 
              1 3 ;  
              2 2 ;
              5 1 ; 
              7 3 ; 
              8 1 ;  
              1 1 ; 
              0 3 ;   #<-
              2 2 ;
              5 1 ; 
              7 3 ]
       @test_throws String Mesh3D(b3,materials,geometries,Xhebc,nbc)

       # Invalid node   (>nn)
       Xhebc = [1 1 ; 
              1 3 ;  
              2 2 ;
              5 1 ; 
              7 3 ; 
              8 1 ;  
              1 1 ; 
              1 3 ;   
              2 2 ;
              5 1 ; 
              10 3 ]  #<-
       @test_throws String Mesh3D(b3,materials,geometries,Xhebc,nbc)


       # Invalid dof   (-1)
       Xhebc = [1 1 ; 
           1 3 ;  
           2 2 ;
           5 1 ; 
           7 -1 ; #<-
           8 1 ;  
           1 1 ; 
           1 3 ;  
           2 2 ;
           5 1 ; 
           7 3 ]
       @test_throws String Mesh3D(b3,materials,geometries,Xhebc,nbc)

       # Invalid dof   (0)
       Xhebc = [1 1 ; 
           1 3 ;  
           2 2 ;
           5 1 ; 
           7 0 ; #<-
           8 1 ;  
           1 1 ; 
           1 3 ;  
           2 2 ;
           5 1 ; 
           7 3 ]
       @test_throws String Mesh3D(b3,materials,geometries,Xhebc,nbc)

       # Invalid dof   (4>3)
       Xhebc = [1 1 ; 
           1 3 ;  
           2 2 ;
           5 1 ; 
           7 4 ; #<-
           8 1 ;  
           1 1 ; 
           1 3 ;  
           2 2 ;
           5 1 ; 
           7 3 ]
       @test_throws String Mesh3D(b3,materials,geometries,Xhebc,nbc)

       # NBC

       # Invalid node (-1)
       Xnbc = [1 2 -100.0 1;
              -1 2 +200.0 2 ]   #<-
       @test_throws String  Mesh3D(b3,materials,geometries,hebc,Xnbc)

       # Invalid node (0)
       Xnbc = [0 2 -100.0 1; #<-
       2 2 +200.0 2 ]   
       @test_throws String Mesh3D(b3,materials,geometries,hebc,Xnbc)

       # Invalid node (>nn)
       Xnbc = [10 2 -100.0 1; #<-
       2 2 +200.0 2 ]   
       @test_throws String Mesh3D(b3,materials,geometries,hebc,Xnbc)

       # Invalid dof (-1)
       Xnbc = [1 -1 -100.0 1; #<-
       2 2 +200.0 2 ]   
       @test_throws String Mesh3D(b3,materials,geometries,hebc,Xnbc)

       # Invalid dof (0)
       Xnbc = [1 0 -100.0 1; #<-
       2 2 +200.0 2 ]   
       @test_throws String Mesh3D(b3,materials,geometries,hebc,Xnbc)

       # Invalid dof (4)
       Xnbc = [1 4 -100.0 1; #<-
       2 2 +200.0 2 ]   
       @test_throws String Mesh3D(b3,materials,geometries,hebc,Xnbc)

       # Invalid loadcase
       Xnbc = [1 3 -100.0 -1; #<-
       2 2 +200.0 2 ]   
       @test_throws String Mesh3D(b3,materials,geometries,hebc,Xnbc)


   end
   
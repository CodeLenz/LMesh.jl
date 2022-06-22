@testset "Base" begin

    # Free_DOFs(bmesh::Bmesh,nebc::Int64,ebc::Matrix{Float64})

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
    gls, ngls =  Free_DOFs(b2,nebc,ebc)

    # Reference values
    # 1 2 3 4 5 6 7 8
    # X     X   X X
    # 2 3 5 8
    refer = [2;3;5;8]

    # Check if it is correct
    @test ngls==4
    @test all(gls.==refer)
 

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
    gls, ngls =  Free_DOFs(b3,nebc,ebc)

    # Reference values
    # 1 2 3   4 5 6   7 8 9   10 11 12   13 14 15   16 17 18  19 20 21  22 23 24
    # X   X     X                         X                         X   X 
    refer = [2;4;6;7;8;9;10;11;12;14;15;16;17;18;19;20;23;24]

    # Check if it is correct
    @test ngls==18
    @test all(gls.==refer)
 

end
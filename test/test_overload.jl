@testset "Overload" begin

    ################################ 2D ##################################
    ############################## TRUSS #################################

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

    @test all(Connect(m2D,1).==[1;2])
    @test all(Coord(m2D,1).==[0.0;0.0])
    @test Length(m2D,1)==0.5
    @test all(DOFs(m2D,1).==[1;2;3;4])
    @test all(T_matrix(m2D,1).==I(4))


end

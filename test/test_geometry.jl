@testset "Geometry" begin

    # Valid tests
    @test isa(Geometry(A=100.0),Geometry)
    @test isa(Geometry(A=100.0,thickness=0.3),Geometry)

    # Should Trhow
    @test_throws String Geometry(A=0.0)
    @test_throws String Geometry(A=-1.0)
    
    @test_throws String Geometry(thickness=0.0)
    @test_throws String Geometry(thickness=-1.0)
    
end
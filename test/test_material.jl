@testset "Material" begin

    # Valid tests
    @test isa(Material(Ex=100.0),Material)
    @test isa(Material(Ex=100.0,νxy=0.3),Material)
    @test isa(Material(Ex=100.0,νxy=0.3,α=1E-16),Material)
    @test isa(Material(Ex=100.0,νxy=0.3,α=1E-16,density=7850.0),Material)
    

    # Should Trhow
    @test_throws String Material(Ex=-1.0)
    @test_throws String Material(Ex=0.0)
    
    @test_throws String Material(density=-1.0)
    @test_throws String Material(density=0.0)
    
    
    
end
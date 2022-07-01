@testset "Material" begin

    # Valid tests
    @test isa(Material(Ex=100.0),Material)
    @test isa(Material(Ex=100.0,νxy=0.3),Material)
    @test isa(Material(Ex=100.0,νxy=0.3,α=1E-16),Material)
    @test isa(Material(Ex=100.0,νxy=0.3,α=1E-16,density=7850.0),Material)
    @test isa(Material(Ex=100.0,νxy=0.3,α=1E-16,density=7850.0,model=:EPT),Material)
    @test isa(Material(Ex=100.0,νxy=0.3,α=1E-16,density=7850.0,model=:EPD),Material)
    @test isa(Material(Ex=100.0,νxy=0.3,α=1E-16,density=7850.0,model=:Custom,ones(2,2)),Material)
   

    # Should Trhow
    @test_throws String Material(Ex=-1.0)
    @test_throws String Material(Ex=0.0)
    
    @test_throws String Material(density=-1.0)
    @test_throws String Material(density=0.0)
   
    @test_throws String Material(model=:bla)
    
    @test_throws String Material(custom=Int64[])
    
    @test_throws String Material(model=:Custom)
    
    
    
end

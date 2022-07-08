@testset "Material" begin

    # Valid tests
    
    # Just #Ex
    @test isa(Material(Ex=100.0),Material)

    # Ex and Poisson
    @test isa(Material(Ex=100.0,νxy=0.3),Material)

    # Ex, Poisson and thermal expansion
    @test isa(Material(Ex=100.0,νxy=0.3,α_T=1E-16),Material)

    # Ex, Poisson and thermal expansion, density
    @test isa(Material(Ex=100.0,νxy=0.3,α_T=1E-16,density=7850.0),Material)

    # Ex, Poisson and thermal expansion, density + model
    @test isa(Material(Ex=100.0,νxy=0.3,α_T=1E-16,density=7850.0,model=:EPT),Material)
    @test isa(Material(Ex=100.0,νxy=0.3,α_T=1E-16,density=7850.0,model=:EPD),Material)
    @test isa(Material(Ex=100.0,νxy=0.3,α_T=1E-16,density=7850.0,model=:Custom,custom=ones(2,2)),Material)
   
    # Limit stress
    @test isa(Material(Ex=100.0,limit_stress=1E6),Material)

    # Proportional Damping
    # Limit stress
    @test isa(Material(Ex=100.0,limit_stress=1E6,α_c=1E-6),Material)
    @test isa(Material(Ex=100.0,limit_stress=1E6,β_c=1E-6),Material)
    @test isa(Material(Ex=100.0,limit_stress=1E6,β_c=1E-6,α_c=1E-6),Material)
    

    # Should Trhow
    @test_throws String Material(Ex=-1.0)
    @test_throws String Material(Ex=0.0)
    
    @test_throws String Material(density=-1.0)
    @test_throws String Material(density=0.0)
   
    @test_throws String Material(model=:bla)

    @test_throws String Material(Ex=100.0,limit_stress=-1E6)
    @test_throws String Material(Ex=100.0,limit_stress=0.0)
    
    
end

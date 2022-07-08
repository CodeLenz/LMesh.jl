#
# Generic Linear, elastic and isotropic material
#
"""
Basic structure to store material data

    Material(;Ex=1.0,νxy=0.0, α_T=0.0, density=1.0, model=:EPT,
              limit_stress=1.0, α_c=0.0,β_c=0.0,
              custom=[1.0 1.0 ; 1.0 1.0])

where all inputs are named. 

Ex = Young's mudule (in X) [Pa]
νxy = Poisson's ratio
α_T = Thermal expansion 1/Temperature
density = material density [Kg/m³]
model =  2D elasticity (:EPT or :EPD) or :Custom 
limit_stress = limit stress (von-Mises criteria) [Pa]
α_c = Mass parameter for proportional damping
β_c = Stiffness parameter for proportional damping
    
Custom is a custom constitutive Matrix given 
by the user. 


"""
struct Material

    # Elastic module
    Ex::Float64

    # Poisson's ratio
    νxy::Float64

    # thermal expansion
    α_T::Float64

    # Density (specific weight)
    density::Float64

    # Model
    model::Symbol
    
    # Limit stress
    limit_stress::Float64

    # Parameters for proportional damping
    # C = α_cM + _cK
    α_c::Float64
    β_c::Float64

    # Custom constitutive matrix
    custom::Matrix{Float64}
    
    # Default constructor
    function Material(;Ex=1.0,νxy=0.0, α_T=0.0, density=1.0, 
                       limit_stress=1.0, α_c=0.0, β_c=0.0,
                       model=:EPT, custom=[1.0 1.0 ; 1.0 1.0])

        # Basic tests
        Ex>0.0 || throw("Material:: Ex must be > 0")
        density>0.0 || throw("Material:: density must be > 0")
        model in [:EPT,:EPD,:Custom] || throw("Material:: model must be :EPT or :EPD (for 2D analysis)")
        limit_stress >=0.0 || throw("Material:: limit_stress must be > 0")

        if model==:Custom && isempty(custom) 
            throw("Material:: model :Custom needs a custom constitutive matrix")
        end
        
        # create type
        new(Ex,νxy,α,density,model,limit_stress,α_c,β_c,custom)

    end

end

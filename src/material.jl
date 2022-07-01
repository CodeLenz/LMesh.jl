#
# Generic Linear, elastic and isotropic material
#
struct Material

    # Elastic module
    Ex::Float64

    # Poisson's ratio
    νxy::Float64

    # thermal expansion
    α::Float64

    # Density (specific weight)
    density::Float64

    # Model
    model::Symbol
    
    # Custom constitutive matrix
    custom::Matrix{Float64}
    
    # Default constructor
    function Material(;Ex=1.0,νxy=0.0, α=0.0, density=1.0, model=:EPT, custom=[1.0 1.0 ; 1.0 1.0)

        # Basic tests
        Ex>0.0 || throw("Material:: Ex must be > 0")
        density>0.0 || throw("Material:: density must be > 0")
        model in [:EPT,:EPD,:Custom] || throw("Material:: model must be :EPT or :EPD (for 2D analysis)")

        if model==:Custom && isempty(custom) 
            throw("Material:: model :Custom needs a custom constitutive matrix")
        end
        
        # create type
        new(Ex,νxy,α,density,model,custom)

    end

end

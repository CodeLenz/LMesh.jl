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

    # Default constructor
    function Material(;Ex=1.0,νxy=0.0, α=0.0, density=1.0)

        # Basic test2
        Ex>0.0 || throw("Material:: Ex must be > 0")
        density>0.0 || throw("Material:: density must be > 0")

        # create type
        new(Ex,νxy,α,density)

    end

end

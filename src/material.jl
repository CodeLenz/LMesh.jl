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

    # Default constructor
    function Material(;Ex=0.0,νxy=0.0, α=0.0)

        # Basic test
        Ex>0.0 || throw("Material:: Ex must be > 0")

        # create type
        new(Ex,νxy,α)

    end

end

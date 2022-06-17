#
# Generic geometry
#
struct Geometry

    # Cross section area
    A::Float64

    # Thickness
    thickness::Float64

    # Default constructor
    function Geometry(;A=0.0,thickness=0.0)

        # create type
        new(A,thickness)
        
    end

end

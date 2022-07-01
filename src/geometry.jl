#
# Generic geometry
#
"""
Basic structure to store geometrical data

    Geometry(;A=1.0,thickness=1.0)

where all inputs are named.
"""

struct Geometry

    # Cross section area
    A::Float64

    # Thickness
    thickness::Float64

    # Default constructor
    function Geometry(;A=1.0,thickness=1.0)

        # Test consistency
        A>0.0 || throw("Geometry::A should be > 0") 
        thickness>0.0 || throw("Geometry:: thickness  should be > 0") 

        # create type
        new(A,thickness)
        
    end

end

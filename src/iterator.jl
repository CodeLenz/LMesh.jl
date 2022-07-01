# Overload Base.iterate to iterate over elements of Mesh
"""
Iterator for Mesh. 
    Iterates from 1 to the number of elements in the mesh. 
    To be used in loops like 
         for ele in m
            ...
         end   
"""
function Base.iterate(m::Mesh)
     return (1,2)
end

function Base.iterate(m::Mesh,state)
    if state==m.bmesh.ne+1
        return nothing
    end
    return(state,state+1)
end
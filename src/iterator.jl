# Overload Base.iterate to iterate over elements of Mesh

function Base.iterate(m::Mesh)
     return (1,2)
end

function Base.iterate(m::Mesh,state)
    if state==m.bmesh.ne+1
        return nothing
    end
    return(state,state+1)
end
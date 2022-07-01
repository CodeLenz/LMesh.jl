
#
# 2D
#
import Plots:plot
"""
Overload plot to show the mesh and boundary conditions.
Just for truss elements.

    plot(mesh::Mesh2D; name="", factor=6.0)

factor is used to scale arrows to a fraction of the total dimension.
"""
function plot(mesh::Mesh2D; name="", factor=6.0)
   
    Get_etype(mesh)==:truss2D || throw("plot(mesh):: just for trusses")
  
    # Local aliases
    bmesh = mesh.bmesh
    ne = bmesh.ne
 
    # Create the plot
    plot();
  
    println("Generating the visualization...please wait")
  
    # Loop over the elements, extracting the nodes
    # and their coordinates

    maximum_coord_x = 0.0
    maximum_coord_y = 0.0
    for ele=1:ne

        # recover the nodes
        nodes = Conect(bmesh,ele)
        
        # recover the coordinates
        c1 = Coord(bmesh,nodes[1])
        c2 = Coord(bmesh,nodes[2])

        maximum_coord_x = max(maximum_coord_x,abs(c1[1]))
        maximum_coord_y = max(maximum_coord_y,abs(c1[2]))
        maximum_coord_x = max(maximum_coord_x,abs(c2[1]))
        maximum_coord_y = max(maximum_coord_y,abs(c2[2]))

        # Adds a line to the plot
        plot!([c1[1],c2[1]],[c1[2],c2[2]],legend=false)
       
    end #ele
   
    # Show Essential boundary conditions
    for i=1:mesh.nebc

        # node
        no = Int(mesh.ebc[i,1])

        # DOF
        dof = Int(mesh.ebc[i,2])

        # Origin (node coordinates)
        coord = Coord(mesh.bmesh,no)

        # Depending on the DOF, set arrow's direction and label
        if dof==1
            origin = [coord[1],coord[1]+maximum_coord_x/factor]
            dest   = [coord[2],coord[2]]
            plot!(origin,dest,arrow=true,color=:black,linewidth=2)#,label="Rx")
        else    
            origin = [coord[1],coord[1]]
            dest   = [coord[2],coord[2]+maximum_coord_y/factor]
            plot!(origin,dest,arrow=true,color=:black,linewidth=2)#,label="Ry")
        end

    end

    # Show natural boundary conditions
    for i=1:mesh.nnbc

        # node
        no = Int(mesh.nbc[i,1])

        # DOF
        dof = Int(mesh.nbc[i,2])

        # val
        val = mesh.nbc[i,3]

        # Origin (node coordinates)
        coord = Coord(mesh.bmesh,no)

        # Depending on the DOF, set arrow's direction and label
        if dof==1
            origin = [coord[1],coord[1]+maximum_coord_x/factor]
            dest   = [coord[2],coord[2]]
            plot!(origin,dest,arrow=true,color=:black,linewidth=5)#,label="Fx: "*string(val))
        else    
            origin = [coord[1],coord[1]]
            dest   = [coord[2],coord[2]+maximum_coord_y/factor]
            plot!(origin,dest,arrow=true,color=:black,linewidth=5)#,label="Fy: "*string(val))
        end

    end


    # Display the plot
    display(plot!())

    # If name is not empty, saves the image
    if !isempty(name)
        savefig(name*".png")
    end

end



#
# 3D
#
import Plots:plot
"""
Overload plot to show the mesh and boundary conditions.
Just for truss elements.

    plot(mesh::Mesh3D; name="", factor=6.0)

factor is used to scale arrows to a fraction of the total dimension.
"""

function plot(mesh::Mesh3D; name="", factor=6.0)


    # Local aliases
    bmesh = mesh.bmesh
    ne = bmesh.ne
 
    # Starts the plot
    plot3d();

    println("Generating the visualization...please wait")


    # Loop over the elements, extracting the nodes
    # and their coordinates

    maximum_coord_x = 0.0
    maximum_coord_y = 0.0
    maximum_coord_z = 0.0
    for ele=1:ne

        # recover the nodes
        nodes = Connect(bmesh,ele)
                
        # recover the coordinates
        c1 = Coord(bmesh,nodes[1])
        c2 = Coord(bmesh,nodes[2])

        maximum_coord_x = max(maximum_coord_x,abs(c1[1]))
        maximum_coord_y = max(maximum_coord_y,abs(c1[2]))
        maximum_coord_z = max(maximum_coord_z,abs(c1[3]))
        
        maximum_coord_x = max(maximum_coord_x,abs(c2[1]))
        maximum_coord_y = max(maximum_coord_y,abs(c2[2]))
        maximum_coord_z = max(maximum_coord_z,abs(c2[3]))

        # Adds a line to the plot
        plot3d!([c1[1],c2[1]],[c1[2],c2[2]],[c1[3],c2[3]],legend=false)
       
    end #ele

    # Show Essential boundary conditions
    for i=1:mesh.nebc

        # node
        no = Int(mesh.ebc[i,1])

        # DOF
        dof = Int(mesh.ebc[i,2])

        # Origin (node coordinates)
        coord = Coord(mesh.bmesh,no)

        # Depending on the DOF, set arrow's direction and label
        if dof==1
            origin = [coord[1],coord[1]+maximum_coord_x/factor]
            dest1  = [coord[2],coord[2]]
            dest2  = [coord[3],coord[3]]
            plot3d!(origin,dest1,dest2,arrow=true,color=:black,linewidth=2)#,label="Rx")
        elseif dof==2    
            origin = [coord[1],coord[1]]
            dest1  = [coord[2],coord[2]+maximum_coord_y/factor]
            dest2  = [coord[3],coord[3]]
            plot3d!(origin,dest1,dest2,arrow=true,color=:black,linewidth=2)#,label="Ry")
        else
            origin = [coord[1],coord[1]]
            dest1  = [coord[2],coord[2]]
            dest2  = [coord[3],coord[3]+maximum_coord_z/factor]
            plot3d!(origin,dest1,dest2,arrow=true,color=:black,linewidth=2)#,label="Ry")    
        end

    end

    # Show natural boundary conditions
    for i=1:mesh.nnbc

        # node
        no = Int(mesh.nbc[i,1])

        # DOF
        dof = Int(mesh.nbc[i,2])

        # val
        val = mesh.nbc[i,3]

        # Origin (node coordinates)
        coord = Coord(mesh.bmesh,no)

        # Depending on the DOF, set arrow's direction and label
        if dof==1
            origin = [coord[1],coord[1]+maximum_coord_x/factor]
            dest1   = [coord[2],coord[2]]
            dest2   = [coord[3],coord[3]]
            plot!(origin,dest1,dest2,arrow=true,color=:black,linewidth=5)#,label="Fx: "*string(val))
        elseif dof==2    
            origin = [coord[1],coord[1]]
            dest1   = [coord[2],coord[2]+maximum_coord_y/factor]
            dest2   = [coord[3],coord[3]]
            plot3d!(origin,dest1,dest2,arrow=true,color=:black,linewidth=5)#,label="Fy: "*string(val))
        else
            origin = [coord[1],coord[1]]
            dest1   = [coord[2],coord[2]]
            dest2   = [coord[3],coord[3]+maximum_coord_z/factor]
            plot3d!(origin,dest1,dest2,arrow=true,color=:black,linewidth=5)#,label="Fy: "*string(val))
        end

    end

    # Display the plot
    display(plot3d!())

    # If name is not empty, saves the image
    if !isempty(name)
        savefig(name*".png")
    end

end




#
# Usando os dados de apoios, monta o vetor de gls livres do problema
#
function Free_DOFs(bmesh::Bmesh,nebc::Int64,ebc::Matrix{Float64})
  
  # Dimensão da malha
  nnos = bmesh.nn

  # Se for 2D ou 3D mudamos o número de gls por nó
  dim = 2
  if isa(bmesh,Bmesh3D)
    dim=3
  end

  # Gerar um vetor de 1 até dim*nnos
  todos = collect(1:dim*nnos)
   
  # Olha quem está sendo preso e coloca um -1 no lugar
  for i=1:nebc
       no = Int(ebc[i,1])
       gl = Int(ebc[i,2])
       todos[dim*(no-1)+gl] = -1
  end     
   
  # Pega todos os valores que são maiores do que zero
  livres = todos[todos.>0]

  return livres, length(livres)
     
end

#
# Driver to use Plot_structure using mesh directly
#
function Plot_structure(mesh::Mesh;
                        U=[],
                        dscale = 0.0,
                        x=[],
                        N = [],
                        cutout = 1E-3,
                        name=""
                        )
    BMesh.Plot_structure(mesh.bmesh; U=U, dscale=dscale, x=x, N=N, cutout=cutout,name=name)
end

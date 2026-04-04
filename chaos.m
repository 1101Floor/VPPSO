

function result = chaos(index, N, dim)

switch index
   
    
    case 4
        %chebyshev 
        chebyshev=4;
        Chebyshev=rand(N,dim);
        for i=1:N
            for j=2:dim
                Chebyshev(i,j)=cos(chebyshev.*acos(Chebyshev(i,j-1)));
            end
        end
        result = Chebyshev;
        
   
        
        
end
end




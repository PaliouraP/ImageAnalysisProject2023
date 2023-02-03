% Cartesian product of hyperedge elements
C = [];
p = [];

% doing it for 500 pics cause 10200 was too much
% for each hyperedge
for row=1:500
    % for each element m of the hyperedge
    for m=1:500
        k1=H(row,m); % m's element weight
        if any(k1)
          % multiplying m with each element n of the hyperedge
            for n=1:500
                k2=H(row,n); % n's element weight
                if any(k2)
                    p(row,m,n) = hyperedge_weights(row)*k1*k2;  
                end
            end 
        end
        
    end 
    if mod(row,100) == 0
        disp('hyperedge');
        disp(row);
    end
end

% filling C
for i=1:500
    for j=1:500
        C(i,j) = sum(p(i,j,:));
    end 
    if mod(i,100) == 0
        disp(i);
    end
end
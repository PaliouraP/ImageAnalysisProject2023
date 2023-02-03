% Hypergraph construction and hyperedge weights calculation

% Hypergraph Construction
H = [];
k = 4; % hyperedge size
hyperedges = [];
for i=1:500
    hyperedges = [hyperedges; top_n(i, 1:k)];
    if mod(i,100) == 0
        disp(i);
    end
end
b = k + 1; % log base

% making the hypergraph 
% each column is a node/image and each row is a hyperedge
% H(i,j) is the weight/ possibility of a node/image (j) belonging in a
% hyperedge (i)
for i=1:500
    for j=1:500
        ti = find(hyperedges(i,:) == j);
        if ~isempty(ti)
            % 1 - log(base=b)(ti)
            H(i,j) = 1 - (log(ti)/log(b));
        else
            H(i,j) = 0;
        end
    end
    if mod(i,100) == 0
        disp(i);
    end
end
% the sum of the weights of each hyperedgs
hyperedge_weights = [];
for i=1:500
    hyperedge_weights = [hyperedge_weights, sum(H(1,:))];
end
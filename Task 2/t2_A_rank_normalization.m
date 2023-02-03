% Calculating Eucledean Distance of feature vectors 
% Rank Normalization

% Eucledean Distance
D = squareform(pdist(features));


% Keeping top-n minimum distance
n = 100;
t = [];
for i=1:500
    [xs,idx] = sort(D(i,:));
    % keeping top 100 position
    t = [t; idx(1:n)];
    if mod(i,100) == 0
        disp(i);
    end
end



% Rank Normalization
similarity_r = [];
ti = [];
tj = [];
for i=1:500
    for j=1:500
        ti = find(t(i,:) == j);
        tj = find(t(j,:) == i);
        if ~isempty(ti) && ~isempty(tj)
            similarity_r(i,j) = 2*n - (ti-1 + tj-1);
        else
            similarity_r(i,j) = 0;
        end
    end
    if mod(i,100) == 0
        disp(i);
    end
end


% Keeping top-n with largest similarity measure
top_n = [];
for i=1:500
    [xs,idx] = sort(similarity_r(i,:), 'descend');
    % keeping top 100 position
    top_n = [top_n; idx(1:n)];
    if mod(i,100) == 0
        disp(i);
    end
end
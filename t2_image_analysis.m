%filename = 'data.zip';

%file = unzip(filename,'final');
%features = [];

% Feature Extraction
%{
for i=1:10200
    f = [];
    a=imread(file{1,i});
    rc=a(:,:,1);
    [yr, x] = imhist(rc);
    gc=a(:,:,2);
    [yg, x] = imhist(gc);
    bc=a(:,:,3);
    [yb, x] = imhist(bc);
    f = [transpose(yr),transpose(yg),transpose(yb)];          
    features = [features; f];
    if mod(i,100) == 0
        disp(i);
    end
end
%}
% Eucledean Distance
%D = squareform(pdist(features));


% Keeping top-n minimum distance
%{
n = 200;
t = [];
for i=1:10200
    [xs,idx] = sort(D(i,:));
    % keeping top 200 position
    t = [t; idx(1:n)];
    if mod(i,100) == 0
        disp(i);
    end
end
%}


% Rank Normalization
%similarity_r = [];
%ti = [];
%tj = [];
%{
for i=1:10200
    for j=1:10200
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
%}



% Keeping top-n with largest similarity measure
%{
top_n = [];
for i=1:10200
    [xs,idx] = sort(similarity_r(i,:), 'descend');
    % keeping top 200 position
    top_n = [top_n; idx(1:n)];
    if mod(i,100) == 0
        disp(i);
    end
end
%}


% Hypergraph Construction
%{
H = [];
k = 4; % hyperedge size
hyperedges = [];
for i=1:10200
    hyperedges = [hyperedges; top_n(i, 1:k)];
    if mod(i,100) == 0
        disp(i);
    end
end
%}
b = k + 1; % log base
% making the hypergraph 
% each column is a node/image and each row is a hyperedge
% H(i,j) is the weight/ possibility of a node/image (j) belonging in a
% hyperedge (i)
%{
for i=1:10200
    for j=1:10200
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
%}
% the sum of the weights of each hyperedgs
%{
hyperedge_weights = [];
for i=1:10200
    hyperedge_weights = [hyperedge_weights, sum(H(1,:))];
end
%}


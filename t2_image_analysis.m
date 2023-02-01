% filename = 'data.zip';
% 
% file = unzip(filename,'final');
% features = [];
% 
% % Feature Extraction
% 
% for i=1:10200
%     f = [];
%     a=imread(file{1,i});
%     rc=a(:,:,1);
%     [yr, x] = imhist(rc);
%     gc=a(:,:,2);
%     [yg, x] = imhist(gc);
%     bc=a(:,:,3);
%     [yb, x] = imhist(bc);
%     f = [transpose(yr),transpose(yg),transpose(yb)];          
%     features = [features; f];
%     if mod(i,100) == 0
%         disp(i);
%     end
% end
% 
% % Eucledean Distance
% D = squareform(pdist(features));
% 
% 
% % Keeping top-n minimum distance
% 
% n = 200;
% t = [];
% for i=1:10200
%     [xs,idx] = sort(D(i,:));
%     %keeping top 200 position
%     t = [t; idx(1:n)];
%     if mod(i,100) == 0
%         disp(i);
%     end
% end
% 
% 
% 
% % Rank Normalization
% similarity_r = [];
% ti = [];
% tj = [];
% 
% for i=1:10200
%     for j=1:10200
%         ti = find(t(i,:) == j);
%         tj = find(t(j,:) == i);
%         if ~isempty(ti) && ~isempty(tj)
%             similarity_r(i,j) = 2*n - (ti-1 + tj-1);
%         else
%             similarity_r(i,j) = 0;
%         end
%     end
%     if mod(i,100) == 0
%         disp(i);
%     end
% end
% 
% 
% 
% 
% % Keeping top-n with largest similarity measure
% 
% top_n = [];
% for i=1:10200
%     [xs,idx] = sort(similarity_r(i,:), 'descend');
%     % keeping top 200 position
%     top_n = [top_n; idx(1:n)];
%     if mod(i,100) == 0
%         disp(i);
%     end
% end
% 
% 
% 
% % Hypergraph Construction
% 
% H = [];
% k = 4; % hyperedge size
% hyperedges = [];
% for i=1:10200
%     hyperedges = [hyperedges; top_n(i, 1:k)];
%     if mod(i,100) == 0
%         disp(i);
%     end
% end
% 
% b = k + 1; % log base
% % making the hypergraph 
% % each column is a node/image and each row is a hyperedge
% % H(i,j) is the weight/ possibility of a node/image (j) belonging in a
% % hyperedge (i)
% 
% for i=1:10200
%     for j=1:10200
%         ti = find(hyperedges(i,:) == j);
%         if ~isempty(ti)
%             % 1 - log(base=b)(ti)
%             H(i,j) = 1 - (log(ti)/log(b));
%         else
%             H(i,j) = 0;
%         end
%     end
%     if mod(i,100) == 0
%         disp(i);
%     end
% end
% 
% % the sum of the weights of each hyperedgs
% 
% hyperedge_weights = [];
% for i=1:10200
%     hyperedge_weights = [hyperedge_weights, sum(H(1,:))];
% end
% 
% 
% 
% % Hyperedge similarities
% 
% H_transposed = H.';
% % first hypothesis
% Sh = H*H_transposed;
% 
% % second hypothesis
% Sv = H_transposed*H;
% 
% % hadamard product
% S = Sh.*Sv;


% Cartesian product of hyperedge elements
C=[];
w=[];
for i=1:10200
    for j=1:10200
        ti = find(hyperedges(i,:) == j);
        if ~isempty(ti)
            
           w(i,j) = 1 - (log(ti)/log(b));
        else
            w(i,j) = 0;
        end
    end
end


p=[];

for row=1:10200
    v=w(row,:);
    for i=1:1
        for m=1:10200
            k1=v(i,m);
            for n=1:10200
                k2=v(i,n);
                p=[p,k1(1,1).*k2];        
            end
        end
    end
end

C=[];
p_final=reshape(p,[],10200)';
[m,n]=size(p_final);
C=sum(p_final,1);
C=reshape(C,[],10200)';

%Hypergraph-Based Similarity
W = [];
W=C.*S;













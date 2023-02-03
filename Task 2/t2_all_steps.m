% DATA AND FEATURE EXTRACTION 
% filename = '..\data.zip';
% 
% file = unzip(filename,'data');
% features = [];
% 
% % Feature Extraction
% for i=1:500
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
% n = 100;
% t = [];
% for i=1:500
%     [xs,idx] = sort(D(i,:));
%     %keeping top 100 position
%     t = [t; idx(1:n)];
%     if mod(i,100) == 0
%         disp(i);
%     end
% end


% % STEP 1
% % Rank Normalization
% similarity_r = [];
% ti = [];
% tj = [];
% 
% for i=1:500
%     for j=1:500
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
% % Keeping top-n with largest similarity measure
% 
% top_n = [];
% for i=1:500
%     [xs,idx] = sort(similarity_r(i,:), 'descend');
%     % keeping top 100 position
%     top_n = [top_n; idx(1:n)];
%     if mod(i,100) == 0
%         disp(i);
%     end
% end


% % STEP 2
% % Hypergraph Construction
% 
% H = [];
% k = 4; % hyperedge size
% hyperedges = [];
% for i=1:500
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
% for i=1:500
%     for j=1:500
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
% for i=1:500
%     hyperedge_weights = [hyperedge_weights, sum(H(1,:))];
% end



% % STEP 3
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


% % STEP 4
% % Cartesian product of hyperedge elements
% C = [];
% p = [];
% 
% % doing it for 500 pics cause 500 was too much
% % for each hyperedge
% for row=1:500
%     % for each element m of the hyperedge
%     for m=1:500
%         k1=H(row,m); % m's element weight
%         if any(k1)
%           % multiplying m with each element n of the hyperedge
%             for n=1:500
%                 k2=H(row,n); % n's element weight
%                 if any(k2)
%                     p(row,m,n) = hyperedge_weights(row)*k1*k2;  
%                 else
%                     p(row,m,n) = 0;
%                 end
%             end 
%         else
%             p(row,m,:) = 0;
%         end
%         
%     end 
%     if mod(row,100) == 0
%         disp('hyperedge');
%         disp(row);
%     end
% end
% 
% % filling C
% for i=1:500
%     for j=1:500
%         C(i,j) = sum(p(i,j,:));
%     end 
%     if mod(i,100) == 0
%         disp(i);
%     end
% end


% % STEP 5
% %Hypergraph-Based Similarity
% W = [];
% W=C.*S;













% Hyperedge similarities
 
H_transposed = H.';
% first hypothesis
Sh = H*H_transposed;
 
% second hypothesis
Sv = H_transposed*H;
 
% hadamard product
S = Sh.*Sv;

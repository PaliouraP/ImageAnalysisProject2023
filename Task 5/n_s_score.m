% The N-S score is computed between 1 and 4. It corresponds to the number
% of relevant images among the first four image returned. This is a
% specific effectiveness measure since we use part of the UKBench dataset,
% which is composed of 125 of the original 2550 scenes. Each scene is 
% captured 4 times from different viewpoints, distances, and
% illumination conditions 

%--------- FOR ARRAYS WITH WEIGHTS (EX. W)
target_array = W;

perfect_ranking = [];
for i=1:4:500
    for j=i:i+3
        perfect_ranking(i:i+3,j) = 1;
    end
end



% replacing non-zero values with 1 on target array
target_idx = target_array~=0;
ns_sum = 0;
for row=1:500
    mp=target_array(row,:)
    k=nnz(target_array(row,:) & perfect_ranking(row,:))
    ns_sum = (nnz(target_array(row,:) & perfect_ranking(row,:))) + ns_sum;
end
ns_score = ns_sum/500;
table=convertCharsToStrings('table W');
ns_score_final_results=[ns_score_final_results;table,ns_score];




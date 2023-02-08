% The N-S score is computed between 1 and 4. It corresponds to the number
% of relevant images among the first four image returned. This is a
% specific effectiveness measure since we use part of the UKBench dataset,
% which is composed of 125 of the original 2550 scenes. Each scene is 
% captured 4 times from different viewpoints, distances, and
% illumination conditions 

%--------- FOR ARRAYS WITH RANKED LISTS (EX. t)
target_array_alt = top_n(:,1:4); % we only need the first 4 objects for each row 

perfect_ranking_alt = [];
for i=1:4:500
    for j=1:4
        perfect_ranking_alt(i:i+3,j) = i+j-1;
    end
end

ns_sum_alt = 0;
for row=1:500
    for col=1:4
        if ismember(target_array_alt(row,col),perfect_ranking_alt(row,:))
            ns_sum_alt = ns_sum_alt + 1;
        end
    end    
end
ns_score_alt=[];
ns_score_alt = ns_sum_alt/500;
table=convertCharsToStrings('table top_n');
ns_score_final_results=[ns_score_final_results;table,ns_score_alt];

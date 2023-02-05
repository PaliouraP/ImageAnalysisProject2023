r=[];
result=[];

%non zero elements of matrix W
%non_zero=W(W~=0);

rows_table=[];
for m=1:4
    n = randsample(500,1);
    rows_table(end+1)=n;
end

for r=1:length(rows_table)
    most_similar=find(W(rows_table(r),:))
    figure;
    for i=1:length(most_similar)     
        [x,y]=imread(file{most_similar(i)});
        subplot(1,4,i),imshow(x,y);
        hold on;
    end
end







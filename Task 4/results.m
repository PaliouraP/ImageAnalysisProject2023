r=[];
result=[];

%non zero elements of matrix W
%non_zero=W(W~=0);

rows_table=[];

rows_table = randsample(500,4);


for r=1:length(rows_table)
    [x1,most_similar] = maxk(W(rows_table(r),:),4)
    figure;
    for i=1:length(most_similar)     
        [x,y]=imread(file{most_similar(i)});
        subplot(1,4,i),imshow(x,y);
    end
end







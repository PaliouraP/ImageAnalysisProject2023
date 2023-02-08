r=[];
result=[];


rows_table=[];

rows_table = randsample(500,4);


for r=1:length(rows_table)
    [x1,most_similar] = maxk(W(rows_table(r),:),4)
    figure('Name','Similar images');
    set(gcf,'color','w');
    o=file{rows_table(r)};
    o=convertCharsToStrings(o);
    o=split(o,"\")
    sgt=sgtitle('Images similar to image '+o(3)+"",'Color', '#8FBEA9')

    for i=1:length(most_similar)     
        [x,y] = imread(file{most_similar(i)});
        [m,n] = imread(file{rows_table(r)});
        o1 = file{most_similar(i)};
        o1 = convertCharsToStrings(o1);
        o1 = split(o1,"\");
        subplot(4,1,i);
        imshow(x,y);
        title ("Image "+o1(3)+": Image similarity: " + x1(i) + "",'FontSize',9,'FontWeight','normal',Color="#E3472B");
    end
end
    






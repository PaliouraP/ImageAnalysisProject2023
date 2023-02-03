% Opening the file 
% Feature extraction with color histograms

filename = '..\data.zip';

file = unzip(filename, 'data');
features = [];

% Feature Extraction
for i=1:500
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
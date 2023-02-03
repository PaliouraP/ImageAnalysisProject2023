filename = '..\data.zip';

file = unzip(filename,'data');

% -------------------------------------------------------------------------
% Generate the image data store object by parsing the directory structure
% of the loaded data folder.
% -------------------------------------------------------------------------
image_datastore = imageDatastore(file,'IncludeSubfolders',true,...
                                'LabelSource','foldernames');

% -------------------------------------------------------------------------
% Load a pretrained network.
% -------------------------------------------------------------------------

% In this case, ResNet-18 will be use. ResNet-18 is trained on more than a
% million images and can classify images into 1000 categories such as:
% keyboard, mouse, pencil, and many animals. Thus, the resulting network
% model has learned rich feature representations for a wide variety of 
% images.
net = resnet18;

% -------------------------------------------------------------------------
% DO NOT FORGET TO RUN THE FOLLOWING LINE OF CODE IN THE COMMAND LINE!!!!!
% -------------------------------------------------------------------------
% Analyze the network architecture.
%analyzeNetwork(net);
% -------------------------------------------------------------------------

% Get the shape of the image input layer.
% The first layer of the resnet network requires images of size 
% 224 x 224 x 3 where 3 is the number of the color channels.
InputSize = net.Layers(1).InputSize;

% -------------------------------------------------------------------------
% Extract Image Features.
% -------------------------------------------------------------------------

% ResNet requires input images to be of size 224 x 224 x 3. The images 
% contained in the datastore, however, have different sizes. Therefore,
% in order to automatically resize the training and test images, an 
% augmented image datastore should be created by specifying the desired
% image size.
augmented_image_datastore = augmentedImageDatastore(InputSize(1:2),...
                                                       image_datastore);


% The network constructs a hierarchical representation of the input images.
% Deeper layers contain highe-level features, constructed using the
% lower-level features of earlier layers. Getting the feature
% representations of the training and testing images may be accomplished by
% using the activations on the global pooling layer "pool5", at the last 
% layer of the network. The global pooling layer pools the input features
% over all spatial locations, resulting in 512-dimensional feauture vector.
features = [];
layer = 'pool5';
features = activations(net,augmented_image_datastore,layer,...
                               'OutputAs','rows');
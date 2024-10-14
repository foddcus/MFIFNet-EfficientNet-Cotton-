
Pane="I:\DenseDataU8_shape";
imdsTrain = imageDatastore(Pane,"IncludeSubfolders",true,"LabelSource","foldernames");

[imdsT, imdsTest] = splitEachLabel(imdsTrain,0.75,'randomized');

[imdsTrain, imdsValidation] = splitEachLabel(imdsT,1/3,'randomized');
    inputS=[600 400 14];
    imageAugmenter = imageDataAugmenter(...
        "RandRotation",[-90 90],...
        "RandScale",[0.5 2]);
    augimdsTrain = augmentedImageDatastore(inputS,imdsTrain,"DataAugmentation",imageAugmenter);
    augimdsValidation = augmentedImageDatastore(inputS,imdsValidation);

batchs=32;
opts = trainingOptions("adam",...
    "ExecutionEnvironment","gpu",...
    "InitialLearnRate",0.01,...
    "MiniBatchSize",batchs,...
    "Shuffle","every-epoch",...
    "Plots","training-progress",...
    "ValidationData", augimdsValidation, "MaxEpochs", 400, "ValidationFrequency", floor(size(imdsTrain.Labels,1)/batchs)*25); %mini64-Validation80(5120)


lgraph=Build_FNet_4_5_EfiB4(inputS);   
[net, traininfo] = trainNetwork(augimdsTrain,lgraph,opts);
Yt=imdsValidation.Labels;
Yp = classify(net,imdsTest);
function inputSize=IFcombine(net,locoindex,LastIndex,outputSizeList)


inputSize=[0 0 0];
layer = net.Layers(locoindex);

% 根据层类型进行计算

if compareStr(class(net.Layers(locoindex)),'nnet.cnn.layer.AdditionLayer') || compareStr(class(net.Layers(locoindex)),'nnet.cnn.layer.MultiplicationLayer')
    %如果是相乘和相加，则大小不变
    inputSize=outputSizeList(LastIndex(1),1:3);

elseif compareStr(class(net.Layers(locoindex)),'nnet.cnn.layer.DepthConcatenationLayer') %如果是深度拼接层
    %如果是深度相连，深度相加
    inputSize(1:2)=outputSizeList(LastIndex(1),1:2);
    for i=1:length(LastIndex)
        inputSize(3)=inputSize(3)+outputSizeList(LastIndex(i),3);
    end
elseif compareStr(class(net.Layers(locoindex)), 'nnet.cnn.layer.Crop2DLayer') 
    inputSize=outputSizeList(LastIndex(1),1:3);
end

end


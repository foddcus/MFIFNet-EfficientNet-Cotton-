%Flops计算单元,用于计算CNN的Flops，承上启下式的计算CNN的算力需求，
% 具体而言，输入要调查CNN的层的位置，输入数据大小
% 返回该层的算力消耗，以及下一链接层的位置

%outputSize=[R R C]

function  [flops,NextIndex,outputSize,IFmulti]= ComputLayer(net,locoindex,inputSize)

% 初始化FLOPS计数器
%class(net.Layers(2))
flops = 0;
layer = net.Layers(locoindex);
[NextIndex,IFmulti] = SearchNextLayer(net,locoindex)

% 根据层类型进行计算

if compareStr(class(net.Layers(locoindex)),'nnet.cnn.layer.ImageInputLayer') %如果是输入层，获取输入和输出
    outputSize=net.Layers(locoindex).InputSize;



elseif compareStr(class(net.Layers(locoindex)),'nnet.cnn.layer.Convolution2DLayer')%如果是卷积层

    % 卷积层的FLOPS计算公式：(2 * C_in * K^2 ) * H_out * W_out * C_out
    % 其中，C_in是输入通道数，K是卷积核尺寸，H_out和W_out是输出尺寸，C_out是输出通道数
    % 这里的"×2”是因为每次乘法运算需要两次浮点操作（一次乘法和一次累加）。但是，有些情况下可能会省略这个“×2”，因为计算机视觉中常把一次乘法和加法合在一起计算。
    %Cin = layer.NumChannels; % 输入通道数
    Cin=inputSize(3);
    K= layer.FilterSize; % 卷积核尺寸，假设是正方形卷积核
    outputSize(1) = ceil(inputSize(1)/layer.Stride(1)); % 输出高度
    outputSize(2) =ceil(inputSize(2)/layer.Stride(2)); % 输出宽度
    outputSize(3) = layer.NumFilters; % 输出通道数
    flops =(2*Cin*K(1)*K(2)-1) * outputSize(1)* outputSize(2)* outputSize(3);

elseif compareStr(class(net.Layers(locoindex)),'nnet.cnn.layer.GroupedConvolution2DLayer')%如果是分组卷积层

    %Cin = layer.NumChannelsPerGroup*layer.NumGroups; % 输入通道数
    Cin =inputSize(3); % 输入通道数
    K= layer.FilterSize; % 卷积核尺寸，假设是正方形卷积核
    outputSize(1) = ceil(inputSize(1)/layer.Stride(1)); % 输出高度
    outputSize(2) =ceil(inputSize(2)/layer.Stride(2)); % 输出宽度
    outputSize(3) = layer.NumFiltersPerGroup * layer.NumGroups; % 输出通道数
    flops =(K(1)*K(2)*Cin/layer.NumGroups) * outputSize(1)* outputSize(2)* outputSize(3);


elseif compareStr(class(net.Layers(locoindex)),'nnet.cnn.layer.FullyConnectedLayer')%如果是全连接层
    % 全连接层的FLOPS计算公式：(2 * I * O
    % 其中，I是输入神经元数量，O是输出神经元数量
    %I = layer.InputSize; % 输入神经元数量
    I=inputSize(3);
    O = layer.OutputSize; % 输出神经元数量
    flops =(2*I-1) * O;
    outputSize=[1 1 O];

elseif compareStr(class(net.Layers(locoindex)),'nnet.cnn.layer.MaxPooling2DLayer')|| compareStr(class(net.Layers(locoindex)), 'nnet.cnn.layer.AveragePooling2DLayer')
    %如果是池化层
    outputSize(1) = ceil(inputSize(1)/layer.Stride(1)); % 输出高度
    outputSize(2) =ceil(inputSize(2)/layer.Stride(2)); % 输出宽度
    outputSize(3)=inputSize(3);

elseif compareStr(class(net.Layers(locoindex)),'nnet.cnn.layer.Resize2DLayer')
    %如果是缩放层
    if isempty(layer.OutputSize)
        outputSize(1:2)=inputSize(1:2).*layer.Scale;
        outputSize(3)=inputSize(3);
    else
        outputSize(1:2)=layer.OutputSize;
        outputSize(3)=inputSize(3);
    end

elseif compareStr(class(net.Layers(locoindex)), 'nnet.cnn.layer.GlobalAveragePooling2DLayer')
    %如果是全局池化层
    outputSize(1:2)=[1 1];
    outputSize(3)=inputSize(3);

else
    warning(['Uncalculate layer type: %s', class(net.Layers(locoindex))]);
    outputSize=inputSize;
end

end
%Flops计算单元,用于计算CNN的Flops，承上启下式的计算CNN的算力需求，
% 具体而言，输入要调查CNN的层的位置，输入数据大小
% 返回该层的算力消耗，以及下一链接层的位置


function  [flops,locaNum]= calculate_cnn_flops(net,inputLocaN)

% 初始化FLOPS计数器
class(net.Layers(2))
flops = 0;
ThisLayerName='';
searchIndex=[];%用于存放已搜寻后的数据
layer = net.Layers(inputLocaN);


% 根据层类型进行计算
if class(net.Layers(inputLocaN))=='nnet.cnn.layer.ImageInputLayer'%如果是输入层
    numSize=net.Layers(inputLocaN).InputSize;
    ThisLayerName=net.Layers(inputLocaN).Name;
    locaNum=serchNextLayer(ThisLayerName);

    
    serachNum_Repeat=0;%算子
    %寻找下一层网络单元
    for j=1:length(net.Connections.Source) %遍历
        if length(net.Connections.Source{2})==length(ThisLayerName)%如果名字长度相同
            if all(net.Connections.Source{2}==ThisLayerName)%如果名字一样

            end
        end

        if class(net.Layers(inputLocaN))=='nnet.cnn.layer.Convolution2DLayer'%如果是卷积层

            % 卷积层的FLOPS计算公式：(2 * C_in * K^2 - 1) * H_out * W_out * C_out
            % 其中，C_in是输入通道数，K是卷积核尺寸，H_out和W_out是输出尺寸，C_out是输出通道数
            % 减1是因为偏置项只需要加一次，而不是每个输出都加一次
            Cin = size(layer.inputSize, 3); % 输入通道数
            K = layer.kernelSize; % 卷积核尺寸，假设是正方形卷积核
            Hout = layer.outputSize(1); % 输出高度
            Wout = layer.outputSize(2); % 输出宽度
            Cout = size(layer.weights, 4); % 输出通道数
            flops = flops + (2 * Cin * K^2 - 1) * Hout * Wout * Cout;

        case 'fc'
            % 全连接层的FLOPS计算公式：(2 * I - 1) * O
            % 其中，I是输入神经元数量，O是输出神经元数量
            % 减1是因为偏置项只需要加一次，而不是每个输出都加一次
            I = prod(layer.inputSize); % 输入神经元数量
            O = prod(layer.outputSize); % 输出神经元数量
            flops = flops + (2 * I - 1) * O;

            % 其他层类型（如ReLU、池化等）在此处添加计算逻辑（如果需要的话）
            % 但注意，这些层通常不计入FLOPS统计中

        otherwise
            warning('Unknown layer type: %s', layer.type);
        end
    end

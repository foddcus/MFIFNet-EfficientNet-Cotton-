function [NextIndex,IFmulti] = SearchNextLayer(net,locoindex)
%SEARCHNEXTLAYER 此处显示有关此函数的摘要
%   此处显示详细说明
ThisLayerName=net.Layers(locoindex).Name;
serachNum_Repeat=0;%算子
IFmulti=false;
NextIndex=0;
%%寻找下一层网络单元
%先找到该层相关的下一节点
for j=1:length(net.Connections.Source) %遍历
    if compareStr(net.Connections.Source{j},ThisLayerName)
        DestinIndex(serachNum_Repeat+1)=j;
        serachNum_Repeat=serachNum_Repeat+1;
    end
end
%根据节点的名字找到该层
if serachNum_Repeat==1
    NextLayerName=net.Connections.Destination{DestinIndex(1)};

    for j=1:length(net.Layers) %遍历

        if length(net.Layers(j).InputNames)>1%如果该层有多个输入
            for jj=1:1:length(net.Layers(j).InputNames)
                if compareStr(strjoin([net.Layers(j).Name,'/',net.Layers(j).InputNames(jj)],''),NextLayerName)
                    NextIndex=j;
                    IFmulti=true;
                end
            end

        else%正常情况下
            if compareStr(net.Layers(j).Name,NextLayerName)
                NextIndex=j;
            end
        end
    end


else
    IFmulti=true;
end



end



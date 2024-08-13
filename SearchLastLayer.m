function [LastIndex,IFSatisf] = SearchLastLayer(net,locoindex,outputSizeList)
%SEARCHNEXTLAYER
% 输入： 网络：net；查询的layer的INdex：locoindex； 各层layer的输出size：outputSzielist
% 输出： 上一层网络的index LastIndex  该层的输入数据是否满足（皆不为0）：IFSaticf；该层输入尺寸ThisLayerInputSize
ThisLayerName=net.Layers(locoindex).Name;
serachNum_Repeat=0;%算子

%先找到该层相关的上一节点
if length(net.Layers(locoindex).InputNames)>1%如果该层有多个输入
    for j=1:length(net.Connections.Destination) %遍历链接表
        for jj=1:1:length(net.Layers(locoindex).InputNames)%遍历接收口
            if compareStr(strjoin([net.Layers(locoindex).Name,'/',net.Layers(locoindex).InputNames(jj)],''),net.Connections.Destination{j})
                SoureIndex(serachNum_Repeat+1)=j;
                serachNum_Repeat=serachNum_Repeat+1;
            end
        end
    end
else%正常情况下
    for j=1:length(net.Connections.Destination) %遍历连接表
        if compareStr(net.Connections.Destination{j},ThisLayerName)%如果名字一样
            SoureIndex(serachNum_Repeat+1)=j;
            serachNum_Repeat=serachNum_Repeat+1;
        end
    end
end




%根据节点的名字找到该层
for i=1:serachNum_Repeat
    NextLayerName=net.Connections.Source{SoureIndex(1)};
    for j=1:length(net.Layers) %遍历
        if compareStr(net.Layers(j).Name,NextLayerName)%如果名字一样
            LastIndex(i)=j;
        end
    end
end


%检查以上这些输入是否知道尺度
for i=1:serachNum_Repeat
    %查表
    if outputSizeList(LastIndex(i),1)~=0
    else
        IFSatisf=false;
        break
    end
    IFSatisf=true;
end


end


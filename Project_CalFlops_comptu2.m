%计算net的Flops
%输入net即可


locoindex=1;
FlopsAll=0;
hasUnserachLayer=true;
inputSize=[0 0 0];
layernum=length(net.Layers);
inputSizeList=zeros(layernum,3);
outputSizeList=zeros(layernum,3);
 
while hasUnserachLayer
     % if locoindex==54
     %     break
     % end
    inputSizeList(locoindex,1:3)=inputSize;
    [flops,NextIndex,outputSize,IFmulti]= ComputLayer(net,locoindex,inputSize);%计算该层所需算力
    FlopsAll=FlopsAll+flops
    %存入该层信息
    outputSizeList(locoindex,1:3)=outputSize;

    %先判断是否所有层都被调查完了
    if any(outputSizeList()==0)
    else
        break
    end


    if IFmulti %如果该层或下一层是多个输入或输出 ，则找到最近能满足输入信息的层
        for i=1:layernum
            if outputSizeList(i)==0%如果调查过，都会有outputsize的信息
                %%调查上层的信息
                [LastIndex,IFSatisf] = SearchLastLayer(net,i,outputSizeList);

                if IFSatisf%满足
                    locoindex=i;

                    if length(LastIndex)>1  %如果是多个输入
                        inputSize=IFcombine(net,locoindex,LastIndex,outputSizeList);
                    else %如果是单个输入
                        inputSize=outputSizeList(LastIndex(1),:);
                    end

                    break
                end
            end
        end
    else%如果是一一对接，就直接调查下一层的信息
        locoindex=NextIndex;
        inputSize=outputSize;
    end

end
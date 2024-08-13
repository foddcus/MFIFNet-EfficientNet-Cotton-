function logiRecall = compareStr(name1,name2)
%COMPARESTR 此处显示有关此函数的摘要
%   此处显示详细说明
logiRecall=false;
    if length(name1)==length(name2)%如果名字长度相同
        if all(name1==name2)%如果名字一样
            logiRecall=true;

        end
    end
end


%���� maskΪ2ֵ��ͼ��
%���ض������ڵķָ����ﲻ�����������������

function output=DeleNos_dot(mask,length,Percent)

numDiv=ceil(Percent*length^2);
[ysize,xsize]=size(mask);

for i=length:xsize-length%�������ɰ�������ж������ӵ�
    for j=length:ysize-length
        if mask(j,i)==1
            if sum(sum(mask(j-3:j+3,i-3:i+3)))<numDiv
                mask(j,i)=0;
            end
        end
    end
end
output=mask;
%��ֵ�ָ��,��÷ָ���ɰ�

%���룺img��ͼ��(�Ҷ�ͼ��  
% ThresH:��ֵ
% ��Ϊ0ʱΪ��ֵ���ָ�,Ϊ1ʱΪ������ȫ����ֵ�ָΪ2ʱΪȫ����ֵOtsu����ֵ�ָ��Ϊ������̬ѧԪ�صľֲ��ָ�,4Ϊָ����ֵ�ָ
%pluse���������ݣ���ThresHΪ3ʱ��pluse��ʾ��̬ѧ��Ԫ�صİ뾶����ֵԽ�󣬷ָ�����Խ��Ϊ4ʱΪ�ָ����

function output=T_SGM(img,ThresH,pluse)

img=im2double(img);%ͼ���ֵ��

if ThresH==0
    output =im2double(imbinarize(I));
elseif ThresH==1
    T=0.5*(min(img(:))+max(img(:)));
    done=false;
    while ~done
       	g=(img>=T);%��������g��Ϊ������ֵ�Ĳ���
       	Tn=0.5*(mean(img(g))+mean(img(~g)));%��ͼ����g���������g������ľ�ֵ�ӽ���Ŀ����ֵʱ���ָ����
       	done = abs(T-Tn)<0.1;
       	T=Tn;
    end
    output=imbinarize(img,T);
elseif ThresH==2
    Th=graythresh(img);%��ֵ
    output=imbinarize(img,Th);
elseif ThresH==3
    se=strel('disk',pluse);%������̬ѧ �ṹԪ��
    ft=imtophat(img,se);%ʹ�ýṹԪ�ؽ����˲�
    Thr=graythresh(ft);%����˲����ͼ�������ֵȡֵ
    output = imbinarize(ft,Thr);
elseif ThresH==4
    output=imbinarize(img,pluse);
end


end


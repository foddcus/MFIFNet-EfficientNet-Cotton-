%WaveFusionProject
clear all
orinpath=cd();
ScrDir='C:\Users\94562\Desktop\DenseDataU8_shape';
ScrDir2='C:\Users\94562\Desktop\ShapeWave-Compress-FileCotton';
filelist=dir(ScrDir);
[numf,~]=size(filelist);
maxNum=zeros(14);
for i=3:numf
    secondScr=[ScrDir,'/',filelist(i).("name")];
    secondScr_2=[ScrDir2,'/',filelist(i).("name")];
    filelist_2=dir(secondScr);
    [numf2,~]=size(filelist_2);
    for j=1:numf2-2
        cd(secondScr);
        aimNum=j+2;
        pic16=imread(filelist_2(aimNum).("name"));
        pic8=imresize(pic16,[224,224]);%注意输出分辨率
        cd(orinpath);
        fusedImage=waveFusion(pic8);
        cd(secondScr_2);
        imwrite(fusedImage,[num2str(aimNum-2),'.jpg']);
        clc
        %filelist_2(aimNum).("name")
    end

end
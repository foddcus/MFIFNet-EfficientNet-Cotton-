%clear all
%image = imread("C:\Users\94562\Desktop\DenseDataU8_shape\CK\KW0_00_42_14.tif");
function FM=waveFusion(image)

% 将图像转换为灰度图像（如果输入图像是彩色图像）
% 执行小波分解
nLevels = 5; % 小波分解的层数
wavelet = 'sym8'; % 小波基函数（这里使用symlet 是Daubechies的改进版）
for i=1:14
[coeff(:,i), S(:,:,i)] = wavedec2(image(:,:,i), nLevels, wavelet);
%energy(i) = sum(abs(coeffs(:,i)).^2, 'all');
end
%融合
%fusedCoeff = max(coeff,2);
fusedCoeffC1 = mean(coeff(:,1:3),2); % 这里使用简单的平均融合
fusedCoeffC2 = mean(coeff(:,4:6),2);
fusedCoeffC3 = mean(coeff(:,7:9),2);
fusedCoeffC4 = mean(coeff(:,10:12),2);
fusedCoeffC5 = mean(coeff(:,13:14),2);
% 执行小波逆变换
fusedImage(:,:,1) = waverec2(fusedCoeffC1, S(:,:,1), wavelet).*2;
fusedImage(:,:,2) = waverec2(fusedCoeffC2, S(:,:,1), wavelet).*2;
fusedImage(:,:,3) = waverec2(fusedCoeffC3, S(:,:,1), wavelet);
fusedImage(:,:,4) = waverec2(fusedCoeffC4, S(:,:,1), wavelet);
fusedImage(:,:,5) = waverec2(fusedCoeffC5, S(:,:,1), wavelet);
FM=uint8(fusedImage);

% 显示原始图像和融合后的图像
% figure;
% imshow(uint8(fusedImage(:,:,:))), title('Fused Image');
% %max(max(fusedImage(:,:,3)))
end

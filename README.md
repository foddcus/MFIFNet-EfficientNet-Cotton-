
利用PCA-WA进行图像融合时请运行：“FusionPic_Wa_PCA.mlx",该程序需要读取储存原始数据文件夹，关于该脚本的详细说明，可以参考：https://blog.csdn.net/m0_47787372/article/details/134970406?spm=1001.2014.3001.5501
WA图像融合通过对来自不同图像的对应像素进行加权平均，以得到融合后图像中的每个像素值。这种方法具有简单易实现、运算速度快的优点，并能提高融合图像的信噪比。然而，它也存在一些缺点，比如可能会削弱图像中的细节信息，降低图像的对比度，并在一定程度上使图像中的边缘变得模糊。为了改进这些缺点，可以采用一些优化方法，如主成分分析（Principal Component Analysis，PCA）来优化权值的选择，从而得到一幅亮度方差最大的融合图像。

When performing image fusion using PCA-WA, please run the "FusionPic_Wa_PCA.mlx" script. This script needs to read the folder where the original data is stored. For detailed instructions on this script, please refer to: https://blog.csdn.net/m0_47787372/article/details/134970406?spm=1001.2014.3001.5501.
WA image fusion obtains each pixel value in the fused image by calculating the weighted average of corresponding pixels from different images. This method boasts advantages such as simplicity in implementation, fast computation speed, and the ability to enhance the signal-to-noise ratio of the fused image. However, it also harbors certain drawbacks. For instance, it may attenuate detailed information within the image, reduce image contrast, and, to some extent, blur the edges in the image. To mitigate these shortcomings, optimization techniques can be employed, such as Principal Component Analysis (PCA), to refine the selection of weights, thereby producing a fused image with maximized luminance variance.

![image](https://github.com/user-attachments/assets/603f81ce-607e-4d39-b3db-2d2be41b0c40)

![image](https://github.com/user-attachments/assets/9344022f-5b2b-4ff2-9a58-b38a62ebffd8)

利用小波变化进行图像融合时，请使用"waveFusionProject.m".

![image](https://github.com/user-attachments/assets/ffa58902-0c2e-49b2-a465-ba446a64afc4)


运行calculate_cnn_flops.m可以计算CNN的FLOPs，需要先load模型，模型参数名设置为net。
MIFI-Net-EfficientNet-b0对应“Build_FNet_4_5_EfiB0.mlx”，其运用的拉布普拉斯变化层对应函数“ProjectectLYPgetLayer.m"，建立模型时请将该函数放置在同一目录内。

Running "calculate_cnn_flops.m" can calculate the FLOPs (Floating Point Operations) of a CNN. Before that, you need to load the model, and the model parameter name should be set as "net". The MIFI-Net-EfficientNet-b0 corresponds to "Build_FNet_4_5_EfiB0.mlx", and its employed Laplace-like Pyramid transformation layer corresponds to the function "ProjectectLYPgetLayer.m". When building the model, please place this function in the same directory.


当训练模型时，matlab代码可以参考一下示例：Train.m
When training the model, you can refer to the following MATLAB code example:Train.m

原始数据下载连接（raw data download）
Cotton 2023-Rawdata-without calibration
Link: https://pan.baidu.com/s/14A4bDoWhStrBR-owU3DTfg?pwd=xc8k 

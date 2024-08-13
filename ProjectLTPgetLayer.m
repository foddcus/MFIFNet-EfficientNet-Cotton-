classdef ProjectLTPgetLayer < nnet.layer.Layer ...
        & nnet.layer.Formattable

    properties
        % Layer properties.
    end

    properties (Learnable)
        % Layer learnable parameters.
    end

    methods

        function layer =  ProjectLTPgetLayer(Name)


            arguments
                Name;
            end

            % Set layer name.
           
            layer.Name = Name;

            % Set layer description.
            layer.Description = "get LTP imagine in 2 levels"

            % Set layer type.
            layer.Type = "LTP";

            % Set output size.
        end

        function Z = predict(layer,X)
            % Forward input data through the layer at prediction time and
            % output the result.

            % 对图像进行高斯平滑
            % w=[1,4,6,4,1];
            % w=1/256*(w'*w);
            % for
            % X1(:,:,i)=conv2(extractdata(X(:,:,1)),w,'same');

             X1 = imgaussfilt(extractdata(X), 2); % 2是标准差，可以根据需要调整  
            Z=X-X1;
            Z = dlarray(Z,"SSCB");
        end
    end
end
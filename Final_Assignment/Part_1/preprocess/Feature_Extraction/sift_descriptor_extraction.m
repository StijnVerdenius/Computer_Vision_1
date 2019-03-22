function descriptors_concat = sift_descriptor_extraction(img, method, colorspace)	 % DOCSTRING_GENERATED
 % SIFT_DESCRIPTOR_EXTRACTION		 [transforms image to sift descriptors]
 % INPUTS 
 %			img = one image
 %			method = 'keypoint' or 'dense'
 %			colorspace = 'grayscale', 'rgb' or 'opponent'
 % OUTPUTS 
 %			descriptors_concat = descriptors of this image


assert((strcmp( method, "keypoint")) || (strcmp( method, "dense")));
assert((strcmp( colorspace, "grayscale")) || (strcmp( colorspace, "rgb")) || (strcmp( colorspace, "opponent")));

% for pre smoothing
binSize = 9 ;
magnif = 3 ;
smoothing_constant = sqrt((binSize/magnif)^2 - .25);

% get descriptors
switch colorspace
    case 'grayscale'
        img_gray = ConvertColorSpace(img, 'gray'); 
        descriptors = cell(1,1);
        if (strcmp( method, "keypoint"))
            [~, descriptors{1}] = vl_sift(im2single(img_gray));
        else
            [~, descriptors{1}] = vl_dsift(vl_imsmooth(im2single(img_gray), smoothing_constant), 'step', 5, 'size', 21, 'fast');
        end
    case 'rgb'
        descriptors = cell(1,3);
        if (strcmp( method, "keypoint"))
            for channel=1:3
                [~, descriptors{channel}] = vl_sift(im2single(img(:, :, channel)));
            end
        else
            for channel=1:3
                [~, descriptors{channel}] = vl_dsift(vl_imsmooth(im2single(img(:, :, channel)), smoothing_constant), 'step', 5, 'size', 21, 'fast');
            end
        end
    case 'opponent'
        img_opp = ConvertColorSpace(img, 'opponent');
        descriptors = cell(1,3);
        if (strcmp( method, "keypoint"))
            for channel=1:3
                [~, descriptors{channel}] = vl_sift(im2single(img_opp(:, :, channel)));
            end
        else
            for channel=1:3
                [~, descriptors{channel}] = vl_dsift(vl_imsmooth(im2single(img_opp(:, :, channel)), smoothing_constant), 'step', 5, 'size', 21, 'fast');
            end
        end
    otherwise
        error("unrecognized sift option: "+ method);
end   

descriptors_concat = cell2mat(descriptors);

end
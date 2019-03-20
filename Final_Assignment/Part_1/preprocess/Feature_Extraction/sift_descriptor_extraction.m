function descriptors_concat = sift_descriptor_extraction(img, method, colorspace)
% transforms image to sift descriptor (gray-scale only) (NOT FINISHED)



img_gray = ConvertColorSpace(img, 'gray'); % transform to grayscale
img_opp = ConvertColorSpace(img, 'opponent');

% TODO: presmoothing???

if (strcmp( method, "dense"))
    
    binSize = 9 ;
    magnif = 3 ;
    smoothing_constant = sqrt((binSize/magnif)^2 - .25);
    
    switch colorspace
        case 'grayscale'
            descriptors = cell(1,1);
            if (strcmp( method, "keypoint"))
                [~, descriptors{1}] = vl_sift(im2single(img_gray)); % get descriptors
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
% TODO: tune vldsift parameters
% TODO: check if the right descriptors are being returned.
% TODO: do we need the frames?

end
function [] = get_sds(image, size)

ids = [];
PSNR_values = [];

for stde = 1:10
    i2 = denoise(image, 'gaussian', size, stde);
    ids = [ids, stde];
    PSNR_values = [PSNR_values, myPSNR(image, i2)];
end
        
M = containers.Map(PSNR_values,ids);

% b_sd = M(max(PSNR_values));

sd = [ids(1);ids(2);ids(3);ids(4);ids(5);ids(6);ids(7);ids(8);ids(9);ids(10)];
PSNR_t = [PSNR_values(1);PSNR_values(2);PSNR_values(3);PSNR_values(4);PSNR_values(5);PSNR_values(6);PSNR_values(7);PSNR_values(8);PSNR_values(9);PSNR_values(10)];

T = table(sd, PSNR_t)

        
end


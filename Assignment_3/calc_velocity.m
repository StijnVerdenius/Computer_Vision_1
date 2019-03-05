function [Vxs,Vys] = calc_velocity(regions1,regions2)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[h,w] = size(regions1);
Vxs = ones(h,w);
Vys = ones(h,w);
for regions_row = 1:h
    for regions_height = 1:w
        region1 = double(regions1{regions_row,regions_height});
        region2 = double(regions2{regions_row,regions_height});
        [px_h,px_w] = size(region1);
        [Ix_reg, Iy_reg] = gradient(region1);
        It_reg = region2 - region1;
        A = ones(14,2);
        B = ones(14,1);
        for px_row = 1:px_h-1
            for px_col = 1:px_w-1
                A(px_row*px_col,1) = Ix_reg(px_row, px_col);
                A(px_row*px_col,2) = Iy_reg(px_row, px_col);
                B(px_row*px_col,1) = -It_reg(px_row,px_col);
            end
        end
        V = mldivide(transpose(A)*A,transpose(A)*B);
        Vxs(regions_row, regions_height) = V(1);
        Vys(regions_row, regions_height) = V(2);
    end 
end

end


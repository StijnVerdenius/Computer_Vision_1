function [cells] = divide_in_regions(img,reg_size)
%UNTITLED3 Summary of this function goes here
% To access first region of first channel use regions{1,1}{1,1}
% To access third col, first row region of second channel use regions{1,2}{1,3}
[h,w] = size(img);
num_regs_x = idivide(int32(h), int32(reg_size), 'floor');
num_regs_y = idivide(int32(w), int32(reg_size), 'floor');
div_x = [reg_size.*ones(1,num_regs_x), h-num_regs_x*reg_size];
div_y = [reg_size.*ones(1,num_regs_y), h-num_regs_y*reg_size];
cells = mat2cell(img,div_x, div_y);
end


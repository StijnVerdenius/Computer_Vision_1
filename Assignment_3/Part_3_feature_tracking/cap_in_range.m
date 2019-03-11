function number = cap_in_range(number, max)

if (number > max)
    number = max;
else if (number < 1)
    number = 1;
end

end

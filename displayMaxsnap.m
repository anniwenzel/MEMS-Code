function displayMaxsnap(maxsnap,number)
if number == 1
    figure(151); 
end
if number == 2
    figure(152); 
end
if number == 3
    figure(153);
end 
surf(maxsnap);
view(2);
shading interp;
end
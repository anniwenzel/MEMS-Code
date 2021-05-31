function displayMaxsnap(maxsnap,number)
if number == 1
    figure(101); 
end
if number == 2
    figure(102); 
end
if number == 3
    figure(153);
end 
surf(maxsnap);
view(2);
shading interp;
end
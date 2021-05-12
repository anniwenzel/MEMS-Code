function linegrid = CreatePolygonMatrix(xv,yv,density,minsep)
    randompts = gridmatrix([-1 1],[-1 1],density,minsep,1);
    inside = inpolygon(randompts(:,1),randompts(:,2),xv,yv);
    linegrid = randompts(inside,:); % points inside polygon for search
    clear randompts inside;
end
   

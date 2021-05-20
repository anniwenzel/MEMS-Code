function linegrid = CreatePolygonMatrix(xv,yv,density,minsep)
    randompts = gridmatrixNEW([-1 1],[-1 1],density,minsep,0);
    inside = inpolygon(randompts(:,1),randompts(:,2),xv,yv);
    linegrid = randompts(inside,:); % points inside polygon for search
    clear randompts inside;
end
   

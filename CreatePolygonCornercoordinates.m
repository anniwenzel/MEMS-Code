function [xv,yv]=CreatePolygonCornercoordinates(xs,ys,epsilon)
    mincrd=find(ys==min(ys));
    maxcrd=find(ys==max(ys));
 
    xv = [xs(mincrd),xs(mincrd),xs(maxcrd),xs(maxcrd),xs(mincrd)];
    yv = [ys(mincrd)-epsilon,ys(mincrd)+epsilon,ys(maxcrd)+epsilon,ys(maxcrd)-epsilon,ys(mincrd)-epsilon];
end
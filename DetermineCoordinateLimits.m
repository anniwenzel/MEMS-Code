function [xpts,ypts] = DetermineCoordinateLimits(DEBUG)
    if ~DEBUG
        xs=input('Enter x-coordinate limits for search area (separated by comma, two values, between -1 and 1): ','s');
        ys=input('Enter y-coordinate limits for search area (separated by comma, two values, between -1 and 1): ','s');
    else
        xs ='0.17,0.18';
        ys ='0.02,0.03';      
    end
     
    xpts = sscanf(xs, '%f , %f');
    ypts = sscanf(ys, '%f , %f');
end
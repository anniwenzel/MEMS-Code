% generates a list of search points based on the max and min limits of
% the MEMS and the desired number of points 

function output = gridmatrixNEW(xpts,ypts,n_points,minsep,rflag)


if max(max(abs(xpts)),max(abs(ypts)))>1
    disp('Error: coordinates must be within [-1,1]')
    output=0;
else
    xmax=max(xpts);
    xmin=min(xpts);
    ymax=max(ypts);
    ymin=min(ypts);
    if   abs(xmax-xmin)/(n_points-1) > minsep                
        unit_x = linspace(xmin,xmax,n_points);
    else
        unit_x = xmin:minsep:xmax;
    end
    
    if abs(ymax-ymin)/(n_points-1) > minsep                  
        unit_y = linspace(ymin,ymax,n_points);
    else
        unit_y = ymin:minsep:ymax;
    end
    
    [p,q] = meshgrid(unit_x, unit_y);
    temp = [p(:) q(:)];
    if rflag==1
        output = temp(randperm(size(temp,1)),:); %randomizes rows for search    
    else
        output = temp;
    end
    disp(string(n_points)+'x'+string(n_points)+'matrix created')
   
 
end

    

% generates a list of search points based on the max and min limits of
% the MEMS and the desired number of points 

function output = gridneigh(thiscoords,n_points,minsep,saferangex,saferangey,howfar,rflag)

thisx=thiscoords(1);          
thisy=thiscoords(2);

if max(abs(thiscoords))>1
    error('Error: coordinates must be within [-1,1]');
    output=0;
else   
    xtop=thisx+saferangex;
    xbottom=thisx-saferangex;
    ytop=thisy+saferangey;
    ybottom=thisy-saferangey;
    
    xmax=xtop+howfar;
    if xmax>1 
        xmax=1; 
    end
   
    
    xmin=xbottom-howfar;
    if xmin<-1
        xmin=-1;
    end
  
    
    ymax=ytop+howfar;
    if ymax>1
        ymax=1; 
    end

    
    ymin=ybottom-howfar;
    if ymin<-1 
        ymin=-1; 
    end

    largearea=gridmatrixNEW([xmin xmax],[ymin ymax],n_points,minsep,0);
    for i=1:size(largearea,1)
        test(i)=(largearea(i,1) > xbottom & largearea(i,1)<xtop) & (largearea(i,2) > ybottom & largearea(i,2)<ytop);
    end
    
   temp=largearea(~test,:);
        
    if rflag==1
        output = temp(randperm(size(temp,1)),:); %randomizes rows for search
    else
        output = temp;
    end
  
end

    
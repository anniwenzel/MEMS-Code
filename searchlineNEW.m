% moves to points in the search list, captures image, identifies if above
% threshold, extracts coordinates if light found
% FUNCTION FOR SEARCHING ALONG RECTANGLE POINTS


function coordlist = searchlineNEW(searchpts,count,light_thresh,gain,exposure,vid,nearng,minsep,mMTIDevice)%,mMTIDevice

Saferange= 5e-03;
i=1;
    
while i<size(searchpts,1)
    
    [xpos,ypos,maxCoord] = DetermineCoordinates(searchpts,i);
     if xpos>1
        break;
     end
    
    tempsnap=PhotographCertainPoint(gain,exposure,vid,xpos,ypos,maxCoord,mMTIDevice); %,mMTIDevice
    

    light_int = max(max(tempsnap));
    if light_int>light_thresh
        disp('Line light found!')
        
       
        coordlist(count,:) = searchpts(i,:);
        
        max_MEMS = coordlist(count,:);
        max_light=light_int;
        maxsnap=tempsnap;
   
        nearpts=gridmatrixNEW([max_MEMS(1)-nearng max_MEMS(1)+nearng],[max_MEMS(2)-nearng max_MEMS(2)+nearng],7,minsep,0);
        [max_MEMS,max_image,max_light,maxsnap,maxfound] = maxlightNEW(nearpts,max_light,gain,exposure,vid,max_MEMS,maxsnap,mMTIDevice);
        
        coordlist(count,:)= max_MEMS;
        pause(0.02);
        count=count-1;
        
        xtop=max_MEMS(1)+Saferange;
        xbottom=max_MEMS(1)-Saferange;
        ytop=max_MEMS(2)+Saferange;
        ybottom=max_MEMS(2)-Saferange; 
        
        
        for a=1:size(searchpts,1)
            Test(a)=(searchpts(a,1)>xbottom & searchpts(a,1)< xtop) & (searchpts(a,2)>ybottom & searchpts(a,2)<ytop); 
          
        end
       
            
        Test = Test.';
        i=i
        size(searchpts)
        size(Test)
        searchpts=searchpts(~Test,:);
        clear('Test'); 
        
        if count==0
            break;
        end
        
    end
 i = i+1;
    
end
    
end


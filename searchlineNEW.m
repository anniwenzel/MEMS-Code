% moves to points in the search list, captures image, identifies if above
% threshold, extracts coordinates if light found
% FUNCTION FOR SEARCHING ALONG RECTANGLE POINTS


function coordlist = searchlineNEW(searchpts,count,max_light,gain,exposure,vid,minsep,nearng,mMTIDevice)%,mMTIDevice

Saferange= 2.5e-02;
i=1;
FirstMatrixSize = size(searchpts,1)    
while i<FirstMatrixSize
    
    light_thresh = max_light-30;
    [xpos,ypos,maxCoord] = DetermineCoordinates(searchpts,i);
     if xpos>1
        break;
     end
    
   tempsnap=PhotographCertainPoint(gain,exposure,vid,xpos,ypos,maxCoord,mMTIDevice); %,mMTIDevice
    

    light_int = max(max(tempsnap));
    
    if light_int>light_thresh
        disp('Line light found!')
        
       
        max_MEMS = searchpts(i,:);
        
        
        max_light=light_int;
        maxsnap=tempsnap;
   
        if count==16
        nearpts=gridmatrixNEW([max_MEMS(1)-nearng max_MEMS(1)+nearng],[max_MEMS(2)-nearng max_MEMS(2)+nearng],4,minsep,0);
        [max_MEMS,max_image,max_light,maxsnap,maxfound] = maxlightNEW(nearpts,max_light,gain,exposure,vid,max_MEMS,maxsnap,mMTIDevice);
        end
        
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
        searchpts = searchpts(~Test,:);
        i=i
        size(searchpts)       
        clear('Test'); 
        
        if count==0
            break;
        end
        
    end
 i = i+1;
    
end
    
end


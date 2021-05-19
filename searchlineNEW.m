% moves to points in the search list, captures image, identifies if above
% threshold, extracts coordinates if light found
% FUNCTION FOR SEARCHING ALONG RECTANGLE POINTS


function coordlist = searchlineNEW(searchpts,count,light_thresh,gain,exposure,vid)%,mMTIDevice

Saferange= 5e-02;
i=1;
    
while i<size(searchpts,1)
    
    [xpos,ypos,maxCoord] = DetermineCoordinates(searchpts,i);
     if xpos>1
        break;
     end
    
    tempsnap=PhotographCertainPoint(gain,exposure,vid,xpos,ypos,maxCoord); %,mMTIDevice
    

    light_int = max(max(tempsnap));
    if light_int>light_thresh
        disp('Line light found!')
        coordlist(count,:) = searchpts(i,:);
        coords = coordlist(count,:)
        pause(0.02);
        count=count-1;
        
        xtop=coords(1)+Saferange;
        xbottom=coords(1)-Saferange;
        ytop=coords(2)+Saferange;
        ybottom=coords(2)-Saferange; 
        
        
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


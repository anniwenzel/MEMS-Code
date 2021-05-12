% moves to points in the search list, captures image, identifies if above
% threshold, extracts coordinates if light found
% FUNCTION FOR SEARCHING ALONG RECTANGLE POINTS


function coordlist = searchlineNEW(searchpts,count,light_thresh,gain,exposure,vid)%,mMTIDevice
    
for i=1:size(searchpts,1)
   
    [xpos,ypos,maxCoord] = DetermineCoordinates(searchpts,i);
     if xpos>1
        break;
     end
    
    tempsnap=PhotographCertainPoint(gain,exposure,vid,xpos,ypos,maxCoord); %,mMTIDevice
    

    light_int = max(max(tempsnap(1:355,45:370)));
    if light_int>light_thresh
        disp('Line light found!')
        coordlist(count,:) = searchpts(i,:);
        count=count-1;
         if count==0
            break;
         end
    end
end
% moves to points in the search list, captures image, identifies if above
% threshold, extracts coordinates if light found

function [found,light_MEMS,light_image,light_int,light_snap] = searchlightNEW(searchpts,light_thresh,gain,exposure,vid) %,mMTIDevice

for i=1:size(searchpts,1)
    
    [xpos,ypos,maxCoord] = DetermineCoordinates(searchpts,i);
     
     if xpos>1
        break;
     end
    
    tempsnap=PhotographCertainPoint(gain,exposure,vid,xpos,ypos,maxCoord);  %,mMTIDevice

    light_int = max(max(tempsnap(1:355,45:370)));
    if light_int>light_thresh
       [found,light_MEMS,light_image,light_snap] = SetLightParameters(searchpts,light_int,tempsnap,i);
        break;
    end
        
end


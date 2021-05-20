% moves to points in the search list, captures image, identifies if above
% threshold, extracts coordinates if light found

function [found,light_MEMS,light_image,light_int,light_snap] = searchlightNEW(searchpts,light_thresh,gain,exposure,vid,mMTIDevice) %,mMTIDevice

found = 0;
light_MEMS = zeros(2,1);
light_image = zeros(2,1);
light_int = 0;
light_snap = zeros(2,2);
for i=1:size(searchpts,1)
    
    [xpos,ypos,maxCoord] = DetermineCoordinates(searchpts,i);
     
     if xpos>1
        break;
     end
    
    tempsnap=PhotographCertainPoint(gain,exposure,vid,xpos,ypos,maxCoord,mMTIDevice);  %,mMTIDevice
    
    light_int = max(max(tempsnap));
    if light_int>light_thresh
       [found,light_MEMS,light_image,light_snap] = SetLightParameters(searchpts,light_int,tempsnap,i);
        break;
    end
        
end


function [max_MEMS,max_image,max_light,maxsnap,found] = maxlightNEW(searchpts,max_light,gain,exposure,vid,max_MEMS,maxsnap,mMTIDevice) %,mMTIDevice

found = 0;
max_image = zeros(1,2);

disp('searching stronger light')

 for i=1:size(searchpts,1)
    
    [xpos,ypos,maxCoord] = DetermineCoordinates(searchpts,i);
     if xpos>1
        break;
     end
    tempsnap = PhotographCertainPoint(gain,exposure,vid,xpos,ypos,maxCoord,mMTIDevice); %,mMTIDevice
    
    light_int = max(max(tempsnap));
    
    if light_int>max_light
       [found,max_MEMS,max_image,maxsnap,max_light] = SetMaxlightParameters(searchpts,light_int,tempsnap,i);
    end
 end
end
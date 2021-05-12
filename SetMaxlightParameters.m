function [found,max_MEMS,max_image,max_snap,max_light] = SetMaxlightParameters(searchpts,light_int,tempsnap,i)
 disp('Stronger light found!')
        found=1;
        [lightx,lighty]=find(tempsnap==light_int,1);                                         
        max_image = [lightx lighty];
        max_MEMS = searchpts(i,:);
        max_light = light_int;
        max_snap = tempsnap;
end
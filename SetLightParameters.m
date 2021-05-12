function [found,light_MEMS,light_image,light_snap] = SetLightParameters(searchpts,light_int,tempsnap,i)
        found = 1;
        [lightx,lighty]=find(tempsnap==light_int);
        light_image = [lightx lighty];
        light_MEMS = searchpts(i,:);
        light_snap=tempsnap;
end
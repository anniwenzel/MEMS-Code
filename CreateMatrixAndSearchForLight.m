%Creates different matrices and searches with them for lights (from coarse
%matrix to dense)
% stops when a light is found

function [found,light_MEMS,light_image,light_int,snap] = CreateMatrixAndSearchForLight(xpts,ypts,minsep,light_thresh,gain,exposure,vid,mMTIDevice,NumberBrightPixels) %,mMTIDevice
 for n_search=[2 5 10 20] % size of search matrix (squared) - granularity of searches                    
        searchpts1 = gridmatrixNEW(xpts,ypts,n_search,minsep,1);     
        [found,light_MEMS,light_image,light_int,snap] = searchlightNEW(searchpts1,light_thresh,gain,exposure,vid,mMTIDevice,NumberBrightPixels); %,mMTIDevice
     if found == 1 %light found in the current granularity
         disp('Light found!')
         break;
     end
 end
end
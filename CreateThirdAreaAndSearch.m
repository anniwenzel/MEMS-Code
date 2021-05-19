function [thirdfound,third_MEMS,third_image,third_int,thirdsnap] = CreateThirdAreaAndSearch(center,thirdsearch,minsep,light_thresh,gain,exposure,vid)%,mMTIDevice
    for n_search=[5 10 20] % size of search matrix (squared) - granularity of searches
        searchpts3 = gridmatrixNEW([center(1)-thirdsearch center(1)+thirdsearch],[center(2)-thirdsearch center(2)+thirdsearch],n_search,minsep,1);
        [thirdfound,third_MEMS,third_image,third_int,thirdsnap] = searchlightNEW(searchpts3,light_thresh,gain,exposure,vid);%,mMTIDevice
        if thirdfound == 1 %light found in the current granularity
            disp('Third pixel found!')
            break;
        end
    end
end
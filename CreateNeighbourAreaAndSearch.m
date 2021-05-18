function [foundneigh,neigh_MEMS,neigh_image,neigh_int,neigh_snap] = CreateNeighbourAreaAndSearch(max_MEMS,minsep,saferange,howfar,light_thresh,gain,exposure,vid,mMTIDevice)

for n_search=[5 7 10 15 20] % size of search matrix (squared) - granularity of searches
    neighpts = gridneighNEW(max_MEMS,n_search,minsep,saferange,saferange,howfar,1);
    [foundneigh,neigh_MEMS,neigh_image,neigh_int,neigh_snap] = searchlightNEW(neighpts,light_thresh,gain,exposure,vid,mMTIDevice); 
    if foundneigh == 1 %light found in the current granularity
        disp('Neighbour found!');
        break;
    end   
end

end
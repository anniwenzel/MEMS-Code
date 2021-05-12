function center = CalculateCenterOfFoundPoints(firstpix,secondpix)
   center(1) = .5*(firstpix(1)+secondpix(1));
   center(2) = .5*(firstpix(2)+secondpix(2));
end
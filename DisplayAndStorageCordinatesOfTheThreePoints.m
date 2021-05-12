function foundpts = DisplayAndStorageCordinatesOfTheThreePoints(firstpix,secondpix,thirdpix)
        disp('Optimized first pixel MEMS coordinates: '); disp(firstpix);
        disp('Optimized second pixel MEMS coordinates: '); disp(secondpix);
        disp('Optimized third pixel MEMS coordinates: '); disp(thirdpix);
        foundpts = [firstpix(1) secondpix(1) thirdpix(1); firstpix(2) secondpix(2) thirdpix(2)];
end
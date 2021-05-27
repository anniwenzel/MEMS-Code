function MaxPixels=SumOfBrightestPixel(tempsnap)
Array = reshape(tempsnap,[size(tempsnap) 1]);
SortArray = sort(Array);
MaxPixels = sum(SortArray((2048*1536-10):(2048*1536)),'all');
end


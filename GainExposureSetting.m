function [gain, exposure] = GainExposureSetting(vid)
vid.ReturnedColorSpace = 'grayscale';
src = getselectedsource(vid);
vid.FramesPerTrigger = 1;

src.Gamma = 100;
src.Gain = 20;
src.Exposure = -14;
src.FrameRate = '50.0000'
Light_Thresh = 200;

preview(vid);
 
max_val = getMaxValue(vid)



while max_val < Light_Thresh && src.Exposure <= -9
    src = getselectedsource(vid);
    src.Exposure = src.Exposure + 1;
    max_val= getMaxValue(vid);

end

while max_val < Light_Thresh && src.Gain <= 460
    src = getselectedsource(vid);
    src.Gain = src.Gain + 20; 
    max_val= getMaxValue(vid);

end

 

while max_val < Light_Thresh && src.Exposure <= 0
    src = getselectedsource(vid);
    src.Exposure = src.Exposure +1 ;
    max_val= getMaxValue(vid);
end

closepreview(vid);
gain = src.Gain;
exposure = src.Exposure;
 
end
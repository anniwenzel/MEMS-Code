function [gain, exposure] = GainExposureSetting(vid, GainExp_thresh)
vid.ReturnedColorSpace = 'grayscale';
src = getselectedsource(vid);
vid.FramesPerTrigger = 1;

src.Gamma = 100;
src.Gain = 20;
src.Exposure = -14;
src.FrameRate = '50.0000'


start(vid);
preview(vid);
trigger(vid);
input_img = getdata(vid);
stop(vid)
%average = sum(input_img(:))/(2048*1536);
max_val=max(input_img(:));



while max_val < GainExp_thresh && src.Exposure <= -9
    src = getselectedsource(vid);
    src.Exposure = src.Exposure + 1;
    %preview(vid);
    max_val=CalculateMaxValue(vid);

end

while max_val < GainExp_thresh && src.Gain <= 460
    src = getselectedsource(vid);
    src.Gain = src.Gain + 20;
    
    max_val=CalculateMaxValue(vid);
end

 

while max_val < GainExp_thresh && src.Exposure <= 0
    src = getselectedsource(vid);
    src.Exposure = src.Exposure +1 ;
    
    max_val=CalculateMaxValue(vid);

end

closepreview(vid);
gain = src.Gain;
exposure = src.Exposure;



   
end
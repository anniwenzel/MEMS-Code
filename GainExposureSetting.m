function [gain, exposure] = GainExposureSetting(vid)
vid.ReturnedColorSpace = 'grayscale';
src = getselectedsource(vid);
vid.FramesPerTrigger = 1;

src.Gamma = 100;
src.Gain = 20;
src.Exposure = -14;
src.FrameRate = '50.0000'


start(vid);
preview(vid);
 
input_img = getdata(vid);
%average = sum(input_img(:))/(2048*1536);
max_val=max(input_img(:));

stop(vid);

while max_val < 200 && src.Exposure <= -9
    src = getselectedsource(vid);
    src.Exposure = src.Exposure + 1;
    %preview(vid);
    start(vid);
    input_img = getdata(vid);
    stop(vid);
    %average = sum(input_img(:))/(2048*1536);
    max_val=max(input_img(:));

end

while max_val < 200 && src.Gain <= 460
    src = getselectedsource(vid);
    src.Gain = src.Gain + 20;
    
    start(vid);
    input_img = getdata(vid);
    stop(vid);
    %average = sum(input_img(:))/(2048*1536);
     max_val=max(input_img(:));

end

 

while max_val < 200 && src.Exposure <= 0
    src = getselectedsource(vid);
    src.Exposure = src.Exposure +1 ;
    
    start(vid);
    input_img = getdata(vid);
    stop(vid);
    %average = sum(input_img(:))/(2048*1536);
    max_val=max(input_img(:));

end

closepreview(vid);
gain = src.Gain;
exposure = src.Exposure;



   
end
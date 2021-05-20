function output_img = takeImg(gain,exposure,vid)

src.Gain = gain;
src.Exposure = exposure;

start(vid);

output_img = getdata(vid); 

stop(vid);


end


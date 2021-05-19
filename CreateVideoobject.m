function vid = CreateVideoobject()
vid = videoinput('winvideo',2)
vid.ReturnedColorSpace = 'grayscale';
src = getselectedsource(vid);
vid.FramesPerTrigger = 1;

src.Gamma = 100;
src.Gain = 20;
src.Exposure = -14;
src.FrameRate = '50.0000'
end
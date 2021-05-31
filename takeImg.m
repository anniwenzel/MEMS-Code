function output_img = takeImg(gain,exposure,vid)

% src.Gain = gain;
% src.Exposure = exposure;

%start(vid);
%triggerTime=tic;
trigger(vid);
%trigger_time=toc(triggerTime)
%Vidisrunning=isrunning(vid)
%getdataTime=tic;
output_img = getdata(vid); 
%getdata_time=toc(getdataTime)


%stop(vid);



end


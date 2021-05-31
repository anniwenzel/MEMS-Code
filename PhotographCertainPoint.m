
function tempsnap=PhotographCertainPoint(gain,exposure,vid,xpos,ypos,coords,mMTIDevice) %,mMTIDevice
    if coords<=1
%        MoveMirrorTime=tic; 
       mMTIDevice.GoToDevicePosition(xpos,ypos,255,2); %go to new position in 2ms
%        MoveMirror_time=toc(MoveMirrorTime)
    end
    %trigger(vid)
    pause(0.1);
    try
%         TakePicureTime=tic;
        tempsnap = takeImg(gain,exposure,vid);
%         TakePicture_time=toc(TakePicureTime)
    catch
        pause(0.75);
        disp('Camera failed! trying again')
        tempsnap = takeImg(gain,exposure,vid);
    end
    pause(0.2);
end
function tempsnap=PhotographCertainPoint(gain,exposure,vid,xpos,ypos,coords) %,mMTIDevice
    %if coords<=1
       % mirror.GoToDevicePosition(xpos,ypos,255,2); %go to new position in 2ms
    %end
    
    pause(0.02);
    try
        tempsnap = takeImg(gain,exposure,vid);
    catch
        pause(0.75);
        disp('Camera failed! trying again')
        tempsnap = takeImg(gain,exposure,vid);
    end
    pause(0.2);
end
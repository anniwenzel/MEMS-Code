% Taking, Showing and saving images at every lightpoint

function PicturesOfEveryLightpoint(linelist,gain,exposure,vid)%Device
 
    for i=1:size(linelist,1)
     x_light = linelist(i,1);
     y_light = linelist(i,2);
     %mirror.GoToDevicePosition(xpos,ypos,255,2);
     pause(0.02);
     imageI = takeImg(gain,exposure,vid);
    
     figure(i)
     imwrite(imageI,strcat('lightcoordinates/image_',num2str(i),'.jpg'))
     imshow(imageI);
    end
end
     
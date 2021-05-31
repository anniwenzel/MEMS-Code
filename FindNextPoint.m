function [xpos,ypos,Turn,max_light]= FindNextPoint(xpos,ypos,x_delta,y_delta,foundpts,max_light,light_thresh,Turn,gain,exposure,vid,mMTIDevice,NumberBrightPixels,BigMaxStep,SmallMaxStep)
if Turn==1
   x_pos=xpos+x_delta;
   y_pos=ypos+y_delta; 
   [xpos,ypos,max_light,tempsnap]=MaximizePoint(x_pos,y_pos,gain,exposure,vid,mMTIDevice,NumberBrightPixels,BigMaxStep,SmallMaxStep);

    
end

if max_light>light_thresh && Turn==0
   x_pos=xpos-x_delta;
   y_pos=ypos-y_delta;
 
   [xpos,ypos,max_light,tempsnap]=MaximizePoint(x_pos,y_pos,gain,exposure,vid,mMTIDevice,NumberBrightPixels,BigMaxStep,SmallMaxStep);
   if max_light<=light_thresh 
      x_pos=foundpts(1,1);
      y_pos=foundpts(2,1);
      Turn=1;
      [xpos,ypos,max_light,tempsnap]=MaximizePoint(x_pos,y_pos,gain,exposure,vid,mMTIDevice,NumberBrightPixels,BigMaxStep,SmallMaxStep);
   end
end
figure();
imshow(tempsnap)

end

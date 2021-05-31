function [xpos,ypos,max_light,tempsnap]=MaximizePoint(x_pos,y_pos,gain,exposure,vid,mMTIDevice,NumberBrightPixels,BigMaxStep,SmallMaxStep)
    
       % y_found=0;
       ypos=y_pos;
       xpos=x_pos;

   for loop=1:2
          if loop==1
             Stepfactor=BigMaxStep;
          else
              Stepfactor=SmallMaxStep;
          end
       for i=1:7

               x_factor=[-3:3];
               Xpos(i)=xpos+Stepfactor*x_factor(i);
               xPOS_i=Xpos(i);
                coords=max(abs(xpos),abs(ypos));
                tempsnap=PhotographCertainPoint(gain,exposure,vid,xPOS_i,ypos,coords,mMTIDevice);
                sorted_snap=sort(tempsnap(:));
                MaxMeanValueX(i)=mean(sorted_snap(end-NumberBrightPixels:end));

       end
       MaxX=find(MaxMeanValueX==max(MaxMeanValueX));
       MaxX=MaxX(1);
       xpos=Xpos(MaxX);  


       for a=1:7   
                y_factor=[-3:3];
                Ypos(a)=ypos+Stepfactor*y_factor(a);
                yPOS_a=Ypos(a);
                coords=max(abs(xpos),abs(ypos));
                tempsnap=PhotographCertainPoint(gain,exposure,vid,xpos,yPOS_a,coords,mMTIDevice);
                sorted_snap=sort(tempsnap(:));
                MaxMeanValueY(a)=mean(sorted_snap(end-100:end));

       end
                MaxY=find(MaxMeanValueY==max(MaxMeanValueY));
                MaxY=MaxY(1);
                ypos=Ypos(MaxY);

    end

    max_light=max(MaxMeanValueY)
end
      
    
    
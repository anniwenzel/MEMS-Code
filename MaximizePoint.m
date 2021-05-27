function [xpos,ypos,max_light,tempsnap]=MaximizePoint(x_pos,y_pos,gain,exposure,vid,mMTIDevice)
    
       % y_found=0;
       ypos=y_pos;
       xpos=x_pos;

      for loop=1:2
          if loop==1
             Stepfactor=0.003
          else
              Stepfactor=0.002
          end
       for i=1:7

               x_factor=[-3:3];
               Xpos(i)=xpos+Stepfactor*x_factor(i);
               xPOS_i=Xpos(i);
                coords=max(abs(xpos),abs(ypos));
                tempsnap=PhotographCertainPoint(gain,exposure,vid,xPOS_i,ypos,coords,mMTIDevice);
                MaxValueX(i)=max(max(tempsnap));

        end
       MaxX=find(MaxValueX==max(MaxValueX));
       MaxX=MaxX(1);
       xpos=Xpos(MaxX);  


        for a=1:7   
                y_factor=[-3:3];
                Ypos(a)=ypos+Stepfactor*y_factor(a);
                yPOS_a=Ypos(a);
                coords=max(abs(xpos),abs(ypos));
                tempsnap=PhotographCertainPoint(gain,exposure,vid,xpos,yPOS_a,coords,mMTIDevice);

                MaxValueY(a)=max(max(tempsnap));

        end
                MaxY=find(MaxValueY==max(MaxValueY));
                MaxY=MaxY(1);
                ypos=Ypos(MaxY);

      end

    figure();

    max_light=max(MaxValueY)
end
      
    
    
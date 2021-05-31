function Maximizing
Point(1,1)=xpos;
Point(1,2)=ypos;
tempsnap = PhotographCertainPoint(gain,exposure,vid,xpos,ypos,maxCoord,mMTIDevice);
sorted_snap=sort(tempsnap(:));
light_int(1)=mean(sorted_snap(end-100:end));

xpos=xpos+0.005;
Point(2,1)=xpos;
Point(2,2)=ypos;
tempsnap = PhotographCertainPoint(gain,exposure,vid,xpos,ypos,maxCoord,mMTIDevice);
sorted_snap=sort(tempsnap(:));
light_int(2)=mean(sorted_snap(end-100:end));

ypos=ypos+0.005;
Point(3,1)=xpos;
Point(3,2)=ypos;
tempsnap = PhotographCertainPoint(gain,exposure,vid,xpos,ypos,maxCoord,mMTIDevice);
sorted_snap=sort(tempsnap(:));
light_int(3)=mean(sorted_snap(end-100:end));

Max=find(light_int==max(light_int);
Max=Max(1);
Max_point=Point(Max,:);

Min=find(light_int==min(light_int);
Min=Min(1);
Min_point=Point(Min,:);


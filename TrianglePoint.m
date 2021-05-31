function [Point,light_int]=TrianglePoint(Point,light_int,xpos,ypos,i,gain,exposure,vid,mMTIDevice)
Point(2,1)=xpos;
Point(2,2)=ypos;
%macCoord
tempsnap = PhotographCertainPoint(gain,exposure,vid,xpos,ypos,maxCoord,mMTIDevice);
sorted_snap=sort(tempsnap(:));
light_int(2)=mean(sorted_snap(end-100:end));
end
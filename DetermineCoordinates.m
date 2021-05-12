function [xpos,ypos,maxCoord] = DetermineCoordinates(searchpts,i)
xpos = searchpts(i,1);   
ypos = searchpts(i,2);
maxCoord=max(abs(xpos),abs(ypos));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Created by Ken Castelino, Veljko Milanovic, Abhishek Kasturi
% Mirrorcle Technologies, Inc. 2011-2016
%
% Adapted by Ilan Felts Almog for finding pixels
%%%%%%%%%%%%%%%2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compatible with Firmware 3.2.10.2.x or newer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Finds the points of maximum intensity in images from coordinates of the
% MEMS                                                    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

path(path,'C:\MirrorcleTech\SDK-Matlab');
path(path,'C:\MirrorcleTech\SDK-Matlab\MTIDeviceMatlab');
%addpath 'C:\Users\awenzel\Downloads\autopix';

close all
clear; %clf reset; clc;

%% Initialize USB camera and parameters
% load('C:\Users\JPGroup\Documents\mems mirror\autopix\snapshots.mat')                                    
light_thresh = 140; % threshold for light to be detected in that coordinate
GainExp_thresh = 160; % threshhold for Gain and Exposure Setting
minsep=5e-4; %min acceptable MEMS coordinate, for creating matrices                             
% maximizing search param
nearng=20*minsep; %range near foundpixel used to maximize output                                  
% neighbor search params
howfar=5e-2; %range to search for a neighbour after safe range (multiples of minsep) %5e-02
saferange =5e-2; %distance away from first pixel where neighbour will not be searched  %5e-02
NumberBrightPixels=100; %number of the brightest pixels from which the sum is examined
% third pixel search params
%thirdsearch=5*nearng; %range from midpoint of first and second pixels to search for third       %thirdsearch+nearng      
BigMaxStep=0.0035; % First stepsize when maximize the line lights 
SmallMaxStep=0.002;  % Second stepsize when maximize the line lights
% line search params
%epsilon=0.001; % distance above and below line to search for other epixels   %0.003                     
%density=700; % density of grid for search above line %700
ncount=16; %number of light points along line to find and store before quitting                    
DebugLimitCoords = 0;
DebugGainExposure = 1;

%% Initialize MEMS
InitializeMEMS

%% create videoobject
vid = CreateVideoobject()


%% Gain and Exposure Setting
GainExposureTime=tic;

if ~DebugGainExposure
    src = getselectedsource(vid);
    src.Gain = input('Enter gain value:');
    src.Exposure = input('Enter exposure value:');
    gain = src.Gain;
    exposure = src.Exposure;

else
[gain, exposure] =  GainExposureSetting(vid,GainExp_thresh)
end
getselectedsource(vid);
src.Gain = gain;
src.Exposure = exposure;
GainExposure_time = toc(GainExposureTime)

%% Loops until finding light in the designated search area
tic
try

found=0;

while found==0
    [xpts,ypts] = DetermineCoordinateLimits(DebugLimitCoords);
    FirstLightTime=tic;
    start(vid);
    [found,light_MEMS,light_image,light_int,snap] = CreateMatrixAndSearchForLight(xpts,ypts,minsep,light_thresh,gain,exposure,vid,mMTIDevice,NumberBrightPixels); %,mMTIDevice
    FirstLight_time=toc(FirstLightTime)
    if found==0
     disp('No light found. Please enter new search region.')
     DebugLimitCoords = 0
    end
    
end
    

% maximize power output by sweeping nearby points in the MEMS
MaximizeFirstLightTime=tic;
if found==1
    max_MEMS=light_MEMS;
    max_light=light_int
    maxsnap=snap;
    %trigger(vid);
    nearpts1=gridmatrixNEW([max_MEMS(1)-nearng max_MEMS(1)+nearng],[max_MEMS(2)-nearng max_MEMS(2)+nearng],7,minsep,0); 
    [max_MEMS,max_image,max_light,maxsnap,maxfound] = maxlightNEW(nearpts1,max_light,gain,exposure,vid,max_MEMS,maxsnap,mMTIDevice,NumberBrightPixels);%,mMTIDevice
end
MaxFirstLight_time=toc(MaximizeFirstLightTime)
max_light=max_light
firstpix=max_MEMS;

% display max snap:
displayMaxsnap(maxsnap,1)


%after epixel has been maximized, search for a neighbouring epixel
NeighbourLightTime = tic;
% trigger(vid);
[foundneigh,neigh_MEMS,neigh_image,neigh_int,neigh_snap] = CreateNeighbourAreaAndSearch(max_MEMS,minsep,saferange,howfar,light_thresh,gain,exposure,vid,mMTIDevice,NumberBrightPixels);%,mMTIDevice
NeighbourLight_time=toc(NeighbourLightTime)

% maximize neighbour output
MaxNeighbourLightTime=tic;

if foundneigh==1
    maxneigh_MEMS=neigh_MEMS;
    maxneigh_light=neigh_int;
    maxneighsnap=neigh_snap;
%     while maxneighfound>0
       nearpts2=gridmatrixNEW([maxneigh_MEMS(1)-nearng maxneigh_MEMS(1)+nearng],[maxneigh_MEMS(2)-nearng maxneigh_MEMS(2)+nearng],7,minsep,0);
       [maxneigh_MEMS,maxneigh_image,maxneigh_light,maxneighsnap,maxneighfound] = maxlightNEW(nearpts2,maxneigh_light,gain,exposure,vid,maxneigh_MEMS,maxneighsnap,mMTIDevice,NumberBrightPixels);%,mMTIDevice
%     end
MaxNeighbourLight_time=toc(MaxNeighbourLightTime)

secondpix=maxneigh_MEMS;

% display maxneighsnap:
    displayMaxsnap(maxneighsnap,2)
    foundpts=[firstpix(1) secondpix(1);firstpix(2) secondpix(2)]  
end


  
x_delta =abs(foundpts(1,1)-foundpts(1,2));
y_delta=abs(foundpts(2,1)-foundpts(2,2));
xpos=foundpts(1,1);
ypos=foundpts(2,1);
Turn=0
for i=1:ncount
    LinelightTime=tic;
    [xpos,ypos,Turn]= FindNextPoint(xpos,ypos,x_delta,y_delta,foundpts,max_light,light_thresh,Turn,gain,exposure,vid,mMTIDevice,NumberBrightPixels,BigMaxStep,SmallMaxStep);
    disp('Line light found'); 
    
    linelist(i,:)= [xpos ypos]
    Linelight_time=toc(LinelightTime)
    
end

mkdir lightcoordinates;
save('lightcoordinates/linelist.mat','linelist');
    PicturesOfEveryLightpoint(linelist,gain,exposure,vid,mMTIDevice) %,mMTIDevice

   

%% Clean up
toc
stop(vid)
delete(vid);
clear('vid');
CloseMEMS;
display('Closed successfully..');


catch ex
    display('Application failed to run properly!');
    toc
    pause(1)
    stop(vid)
    CloseMEMS;
    delete(vid);
    clear('vid');
    display('Closed in final catch..');
    rethrow(ex)
end
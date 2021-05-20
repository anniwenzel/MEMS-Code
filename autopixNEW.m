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
light_thresh = 150; % threshold for light to be detected in that coordinate
minsep=5e-4; %min acceptable MEMS coordinate, for creating matrices                             
% maximizing search param
nearng=20*minsep; %range near foundpixel used to maximize output                                  
% neighbor search params
howfar=10e-2; %range to search for a neighbour after safe range (multiples of minsep) %5e-02
saferange =10e-2; %distance away from first pixel where neighbour will not be searched  %5e-02

% third pixel search params
thirdsearch=5*nearng; %range from midpoint of first and second pixels to search for third       %thirdsearch+nearng      

% line search params
epsilon=0.003; % distance above and below line to search for other epixels   %0.003                     
density=700; % density of grid for search above line %700
ncount=15; %number of light points along line to find and store before quitting                    
DebugLimitCoords = 0;
DebugGainExposure = 1;

%% Initialize MEMS
InitializeMEMS

%% create videoobject
vid = CreateVideoobject()


%% Gain and Exposure Setting
if ~DebugGainExposure
    src = getselectedsource(vid);
    src.Gain = input('Enter gain value:');
    src.Exposure = input('Enter exposure value:');
    gain = src.Gain;
    exposure = src.Exposure;

else
[gain, exposure] = GainExposureSetting(vid)
end

%% Loops until finding light in the designated search area
tic
try

found=0;
thirdfound=0;


while found==0
    [xpts,ypts] = DetermineCoordinateLimits(DebugLimitCoords);
    [found,light_MEMS,light_image,light_int,snap] = CreateMatrixAndSearchForLight(xpts,ypts,minsep,light_thresh,gain,exposure,vid,mMTIDevice); %,mMTIDevice
    
    if found==0
     disp('No light found. Please enter new search region.')
     DebugLimitCoords = 0
    end
    
end
    

% maximize power output by sweeping nearby points in the MEMS
if found==1
    max_MEMS=light_MEMS;
    max_light=light_int;
    maxsnap=snap;
    nearpts1=gridmatrixNEW([max_MEMS(1)-nearng max_MEMS(1)+nearng],[max_MEMS(2)-nearng max_MEMS(2)+nearng],7,minsep,0); 
    [max_MEMS,max_image,max_light,maxsnap,maxfound] = maxlightNEW(nearpts1,max_light,gain,exposure,vid,max_MEMS,maxsnap,mMTIDevice);%,mMTIDevice
end

  firstpix=max_MEMS;

  % display max snap:
  displayMaxsnap(maxsnap,1)



%after epixel has been maximized, search for a neighbouring epixel
[foundneigh,neigh_MEMS,neigh_image,neigh_int,neigh_snap] = CreateNeighbourAreaAndSearch(max_MEMS,minsep,saferange,howfar,light_thresh,gain,exposure,vid,mMTIDevice);%,mMTIDevice

% maximize neighbour output
if foundneigh==1
    maxneigh_MEMS=neigh_MEMS;
    maxneigh_light=neigh_int;
    maxneighsnap=neigh_snap;
%     while maxneighfound>0
       nearpts2=gridmatrixNEW([maxneigh_MEMS(1)-nearng maxneigh_MEMS(1)+nearng],[maxneigh_MEMS(2)-nearng maxneigh_MEMS(2)+nearng],7,minsep,0);
       [maxneigh_MEMS,maxneigh_image,maxneigh_light,maxneighsnap,maxneighfound] = maxlightNEW(nearpts2,maxneigh_light,gain,exposure,vid,maxneigh_MEMS,maxneighsnap,mMTIDevice);%,mMTIDevice
%     end

    secondpix=maxneigh_MEMS;

  % display maxneighsnap:
    displayMaxsnap(maxneighsnap,2)     
    
    
    % try to find a 3rd pixel with new window centered at midpoint of two
    % found points
     center = CalculateCenterOfFoundPoints(firstpix,secondpix);
    [thirdfound,third_MEMS,third_image,third_int,thirdsnap] = CreateThirdAreaAndSearch(center,thirdsearch,minsep,light_thresh,gain,exposure,vid,mMTIDevice);%,mMTIDevice
    
    if thirdfound == 0
        disp('Third pixel not found.')
    end 
    
    if thirdfound==1
        maxthird_MEMS=third_MEMS;
        maxthird_light=third_int;
        maxthirdsnap=thirdsnap;
   
        nearpts3=gridmatrixNEW([maxthird_MEMS(1)-nearng maxthird_MEMS(1)+nearng],[maxthird_MEMS(2)-nearng maxthird_MEMS(2)+nearng],7,minsep,0);
        [maxthird_MEMS,maxthird_image,maxthird_light,maxthirdsnap,maxthirdfound] = maxlightNEW(nearpts3,maxthird_light,gain,exposure,vid,maxthird_MEMS,maxthirdsnap,mMTIDevice);%,mMTIDevice
    
       % display maxthirdsnap:
         displayMaxsnap(maxthirdsnap,3)
         disp('HELLO SWEETIE')

        thirdpix=maxthird_MEMS;
        
        foundpts = DisplayAndStorageCordinatesOfTheThreePoints(firstpix,secondpix,thirdpix)         
    end
    
  
end


%% Search for all lights 
% define line from points found
% Create a small polygon around the line
% Search for lights inside polygon

if thirdfound==1
    [xs,ys] = DefineLineFromPointsFound(foundpts); 
    [xv,yv] = CreatePolygonCornercoordinates(xs,ys,epsilon); 
    linegrid = CreatePolygonMatrix(xv,yv,density,minsep);
    linelist = searchlineNEW(linegrid,ncount,light_thresh,gain,exposure,vid,nearng,minsep,mMTIDevice) %,mMTIDevice 
    
    mkdir lightcoordinates;
    save('lightcoordinates/linelist.mat','linelist');
    
    PicturesOfEveryLightpoint(linelist,gain,exposure,vid,mMTIDevice) %,mMTIDevice
end
   

%% Clean up
toc
delete(vid);
clear('vid');
CloseMEMS;
display('Closed successfully..');

catch ex
    display('Application failed to run properly!');
    toc
    pause(1)
    CloseMEMS;
    delete(vid);
    clear('vid');
    display('Closed in final catch..');
    rethrow(ex)
end
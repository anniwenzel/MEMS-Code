%% Initialize MEMS
% Create an object of the MTIDevice class to access its functions,
% variables, and the target device at serial port
path(path,'C:\MirrorcleTech\SDK-Matlab\MTIDeviceMatlab');
mMTIDevice = MTIDevice;
tic

try
    availableDevices = mMTIDevice.GetAvailableDevices();
    if (availableDevices.NumDevices < 1), error('No devices found'); end;
    mMTIDevice.ListAvailableDevices(availableDevices);
    % if the user knows the comport can proceed this way
    comport = 'COM4'; % serial com port where SiLabs UART device is connected
    % if the user does not know the port or has multiple devices attached
    %id = input('Please choose a Target Device ID: ');
    comport = cell2mat(availableDevices.CommPortName(1));   % choose the first Controller found
    mMTIDevice.ConnectDevice(comport);

    if (mMTIDevice.GetLastError() ~= MTIError.MTI_SUCCESS)
        mMTIDevice.DisconnectDevice();
        delete(mMTIDevice);
        %return;
        error('Error in the MEMS')
    end

    mMTIDevice.ResetDevicePosition();	% optional, send mirror to origin and zero offsets

    % apply new device parameters as desired by user at beginning of the session
    % it is recommended to load the manufacturer-provided ini file for a
    % specific device and set those parameters
    lParams = mMTIDevice.LoadDeviceParams('mtidevice.ini');
    mMTIDevice.SetDeviceParams(lParams);

    % any additional parameters can be set directly as follows:
    mMTIDevice.SetDeviceParam( MTIParam.DataScale, 1.0 );
    mMTIDevice.SetDeviceParam( MTIParam.SampleRate, 20000 );
    err = mMTIDevice.GetLastError();
    % turn MEMS driver on
    mMTIDevice.SetDeviceParam( MTIParam.MEMSDriverEnable, 1 )
catch
%     CloseMEMS;
end

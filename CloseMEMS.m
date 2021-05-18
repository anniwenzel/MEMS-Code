%% Close MEMS
mMTIDevice.ResetDevicePosition();
%After the device is back to origin - disable the amplifier
mMTIDevice.SetDeviceParam( MTIParam.MEMSDriverEnable, 0 );
mMTIDevice.ClearInputBuffer();
mMTIDevice.DisconnectDevice();
delete(mMTIDevice);
clear('mMTIDevice');
display('MEMS closed.');
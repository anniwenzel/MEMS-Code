function max_val= getMaxValue(vid)
    %preview(vid);
    start(vid);
    input_img = getdata(vid);
    stop(vid);
    %average = sum(input_img(:))/(2048*1536);
    max_val=max(input_img(:));
end
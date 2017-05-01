function [mean_array, thresh_array, variance_array, fraction_array, area_array] = dt_cmyk_mmt(directory)
%% Read in image
cd(directory);
im_files = dir('*.tiff');
for n = 1:size(im_files,1)
    filename = im_files(n).name;
    %open image with bioformats plugin
    im_cell = bfopen(filename);
    %convert from cell to 3D image stack
    im = bf2mat(im_cell);
    %convert image to double
    imdbl = double(im);
    %convert from CMYK to grayscale using mean in 3rd dimension
    im_mean = mean(imdbl,3);
    %% Normalize image
    %set min pixel to zero
    sub_mean = im_mean - min(im_mean(:));    
    %set max pixel to one
    norm_mean = sub_mean/max(sub_mean(:));
    %% Calc %pixel below threshold at multiple thresholds
    %thresh array
    thresh_array = 0:0.01:1;
    for i = 1:size(thresh_array,2)
        %get binary image BELOW threshold
        im_bin = norm_mean < thresh_array(i);
        fraction_array(n,i) = sum(im_bin(:))/length(im_bin(:)); 
        %calc variance of image ABOVE OR EQUAL to threshold
        variance_array(n,i) = var(norm_mean(norm_mean >= thresh_array(i)));
        %calc area in pixels of image ABOVE or EQUAL to threshold
        area_array(n,i) = length(norm_mean(norm_mean >= thresh_array(i)))/length(norm_mean(:));
    end
end
%calculate mean of fraction_array by row
mean_array = mean(fraction_array);
% %plot the mean_array vs thresh_array
% plot(thresh_array, mean_array);
% xlabel('Threshold of Intensity');
% ylabel('Fraction Pixels < Threshold');

%This script uses the dt_cmyk_mmt.m function to measure the intensity profile
%of simulated nucleolar images.  Images are scaled such that the min pixel of the
%maximum intensity projection is set 0 and the brightest pixel is set to 1.
%Method is inspired from Maddox et al, 2006, PNAS.

fast_loop.dir = 'C:\Users\lawrimor\Documents\MATLAB\git\GitHub\datatank_mmt\FastDyn_pt09pt01_singlenuc\Adjusted';
noloop.dir = 'C:\Users\lawrimor\Documents\MATLAB\git\GitHub\datatank_mmt\NoLoops_singlenuc\Adjusted';

%% Intact rDNA loci, G1 cells
[fast_loop.mean, fast_loop.thresh, fast_loop.var, fast_loop.fraction, fast_loop.area] = dt_cmyk_mmt(fast_loop.dir);
[noloop.mean, noloop.thresh, noloop.var, noloop.fraction, noloop.area] = dt_cmyk_mmt(noloop.dir);

%% Plot the mean area vs threshold values with error bars
figure;
errorbar(fast_loop.thresh,mean(fast_loop.area),std(fast_loop.area)/sqrt(size(fast_loop.area,1)),'-o')
hold on;
errorbar(noloop.thresh,mean(noloop.area),std(noloop.area)/sqrt(size(noloop.area,1)),'-o')
hold off;
xlabel('Threshold of Intensity');
ylabel('Mean Normalized Area');
legend('Fast Looping','No Looping');
title('Simulated Images');

%% Plot the mean variance of pixel above thresh vs threshold values with error bars
figure;
errorbar(fast_loop.thresh,mean(fast_loop.var,'omitnan'),std(fast_loop.var,'omitnan')/sqrt(size(fast_loop.var,1)),'-o')
hold on;
errorbar(noloop.thresh,mean(noloop.var,'omitnan'),std(noloop.var)/sqrt(size(noloop.var,1)),'-o')
hold off;
xlabel('Threshold of Intensity');
ylabel('Variance of pixels >= threshold');
legend('Fast Looping','No Looping');
title('Simulated Images');
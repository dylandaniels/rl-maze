function save_figure(name,h,direc)
% save_figure(figure_name,handel,directory)

directory = '~/Dropbox/CS289_finalProject/figures/';
if nargin > 2
    directory = [directory, direc, '/'];
end

if ~exist(directory,'dir')
    mkdir(directory)
end

saveFigurePdf(h,[directory,name])

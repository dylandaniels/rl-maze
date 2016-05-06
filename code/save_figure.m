function save_figure(name,h,direc)
% save_figure(figure_name,handel,directory)

host = getenv('USER');
if strcmp(host(1:4),'paul')
    directory = '~/Desktop/CS289A/rl-maze/figures/';
else
    directory = '~/cs289/rl-maze/figures/';
end

if nargin > 2
    directory = [directory, direc, '/'];
end

if ~exist(directory,'dir')
    mkdir(directory)
end

saveas(h,[directory,name,'.png'])
saveFigurePdf(h,[directory,name])

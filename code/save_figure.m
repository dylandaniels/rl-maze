function save_figure(name,h,direc)
% save_figure(figure_name,handel,directory)

host = char(getHostName(java.net.InetAddress.getLocalHost));
if strcmp(host(1:4),'Paul')
    directory = '~/Desktop/CS289A/rl-maze/figures/';
else
    directory = 'DYLANPATH/rl-maze/figures/';
end

if nargin > 2
    directory = [directory, direc, '/'];
end

if ~exist(directory,'dir')
    mkdir(directory)
end

saveFigurePdf(h,[directory,name])

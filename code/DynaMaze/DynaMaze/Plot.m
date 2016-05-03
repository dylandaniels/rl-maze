function sq = Plot( x,a,steps,maze,start,goal, ptitle )

[N M] = size(maze);

subplot(2,1,1);
% Agent
% sq = plot(x(1)+0.5,x(2)+0.5,'sk','MarkerFaceColor','k','MarkerSize',10);
set(gcf,'position',[0 0 1440 820])
title(ptitle);
% Create axes
set(gca,'YTick',0:M,'YGrid','on',...
    'XTick',0:N,...
    'XGrid','on',...
    'XTickLabel',[],...
    'YTickLabel',[],...            
    'PlotBoxAspectRatio',[N M 1],...
    'GridLineStyle','-',...
    'DataAspectRatio',[1 1 1]);


% Uncomment the following line to preserve the X-limits of the axes
 xlim(gca,[0 N]);
% Uncomment the following line to preserve the Y-limits of the axes
 ylim(gca,[0 M]);
box(gca,'on');
hold on

text(start(1)+0.3,start(2)+0.5,'S','FontName','Courier New');
text(goal(1)+0.3,goal(2)+0.5,'G','FontName','Courier New');

% [mx my] = find(maze);
% [mx my] = find(rot90(maze,3));
[my, mx] = find(flipud(maze));
plot(mx-0.5,my-0.5,'s','MarkerEdgeColor',[.5 .5 .5],'MarkerFaceColor',[.5 .5 .5],'MarkerSize',20);
drawnow
hold off

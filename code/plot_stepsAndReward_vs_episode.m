
LOAD = false;
SAVE = false;

if LOAD
    load simulation_data.mat
end

figure('position',[0 0 600 300])
% figure('position',[0 0 900 900])
% subplot(2,1,1)
Y = squeeze(mean(simulation_data.steps,2));
% E = squeeze(std(simulation_data.steps,0,2))./sqrt(size(simulation_data,2));
% E = sort(simulation_data.steps,2);
% Eu = squeeze(E(:,end-floor(.25*nSims),:)) - Y;
% El = Y - squeeze(E(:,floor(.25*nSims),:));
X = repmat([1:size(Y,1)]',[1 size(Y,2)]);
% errorbar(X,Y,El,Eu,'linewidth',2)
plot(Y,'linewidth',2)
legend({'Q-learning','pseudorewards','DYNA','pseudorewards + DYNA'})
title([num2str(nSims),' simulations'],'fontsize',16)
xlabel('episode','fontsize',16)
ylabel('steps (mean \pm SEM)','fontsize',16)
% subplot(2,1,2)
% Y = squeeze(mean(simulation_data.reward,2));
% % E = squeeze(std(simulation_data.reward,0,2))./sqrt(size(simulation_data,2));
% E = sort(simulation_data.reward,2);
% Eu = squeeze(E(:,end-floor(.25*nSims),:)) - Y;
% El = Y - squeeze(E(:,floor(.25*nSims),:));
% X = repmat([1:size(Y,1)]',[1 size(Y,2)]);
% errorbar(X,Y,El,Eu,'linewidth',2)
% legend({'Q-learning','pseudorewards','DYNA','pseudorewards + DYNA'})
% title([num2str(nSims),' simulations'],'fontsize',16)
% xlabel('episode','fontsize',16)
% ylabel('reward (mean \pm SEM)','fontsize',16)

if SAVE
    save_figure('model_comparison_of_learning',gcf,'paper/preliminary')
end
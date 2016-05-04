
LOAD = true;
SAVE = true;

if LOAD
%     load 100sim_all4learning-PR-opt_dense
    load 100sim_all4learning-PR-opt_sparse
%     load 100sim_PR-man-noiseOpt-noiseman_dense
%     load 100sim_PR-man-noiseOpt-noiseman_sparse
end

figure('position',[0 0 600 300])
Y = squeeze(mean(simulation_data.steps,2));
X = repmat([1:size(Y,1)]',[1 size(Y,2)]);
plot(Y,'linewidth',2)
legend({'Q-learning','pseudorewards (optimal)','DYNA','pseudorewards + DYNA'})
% legend({'manhattan distance','noisy optimal pseudorewards','noisy manhattan distance'})
title(['sparse maze learning'],'fontsize',16)
xlabel('episode','fontsize',16)
ylabel('steps (mean \pm SEM)','fontsize',16)

if SAVE
    save_figure('modelCompare_sparse',gcf,'paper/preliminary')
end
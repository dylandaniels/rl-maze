clear all;

SAVE = true;

plotTypes = {'models','modelsLowNoise','DYNA','PRdense','PRsparse'};

for i = 2%1:length(plotTypes)
    
plotType = plotTypes{i};

switch plotType
    case 'models'
        load(['100sim_DYNAreplay-0-1-5-10-20-40-80_dense'])
        dat1 = simulation_data.steps(:,:,[1 5]);
        load(['100sim_PRoptSigma-0-1-2-4-8_dense'])
        dat2 = simulation_data.steps(:,:,4);
        load('100sim_PRmanSigma-0-1-4-8_dense')
        dat3 = simulation_data.steps(:,:,3);
        load('100sim_PRopt4+DYNA20_dense')
        dat4 = simulation_data.steps;
        load('100sim_PRman4+DYNA20_dense')
        dat5 = simulation_data.steps;
        load(['100sim_DYNAreplay-0-1-5-10-20-40-80_sparse'])
        dat6 = simulation_data.steps(:,:,[1 5]);
        load(['100sim_PRoptSigma-0-1-2-4-8_sparse'])
        dat7 = simulation_data.steps(:,:,4);
        load('100sim_PRmanSigma-0-1-4-8_sparse')
        dat8 = simulation_data.steps(:,:,3);
        load('100sim_PRopt4+DYNA20_sparse')
        dat9 = simulation_data.steps;
        load('100sim_PRman4+DYNA20_sparse')
        dat10 = simulation_data.steps;
        simulation_data.steps = cat(3,dat1,dat2,dat3,dat4,dat5,dat6,dat7,dat8,dat9,dat10);
    case 'modelsLowNoise'
        load(['100sim_DYNAreplay-0-1-5-10-20-40-80_dense'])
        dat1 = simulation_data.steps(:,:,[1 5]);
        load(['100sim_PRoptSigma-0-1-2-4-8_dense'])
        dat2 = simulation_data.steps(:,:,1);
        load('100sim_PRmanSigma-0-1-4-8_dense')
        dat3 = simulation_data.steps(:,:,3);
        load('100sim_PRopt0+DYNA20_dense')
        dat4 = simulation_data.steps;
        load('100sim_PRman0+DYNA20_dense')
        dat5 = simulation_data.steps;
        load(['100sim_DYNAreplay-0-1-5-10-20-40-80_sparse'])
        dat6 = simulation_data.steps(:,:,[1 5]);
        load(['100sim_PRoptSigma-0-1-2-4-8_sparse'])
        dat7 = simulation_data.steps(:,:,4);
        load('100sim_PRmanSigma-0-1-4-8_sparse')
        dat8 = simulation_data.steps(:,:,3);
        load('100sim_PRopt0+DYNA20_sparse')
        dat9 = simulation_data.steps;
        load('100sim_PRman0+DYNA20_sparse')
        dat10 = simulation_data.steps;
        simulation_data.steps = cat(3,dat1,dat2,dat3,dat4,dat5,dat6,dat7,dat8,dat9,dat10);
    case 'DYNA'
        load(['100sim_DYNAreplay-0-1-5-10-20-40-80_dense'])
        dat1 = simulation_data.steps(:,:,[1,2,3,5,7]);
        load(['100sim_DYNAreplay-0-1-5-10-20-40-80_sparse'])
        dat2 = simulation_data.steps(:,:,[1,2,3,5,7]);
        simulation_data.steps = cat(3,dat1,dat2);
    case 'PRdense'
        load('100sim_PRmanSigma-0-1-4-8_dense')
        dat1 = simulation_data.steps;
        load(['100sim_PRoptSigma-0-1-2-4-8_dense'])
        dat2 = simulation_data.steps(:,:,[1 2 4 5]);
        simulation_data.steps = cat(3,dat1,dat2);
    case 'PRsparse'
        load('100sim_PRmanSigma-0-1-4-8_sparse')
        dat1 = simulation_data.steps;
        load(['100sim_PRoptSigma-0-1-2-4-8_sparse'])
        dat2 = simulation_data.steps(:,:,[1 2 4 5]);
        simulation_data.steps = cat(3,dat1,dat2);
end

figure('position',[0 0 600 300]); hold on;
Y = squeeze(mean(simulation_data.steps,2));
switch plotType
    case 'models'
        cmap = jet(6);
        set(gca, 'ColorOrder', cmap);
        plot(Y(:,1:6),'linewidth',1.5)
        plot(Y(:,7:12),'linewidth',1.5,'linestyle','--')
        legend({'Q-learning','DYNA 20 replays','optimal pseudorewards, \sigma = 0.4','manhattan pseudorewards, \sigma = 0.4',...
            'optimal PR \sigma = 0.4, + DYNA 20 replays','manhattan PR \sigma = 0.4, + DYNA 20 replays'})
        title(['maze learning: DYNA vs. noisy pseudorewards'],'fontsize',16)
    case 'modelsLowNoise'
        cmap = jet(6);
        set(gca, 'ColorOrder', cmap);
        plot(Y(:,1:6),'linewidth',1.5)
        plot(Y(:,7:12),'linewidth',1.5,'linestyle','--')
        legend({'Q-learning','DYNA 20 replays','optimal pseudorewards','manhattan pseudorewards',...
            'optimal PR + DYNA 20 replays','manhattan PR + DYNA 20 replays'})
        title(['maze learning: DYNA vs. pseudorewards'],'fontsize',16)
    case 'DYNA'
        cmap = jet(5);
        set(gca, 'ColorOrder', cmap);
        plot(Y(:,1:5),'linewidth',1.5);
        plot(Y(:,6:10),'linewidth',1.5,'linestyle','--');
        legend({'Q-learning','DYNA 1 replay','5 replays','20 replays','80 replays'})
        title(['maze learning: DYNA'],'fontsize',16)
    case 'PRdense'
        cmap = jet(8);
        set(gca, 'ColorOrder', cmap);
        plot(Y(:,1:4),'linewidth',1.5,'marker','x')
        plot(Y(:,5:8),'linewidth',1.5,'marker','o')
        legend({'manhattan pseudorewards, \sigma = 0','manhattan pseudorewards, \sigma = 0.1','manhattan pseudorewards, \sigma = 0.4','manhattan pseudorewards, \sigma = 0.8',...
            'optimal pseudorewards, \sigma = 0','optimal pseudorewards, \sigma = 0.1','optimal pseudorewards, \sigma = 0.4','optimal pseudorewards, \sigma = 0.8'})
        title(['maze learning: pseudorewards (dense maze)'],'fontsize',16)
    case 'PRsparse'
        cmap = jet(8);
        set(gca, 'ColorOrder', cmap);
        plot(Y(:,1:4),'linewidth',1.5,'linestyle','--','marker','x')
        plot(Y(:,5:8),'linewidth',1.5,'linestyle','--','marker','o')
        legend({'manhattan pseudorewards, \sigma = 0','manhattan pseudorewards, \sigma = 0.1','manhattan pseudorewards, \sigma = 0.4','manhattan pseudorewards, \sigma = 0.8',...
            'optimal pseudorewards, \sigma = 0','optimal pseudorewards, \sigma = 0.1','optimal pseudorewards, \sigma = 0.4','optimal pseudorewards, \sigma = 0.8'})
        title(['maze learning: pseudorewards (sparse maze)'],'fontsize',16)
end
ylim([0 2000])
xlabel('episode','fontsize',16)
ylabel('steps','fontsize',16)

if SAVE
    switch plotType
        case 'models'
            save_figure(['modelCompareHighNoise'],gcf,'paper/final')
        case 'modelsLowNoise'
            save_figure(['modelCompareNoNoise'],gcf,'paper/final')
        case 'DYNA'
            save_figure(['DYNAcompare'],gcf,'paper/final')
        case 'PRdense'
            save_figure(['PRdenseCompare'],gcf,'paper/final')
        case 'PRsparse'
            save_figure(['PRsparseCompare'],gcf,'paper/final')
    end
end
end
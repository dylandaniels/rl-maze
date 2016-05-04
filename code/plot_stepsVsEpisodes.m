
LOAD = true;
SAVE = true;

plotType = 'DYNA';

mzTypes = {'dense' 'sparse'};
for mt = 1:2
    mzType = mzTypes{mt};
    
if LOAD
    switch plotType
        case 'PR'
            load(['100sim_PR-man-noiseOpt-noiseman_',mzType])
        case 'models'
            load(['100sim_all4learning-PR-opt_',mzType])
        case 'DYNA'
            load(['100sim_DYNAreplay-0-1-5-10-20-40-80_',mzType])
        case 'PRnoise'
            load(['100sim_PRoptSigma-1-2-4-8_',mzType])
    end
end

figure('position',[0 0 600 300])
Y = squeeze(mean(simulation_data.steps,2));
X = repmat([1:size(Y,1)]',[1 size(Y,2)]);
plot(Y,'linewidth',2)
ylim([0 2000])
switch plotType
    case 'PR'
        legend({'manhattan distance','noisy optimal pseudorewards','noisy manhattan distance'})
        title([mzType,' maze learning: pseudoreward comparison'],'fontsize',16)
    case 'models'
        legend({'Q-learning','pseudorewards (optimal)','DYNA (10 replays)','pseudorewards + DYNA'})
        title([mzType,' maze learning: model comparison'],'fontsize',16)
    case 'DYNA'
        legend({'Q-learning','DYNA 1 replay','5 replays','10 replays','20 replays','40 replays','80 replays'})
        title([mzType,' maze learning: DYNA replay quantity'],'fontsize',16)
    case 'PRnoise'
        legend({'\sigma = 0.1','\sigma = 0.2','\sigma = 0.4','\sigma = 0.8'})
        title([mzType,' maze learning: pseudoreward noise quantity'],'fontsize',16)
end
xlabel('episode','fontsize',16)
ylabel('steps','fontsize',16)

if SAVE
    switch plotType
        case 'PR'
            save_figure(['pseudorewardCompare_',mzType],gcf,'paper/preliminary')
        case 'models'
            save_figure(['modelCompare_',mzType],gcf,'paper/preliminary')
        case 'DYNA'
            save_figure(['DYNAcompare_',mzType],gcf,'paper/preliminary')
        case 'PRnoise'
            save_figure(['PRnoiseCompare_',mzType],gcf,'paper/preliminary')
    end
end
end
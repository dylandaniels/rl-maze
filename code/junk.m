
% load simulation_data.mat
figure('position',[0 0 900 900])
subplot(2,1,1)
Y = squeeze(mean(simulation_data.steps,2));
E = squeeze(std(simulation_data.steps,0,2))./sqrt(size(simulation_data,2));
errorbar(Y,E,'linewidth',2)
legend({'Q-learning','pseudorewards','DYNA','pseudorewards + DYNA'})
title('100 simulations','fontsize',16)
xlabel('episode','fontsize',16)
ylabel('steps (mean \pm SEM)','fontsize',16)
subplot(2,1,2)
Y = squeeze(mean(simulation_data.reward,2));
E = squeeze(std(simulation_data.reward,0,2))./sqrt(size(simulation_data,2));
errorbar(Y,E,'linewidth',2)
legend({'Q-learning','pseudorewards','DYNA','pseudorewards + DYNA'})
title('100 simulations','fontsize',16)
xlabel('episode','fontsize',16)
ylabel('reward (mean \pm SEM)','fontsize',16)
% save_figure('model_comparison_of_learning',gcf,'preliminary')

%%
mazePosition2vectorPosition = mazePos2vecPos(M,N,start);
mat = flipud(mazePosition2vectorPosition);

figure
imagesc(V(mat))

policy_mat = policy(mat)

% figure
% subplot(2,2,1)
% pr = pseudoreward_matrix(:,1);
% image(pr(mat))
% subplot(2,2,2)
% pr = pseudoreward_matrix(:,2);
% image(pr(mat))
% subplot(2,2,3)
% pr = pseudoreward_matrix(:,3);
% image(pr(mat))
% subplot(2,2,4)
% pr = pseudoreward_matrix(:,4);
% image(pr(mat))
% 
% qw=V(mat);


%%
q1 = reshape(Q(:,1),[6 9]);
q2 = reshape(Q(:,2),[6 9]);
q3 = reshape(Q(:,3),[6 9]);
q4 = reshape(Q(:,4),[6 9]);

figure
subplot(2,2,1)
imagesc(q1)
subplot(2,2,2)
imagesc(q2)
subplot(2,2,3)
imagesc(q3)
subplot(2,2,4)
imagesc(q4)




% tic
% for i=1:200000
% if any(size(pos) ~= [1 2]) || size(goal,2) ~= 2
%     error('unexpected location dimensions')
% end
% end
% toc

%%

x1 = [1,1,1,1,1,1,1;1,1,1,3,1,1,1;1,1,2,2,2,1,1;1,3,2,2,2,3,1;1,1,2,2,2,1,1;1,1,1,3,1,1,1;1,1,1,1,1,1,1];
x2 = [1,1,1,1,1,1,1,1,1,1,1;1,1,1,1,1,3,1,1,1,1,1;1,1,1,1,3,2,3,1,1,1,1;1,1,1,1,1,2,1,1,1,1,1;1,1,3,1,2,2,2,1,3,1,1;1,3,2,2,2,2,2,2,2,3,1;1,1,3,1,2,2,2,1,3,1,1;1,1,1,1,1,2,1,1,1,1,1;1,1,1,1,3,2,3,1,1,1,1;1,1,1,1,1,3,1,1,1,1,1;1,1,1,1,1,1,1,1,1,1,1];
x3 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1;1,1,1,1,1,3,1,1,1,3,1,1,1,1,1;1,1,1,1,3,2,3,1,3,2,3,1,1,1,1;1,1,1,1,1,2,1,3,1,2,1,1,1,1,1;1,1,3,1,1,2,2,2,2,2,1,1,3,1,1;1,3,2,2,2,1,1,2,1,1,2,2,2,3,1;1,1,3,1,2,1,2,2,2,1,2,1,3,1,1;1,1,1,3,2,2,2,2,2,2,2,3,1,1,1;1,1,3,1,2,1,2,2,2,1,2,1,3,1,1;1,3,2,2,2,1,1,2,1,1,2,2,2,3,1;1,1,3,1,1,2,2,2,2,2,1,1,3,1,1;1,1,1,1,1,2,1,3,1,2,1,1,1,1,1;1,1,1,1,3,2,3,1,3,2,3,1,1,1,1;1,1,1,1,1,3,1,1,1,3,1,1,1,1,1;1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
example = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1;1,1,1,1,1,1,1,1,1,3,1,1,1,1,1;1,1,1,1,1,1,1,1,3,2,3,1,1,1,1;1,1,1,1,1,1,1,3,1,2,1,1,1,1,1;1,1,3,1,1,1,3,2,2,2,1,1,3,1,1;1,1,2,2,2,1,1,2,1,1,2,2,2,3,1;1,1,3,1,2,1,2,2,2,1,2,1,3,1,1;1,1,1,3,2,2,2,2,2,2,2,3,1,1,1;1,1,3,1,2,1,2,2,2,1,2,1,3,1,1;1,3,2,2,2,1,1,2,1,1,2,2,2,3,1;1,1,3,1,1,1,3,2,2,2,1,1,3,1,1;1,1,1,1,1,1,1,3,1,2,1,1,1,1,1;1,1,1,1,1,1,1,1,3,2,3,1,1,1,1;1,1,1,1,1,1,1,1,1,3,1,1,1,1,1;1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
figure('units', 'pixels', 'position', [100 100 1200 300], 'resize', 'off'); 
subplot(1,4,1); imagesc(x1);title('complexity 1 full maze');
subplot(1,4,2); imagesc(x2);title('complexity 2 full maze');
subplot(1,4,3); imagesc(x3);title('complexity 3 full maze');
subplot(1,4,4); imagesc(example);title('complexity 3 random partial maze');

%%

qw = rand(20,20);
qw = qw > .7;
figure, imagesc(qw)







%%

x=[];
figure;
while isempty(x)
    m3=makeMazeModified(6);
    imagesc(m3)
    x=input('hi');
    figure(gcf)
end


%%


simulation_data.steps = cat(3,sd.steps(:,:,1),simulation_data.steps)
simulation_data.reward = cat(3,sd.reward(:,:,1),simulation_data.reward)


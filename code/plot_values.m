




load maze_values.mat

figure('position',[0 0 360 360])


mazePosition2vectorPosition = mazePos2vecPos(11,11);
mat = flipud(mazePosition2vectorPosition);


subplot(2,2,1)
V = value.dense.optimal_policy;
imagesc(V(mat))
title({'optimal policy values','(dense maze)'})

subplot(2,2,2)
V = value.dense.manhattan_dist;
imagesc(V(mat))
title({'manhattan distance values','(dense maze)'})

subplot(2,2,3)
V = value.sparse.optimal_policy;
imagesc(V(mat))
title({'optimal policy values','(sparse maze)'})

subplot(2,2,4)
V = value.sparse.manhattan_dist;
imagesc(V(mat))
title({'manhattan distance values','(sparse maze)'})


save_figure('value_landscapes',gcf,'paper/preliminary')
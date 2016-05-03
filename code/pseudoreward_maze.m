
% Set shaping function
[transition_matrix, reward_matrix] = ...
    get_transitionAndReward_matrices(statelist,actionlist,maze,M,N,start,goal,reward_landscape);
% first row of transition matrix (state 1) corresponds to position "start";
% all subsequent states (rows of transition matrix) procede bottom to top
% and left to right through the maze, then wrap back to [0 0] and proceed
% back to "start"

[V, policy, cpu_time] = mdp_LP(transition_matrix, reward_matrix, gamma);

% pseudorewards = get_pseudoreward_matrix(V,policy,transition_matrix,gamma);

shaping = V;
% shaping = pseudorewards;

simulation_data.steps = nan(maxepisodes,nSims,4);
simulation_data.reward = nan(maxepisodes,nSims,4);

for learning_process = which_learning_process
    disp(['Learning process ',num2str(learning_process)])
    switch learning_process
        case 1 % Q-learning
            opts.pseudorewards = false;
            opts.planning = false;
        case 2 % psuedo rewards
            opts.pseudorewards = true;
            opts.planning = false;
        case 3 % DYNA
            opts.pseudorewards = false;
            opts.planning = true;
        case 4 % DYNA + pseudorewrds
            opts.pseudorewards = true;
            opts.planning = true;
    end
    
    for simulation = 1:nSims
        if ~rem(simulation,10)
            disp(['Sim ',num2str(simulation)])
        end
        
        % reset Q for each simulation
        Q = BuildQTable(nstates,nactions);
        
        for i=1:maxepisodes
            
            
            [total_reward,steps,Q ] =  pseudoreward_episode(maxsteps, Q, Model,...
                alpha, gamma, epsilon, statelist, actionlist,...
                grafica, maze, start, goal, p_steps, shaping, opts, reward_landscape,i) ;
            
            simulation_data.steps(i,simulation,learning_process) = steps;
            simulation_data.reward(i,simulation,learning_process) = total_reward;
            
            
            if grafica
                
                disp(['Espisode: ',int2str(i),'  Steps:', int2str(steps),'  Reward:',...
                    num2str(total_reward), ' epsilon: ' ,num2str(epsilon)])
                
                
                xpoints(i)=i-1;
                ypoints(i)=steps;
                subplot(2,1,2);
                plot(xpoints,ypoints)
                title(['Episode: ',int2str(i),' epsilon: ',num2str(epsilon)])
                
                
                drawnow

                if (i>2000000)
                    grafica=true;
                end
            end
        end
    end
end


simulation_data.steps = nan(maxepisodes,nSims,1);
simulation_data.reward = nan(maxepisodes,nSims,1);
sigmas = sigma;
p_steps_all = p_steps;
for ps = 1:length(p_steps_all)
    p_steps = p_steps_all(ps);
for sig = 1:length(sigmas)
    sigma = sigmas(sig);
for pr = 1:length(which_pseudorewards)
    which_pseudoreward = which_pseudorewards{pr};
switch which_pseudoreward
    % shaping function is the optimal policy as found by mdp LP
    case 'optimal_policy'
        [transition_matrix, reward_matrix] = ...
            get_transitionAndReward_matrices(statelist,actionlist,maze,...
                                             M,N,start,goal,...
                                             reward_landscape);
                                         
        [V, policy, cpu_time] = mdp_LP(transition_matrix, reward_matrix,...
                                       gamma);
                                   
        shaping = V;
        opts.noisy = false;
    case 'manhattan'
        shaping = manhattan_dist(maze, goal, gamma);
        opts.noisy = false;
    case 'optimal_policy_noisy'
        [transition_matrix, reward_matrix] = ...
            get_transitionAndReward_matrices(statelist,actionlist,maze,...
                                             M,N,start,goal,...
                                             reward_landscape);
                                         
        [V, policy, cpu_time] = mdp_LP(transition_matrix, reward_matrix,...
                                       gamma);
                                   
        shaping = V;
        opts.noisy = true;
    case 'manhattan_noisy'
        shaping = manhattan_dist(maze, goal, gamma);
        opts.noisy = true;
end

sq = [];

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
        
        xpoints = [];
        ypoints = [];
        for i=1:maxepisodes
            
            
            [total_reward,steps,Q, sq,xpoints,ypoints ] =  pseudoreward_episode(maxsteps, Q, Model,...
                alpha, gamma, epsilon, statelist, actionlist,...
                grafica, maze, start, goal, p_steps, shaping, opts, reward_landscape,i, sq,xpoints,ypoints,...
                sigma) ;
            
            simulation_data.steps(i,simulation,sig) = steps;
            simulation_data.reward(i,simulation,sig) = total_reward;
            
            
            if grafica
                if (i>2000000)
                    grafica=true;
                end
            end
        end
    end
end
end
end
end
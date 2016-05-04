function [ total_reward,steps,Q, sq ] = pseudoreward_episode(  maxsteps, Q, Model, alpha, gamma,epsilon,statelist,actionlist,grafic,maze,start,goal,p_steps, shaping, opts,reward_landscape,ep,sq)
% maxstepts: the maximum number of steps per episode
% Q: the current QTable
% alpha: the current learning rate
% gamma: the current discount factor
% epsilon: probablity of a random action
% statelist: the list of states
% actionlist: the list of actions
% shaping: reward shaping function (e.g. optimal V^*(s))

x            = start;
steps        = 0;
total_reward = 0;

% convert the continous state variables to an index of the statelist
s   = DiscretizeState(x,statelist);
nonWallActions = get_wallActions(maze);
% selects an action using the epsilon greedy selection strategy
a   = e_greedy_selection_noWalls(Q,s,epsilon, nonWallActions);

for i=1:maxsteps
    
    % convert the index of the action into an action value
    action = actionlist(a);
    
    %do the selected action and get the next car state
    xp  = DoAction( action , x, maze );
    
    % observe the reward at state xp and the final state flag
    [r,f]   = GetReward(xp,goal,reward_landscape);
    total_reward = total_reward + r;
    
    % convert the continous state variables in [xp] to an index of the statelist
    sp  = DiscretizeState(xp,statelist);
    
    % select action prime
    ap = e_greedy_selection_noWalls(Q,sp,epsilon,nonWallActions);
    
    
    if opts.pseudorewards
        % Set r to real reward value plus psuedo-reward
        % i.e., Q Learning updates "as if" the pseudo-reward was a real reward
        pseudoreward = gamma * shaping(sp) - shaping(s);
        r = r + pseudoreward;
    end
    
    % Update the Qtable, that is,  learn from the experience
    Q = UpdateQLearning( s, a, r, sp, ap, Q , alpha, gamma );
    
    if opts.planning
        % Planning
        Model = UpdateModel(s,a,r,sp,Model);
        Q     = RandomPlanning(Q, Model, p_steps, alpha, gamma);
    end
    
    %update the current variables
    s = sp;
    a = ap;
    x = xp;
    
    
    %increment the step counter.
    steps=steps+1;
    
    
    % Plot of the mountain car problem
    if (grafic==true)
        if ep == 1 && i == 1
            Plot( x,a,steps,maze,start,goal,['Pseudo-reward Learning']);
            hold on
            sq = [];
        end
        if i == 1
            subplot(2,1,1);
        end
        pause(.00001)
        delete(sq)
        sq = plot(x(1)+0.5,x(2)+0.5,'sk','MarkerFaceColor','k','MarkerSize',10);
    end
    
    % if reachs the goal breaks the episode
    if (f==true)
        break
    end
end

if (grafic==true)
    disp(['Espisode: ',int2str(ep),'  Steps:', int2str(steps),'  Reward:',...
        num2str(total_reward), ' epsilon: ' ,num2str(epsilon)])
    
    xpoints(ep)=ep-1;
    ypoints(ep)=steps;
    subplot(2,1,2);
    plot(xpoints,ypoints)
    title(['Episode: ',int2str(i),' epsilon: ',num2str(epsilon)])

    drawnow
end


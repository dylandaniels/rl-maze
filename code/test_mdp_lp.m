% A quick sanity check for the MDP LP function
% Only three states in a horizontal line
% The rightmost state confers reward 1.

transition_matrix = zeros(3, 3, 2);

transition_matrix(1,:,1) = [0 1 0];
transition_matrix(1,:,2) = [1 0 0];

transition_matrix(2,:,1) = [0 0 1]; % moving right
transition_matrix(2,:,2) = [1 0 0]; % moving left

reward_matrix = zeros(3, 2);
reward_matrix(3, :) = 1;

gamma = 0.95;

[V, policy] = mdp_LP(transition_matrix, reward_matrix, gamma)


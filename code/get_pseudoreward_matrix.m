function pseudoreward_matrix = get_pseudoreward_matrix(V,policy,transition_matrix,discount)
% ... not setup for probabilistic transitions...

pseudoreward_matrix = zeros(size(transition_matrix,1),size(transition_matrix,3));

for s = 1:size(transition_matrix,1)
    optimal_action = policy(s);
    sp = find(transition_matrix(s,:,optimal_action)); % assumes one deterministic transition
    if isempty(sp) % terminal state
        pseudoreward = 0;
    else
        pseudoreward = V(sp) - V(s); % discount* ... V already has discount applied?
    end
    pseudoreward_matrix(s,optimal_action) = pseudoreward;
end
function [ r,f ] = GetReward( pos,goal,reward_landscape )
% MountainCarGetReward returns the reward at the current state
% x: a vector of position and velocity of the car
% r: the returned reward.
% f: true if the car reached the goal, otherwise f is false


if any(size(pos) ~= [1 2]) || size(goal,2) ~= 2
    error('unexpected location dimensions')
end

reward_landscape = flipud(reward_landscape); % pos goes bottom to top
r = reward_landscape(pos(2)+1,pos(1)+1);

pos = repmat(pos,[size(goal,1) 1]);
if any(all( pos'==goal'))
    f = true;
else
    f = false;
end






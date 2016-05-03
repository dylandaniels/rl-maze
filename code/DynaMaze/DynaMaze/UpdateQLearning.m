function [ Q ] = UpdateQLearning( s, a, r, sp, ap, Q , alpha, gamma )
% UpdateQ update de Qtable and return it using Whatkins Q-Learing
% s1: previous state before taking action (a)
% s2: current state after action (a)
% r: reward received from the environment after taking action (a) in state
%                                             s1 and reaching the state s2
% a:  the last executed action
% tab: the current Qtable
% alpha: learning rate
% gamma: discount factor
% Q: the resulting Qtable

TD_error =   ((r + gamma*max(Q(sp,:))) - Q(s,a));
Q(s,a) =  Q(s,a) + alpha * TD_error;


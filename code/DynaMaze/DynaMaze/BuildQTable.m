function [ Q ] = BuildQTable( nstates,nactions )
%BuildQTable do exactly this
%Q: the returned initialized QTable

Q = zeros(nstates,nactions);
 
 
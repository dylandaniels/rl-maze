function [ Model ] = BuildModel( nstates,nactions )
%BuildQTable do exactly this
%Q: the returned initialized QTable

Model = zeros(nstates,nactions,2);
 
 
%% 
% * Compute the adjacency matrix for the network with links given by DCCA coefficients 
% and for the network with links given by the DCCA distances. 
% * Folter both networks with the MST
% * Compute the spectrum for both fifltered adjacency matrices.
%% 
% 
% 
% output:
% 
% G - network of DCCA distances
% 
% Gnodist - network of DCCA coefficients
% 
% A2_matrix - adjacency matrix of the  thefiltered DCCA distances network
% 
% A2_matrixnodist - adjacency matrix of filtered DCCA coefficients network
% 
% cost_min - average tree length of the network of DCCA distances network
% 
% eigenvaluesdist - specturm of the adjacency matrix of DCCA distances network
% 
% eigenvaluesnodist - specturm of the adjacency matrix of DCCA coefficients 
% network
% 
% plot of the spectrum of the adjacency matrix of DCCA coefficients network
% 
% 


for t = 1:(T - w + 1) %open the time loop


G = graph(rho_DCCA_matrixdist(:,:,t),'omitselfloops','upper');

Gnodist = graph(rho_DCCA_matrixnodist(:,:,t),'omitselfloops','upper');

T1= minspantree(G);

T1nodist= minspantree(Gnodist);

A2 = adjacency(T1,'weighted');

A2nodist = adjacency(T1nodist,'weighted');

A2_matrix(:,:,t)= full(A2);

A2_matrixnodist(:,:,t)= full(A2nodist);

cost_min(t)=sum(A2_matrix(:,:,t),'all')/(numedges(T1));


eigenvaluesdist(:,t)=eig(A2_matrix(:,:,t));

eigenvaluesnodist(:,t)=eig(A2_matrixnodist(:,:,t));

end



figure

plot(days(w+1:end), eigenvaluesnodist)
ylabel('DCCA coefficient Adjacency matrix spectrum')
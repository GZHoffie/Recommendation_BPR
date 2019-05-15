function [u_grad, i_grad, j_grad] = computeGradient(r_i,r_j,u,i,j,lambda)
%COMPUTEGRADIENT Computes the gradient for each parameter
%   Input: user rating r_i and r_j, the original parameter u,i,j, the
%   regularization parameter lambda
%   Output: the gradient u_grad, i_grad, j_grad

u_grad = 1/(1+exp(r_i-r_j))*(j-i)+lambda*u;
i_grad = -u/(1+exp(r_i-r_j))+lambda*i;
j_grad = u/(1+exp(r_i-r_j))+lambda*j;

end


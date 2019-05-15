function [u_hat_updated, v_i_updated, v_j_updated] = updateParameter(u_hat, v_i, v_j, u_grad,...
    i_grad, j_grad, alpha)
%UPDATEPARAMETER Update the paramter using gradient descent
%   Input: the gradient of each parameter u_grad, i_grad, j_grad, the
%   learning rate alpha, the max_iteration times, the initial
%   parameters u_hat, v_i, v_j.
%   Output: the updated parameters u_hat, v_i_updated, v_j_updated

u_hat_updated = u_hat - alpha*u_grad;
v_i_updated = v_i - alpha*i_grad;
v_j_updated = v_j - alpha*j_grad;



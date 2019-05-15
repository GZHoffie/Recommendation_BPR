function rec = getRecommendations(u_hat, Theta_sub)
%GETRECOMMENDATIONS Returns the recommendation in order

available_items = Theta_sub(:,1);
ratings = u_hat*Theta_sub(:,2:end)';
[~,I] = sort(ratings,'descend');
rec = available_items(I);

end


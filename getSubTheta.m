function Theta_sub = getSubTheta(Theta, impressions)
%GETSUBTHETA get the submatrix of Theta according to the given impressions

impression = str2double(string(split(impressions,"|")));
Theta_sub = zeros(length(impression),size(Theta,2));
for i = 1:length(impression)
    [~, Locb] = ismember(impression(i),Theta(:,1));
    Theta_sub(i,:) = Theta(Locb,:); 
end

end


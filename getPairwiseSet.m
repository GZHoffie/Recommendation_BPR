function U = getPairwiseSet(T_train_sub)
%GETPAIRWISESET evaluate the user's preference of some item over the other
%items
%   Input: T_train_sub, the sub matrix of T_train
%   Output: U, a matrix with each row containing two items (i,j),
%   indicating that the user prefers item i over item j.

% Summarize all items in a vector
all_items = [];
for l = 1:length(T_train_sub.impressions)
    all_items = [all_items; str2double(...
        string(split(T_train_sub.impressions(l),"|")))];
end

% Summarize clicked out items in a vector
clicked_items = str2double(string(unique(T_train_sub.reference)));

% Combine to form the comparison matrix
I = (clicked_items*ones(1,length(all_items)))';
I = I(:);
J = (all_items*ones(1,length(clicked_items)));
J = J(:);
U = [I,J];
U = U(randperm(size(U,1)),:);

end


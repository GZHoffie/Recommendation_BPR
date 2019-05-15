%% Read and initialize data
tic;
fprintf('loading item_meatadata files...')
load('Theta.mat')
fprintf('Done.\r')
toc;

tic;
fprintf('loading training set...')
T = readtable('train.csv');
fprintf('Done.\r')
toc;

tic;
% Normalize data in Theta (delete later)
fprintf('Initializing data...')
Theta(:,end) = vectorNormalize(Theta(:,end));

% Rearrange training set so that it is sorted
[users, ~, index] = unique(string(T.user_id));
[sort_users, sort_index] = sort(index);
T = T(sort_index,:);

% Simplify the trainings set by replacing user_id with numbers
T.user_id = sort_users;

% A subset of training set containing only clickout
T_sub = T(string(T.action_type)=='clickout item',:);
T_train = T_sub; %may be the whole table later.
clear T_sub
fprintf('Done.\r')
toc;


%% Initialize hyperparameters

learning_rate = 0.01;
regularization_param = 0.0001;



%% Iterate for each user...

% Store user latent vector
user_latent = zeros(length(users),size(Theta,2)-1);

tic;
for i = 89:10000%length(users)
    
    fprintf('Analyzing user No. %d...\n',i);
    
    % Get the subset of T_train
    [~, Locb1] = ismember(i,T_train.user_id);
    [~, Locb2] = ismember(i,T_train.user_id,'legacy');
    if (Locb1==0)
        continue
    end
    T_train_sub = T_train(Locb1:Locb2,:);
    
    % Compare pairwise preference
    U = getPairwiseSet(T_train_sub);
    
    % Draw latent vector for user
    u_hat = randn(1,size(Theta,2)-1)*0.01;
    
    
    % Apply SGD
    for k = 1:size(U,1)
        
        % Draw the latent vector for item i,j
        [~, Locbi] = ismember(U(k,1),Theta(:,1));
        [~, Locbj] = ismember(U(k,2),Theta(:,1));
        if (Locbi==0||Locbj==0)
            continue
        end
        v_i = Theta(Locbi,2:end);
        v_j = Theta(Locbj,2:end);
        
        % Compute estimated rating for i and j
        r_i = u_hat*v_i';
        r_j = u_hat*v_j';
        
        % update parameters
        [u_grad, i_grad, j_grad] = computeGradient(r_i,...
            r_j,u_hat,v_i,v_j,regularization_param);
        [u_hat, v_i_updated, v_j_updated] = updateParameter(u_hat, v_i, v_j, u_grad,...
            i_grad, j_grad, learning_rate);
        
        % update matrix
        Theta(Locbi,2:end) = v_i_updated;
        Theta(Locbj,2:end) = v_j_updated;   
        
    end
    
    % update user_latent matrix
    user_latent(i,:) = u_hat;
    
    % Verify and recommend
%     Theta_sub = getSubTheta(Theta, T_train.impressions(2));
%     rec = getRecommendations(u_hat, Theta_sub);
%     disp(rec)
    
    
    
    
    
    
end

toc;
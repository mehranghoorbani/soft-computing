%% Clear memory
% This problem is solved by Mehran Ghorbani for Soft Computing lesson
% in school of civil engineering in iran university of science and
% technology (IUST)
clear; 
clc; 
close all;

%% Load/Plot Data
data = load('dataset.txt');
msk = rand(size(data,1),1) < 0.8;                      % Split data
%% Train Set
data_train = data .* msk;

x_train = data_train(:,1);
x_train(x_train == 0)= [];
y_train = data_train(:,2);
y_train(y_train == 0)= [];
x_train = x_train./max(x_train);                       % Normalize x data
y_train = y_train./max(y_train);                       % Normalize y data
x_min_train = min(x_train);                                   % minimum x_train data
y_min_train = min(y_train);                                   % minimum y_train data

%% The Developement Set
data_test = data .* ~msk;

x_test = data_test(:,1);
x_test(x_test == 0)= [];
y_test = data_test(:,2);
y_test(y_test == 0)= [];
x_test = x_test./max(x_test);                       % Normalize x data
y_test = y_test./max(y_test);                       % Normalize y data
x_min_test = min(x_test);                            % minimum x_test data        
y_min_test = min(y_test);                            % minimum y_test data

%% Obtain Regression Coefficients and R^2
[f_train,gof,output] = fit(x_train,y_train,'poly3');        % Cubic regression is useful for this excercise 
f = string(formula(f_train)); % get the formular in string format
names = coeffnames(f_train); % get the coeff names
vals = coeffvalues(f_train); % get those values
for i = 1:length(names)
    f = strrep(f,string(names(i)),string(vals(i))); % replace the coeff names with values
end
f
y_hat = f_train(x_test);

figure
P1 = plot(x_train,y_train,'b.',...
    'MarkerSize',15);
grid on; 
hold on
P2 = plot(x_test,y_test,'r.',...
    'MarkerSize',15);
P3 = plot(f_train,'m','predobs');

xlabel('x (ND)','fontsize',14,'Interpreter','latex')
ylabel('y (ND)','fontsize',14,'Interpreter','latex')
title('Polynomial Regression','fontsize',14,'Interpreter','latex')
legend('Train Set','Test Set','Fitted Polynomial','Prediction Bound','location','northwest','fontsize',14,'Interpreter','latex')

set(gca,'TickLabelInterpreter','latex')
set(gcf,'Position',[0 0 1000 1000])   % Will probably need to change this on your computer

% Extract coefficients
error = abs(y_hat-y_test).^2
coefs = coeffvalues(f_train);             % Extract curve fit coefficients
Results = gof                   % Display the R^2 value. It's very close to 1, which is "good"
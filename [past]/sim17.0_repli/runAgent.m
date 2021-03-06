% written by professor Jay McClelland
function [ results ] = runAgent()
global a w h p mode;

%% initialize the state
initState();
updateState();
computeAnswer();    % compute the true 'answers'

%% training the model once
i = 0;
indices = zeros(1,p.maxIter);
while ~(w.done) && i < p.maxIter
    %% choose action
    selectAction();
    move();
    %% update the state
    updateState();
    updateWeights();
    indices(i + 1) = recordAction();     % record the "touch-index"
    i = i+1;
end
updateTeachingConditions();

%% save result
results.numErrors = w.errors;
results.indices = indices;
results.steps = i;
results.h = h;
results.a = a;
end


%% Helper functions
% for teacher forcing
function updateTeachingConditions()
global mode w p;
if p.teachingModeOn
    mode.teach = true; % the teacher is willing to teach at the begining
end
% check if it is behave correctly
if p.teacherForcingOn && mode.teacherForcing
    fprintf('.')
    if w.nItems + 1 ~= w.stateNum
        warning('?')
    end
end
end

% for try again mode
function letTheModelTryAgain()
global w mode;
fprintf('.');
% re-initialize the world if REDO
reinitState();
updateState();
w.maxTeachTrial = w.maxTeachTrial - 1;
if w.maxTeachTrial == 0
    % teacher give up if the model don't learn in 100 iterations
    mode.teach = false;
end
end
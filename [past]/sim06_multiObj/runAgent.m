% written by professor Jay McClelland

function [ results ] = runAgent()
global a w h p d;

initState();
updateState();
showState();
i = 0;
while ~(w.done) && i < 100
    selectAction();
    Act();
    updateState();
    updateWeights();
    showState();
    i = i+1;
end
%keyboard;
results.h = h;
results.a = a;
end
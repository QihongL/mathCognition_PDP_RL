function isnext = isNext()
%% This function decides
% It assumes the handposition conincides with 1 item in the world
global w ;
% isnext is false by default
isnext = false; 
% if it is the 1st item
if (find(w.rS.targPos == w.rS.handPos) - 1) == 0
    isnext = true;
    % or if ALL previous items were touched
elseif w.rS.targRemain(1:find(w.rS.targPos == w.rS.handPos)) == 1
    isnext = true;
end
%     w.rS
%     w.rS.targRemain'

end

function isuntouched = isUntouched()
global w;
isuntouched = false;
if w.rS.targRemain(w.rS.handPos == w.rS.targPos) == true
    isuntouched = true;
end
end
function [src, dest] = doJockeying(u)
% Checks length of the queues to decide whether jockeying should happen.
% Jockeying happens when one queue is at least 2 shorter than another one.
% If several origins are possible, the nearest one to the destination is
%   chosen, if on both sides, choose the left one.
%
% inputs
%   u     vector of queue lengths (including server), size N
% outputs
%   src   number of start queue of jockeying process
%         0, if no jockeying
%   dest  number of destination queue of jockeying process
%
N = length(u);

[nMin, dest] = min(u);  % if there are more than one: choose the first one
longQueues = find(u >= nMin+2);
doJockey = ~isempty(longQueues);
if doJockey
  [~, I] = min(abs(longQueues - dest));
  src = longQueues(I);
else
  src = 0;
end

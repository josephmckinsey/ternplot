% TERNARROW calculate rectangular coordinates of an arrow described by
%   three values: (fA, fB, fC)

%   [X, Y] = TERNARROW(FA, FB) returns the rectangular X and Y directions
%   for the ternary direction indicated by fA, fB, and fC.
%       c
%      / \
%     /   \
%    a --- b

% Author: JOSEPH MCKINSEY 20180509

% Modifications

function [x, y] = ternarrow(fA, fB, fC, direction)
if nargin < 3
    fC = 1 - (fA + fB);
end

if nargin < 4
    direction = 'clockwise';
end

%transform = [-cos(deg2rad(30))  cos(deg2rad(30)) 0 ;
%             -sin(deg2rad(30)) -sin(deg2rad(30)) 1];
         
if ~strcmp(direction, 'clockwise')
    x = cos(deg2rad(30))* (fC - fA);
    y = -sin(deg2rad(30)) * (fA + fC) + fB;
else
    x = cos(deg2rad(30))* (fB - fA);
    y = -sin(deg2rad(30)) * (fA + fB) + fC;
end
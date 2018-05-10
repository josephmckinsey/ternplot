% TERNQUIVER quiver plot ternary phase diagram
%   TERNQUIVER(f) plots ternary phase diagram for three components (inputs
%   to f). The arrows are plotted on the ternary with a default of 20
%   points for A and B.
%
%   TERNQUIVER(f, num) Plots ternary phase information from function f and
%   resolution of num x num.
%
%   TERNPLOT(f,num, LINETYPE) the same as the above, but with a user specified LINETYPE (see PLOT
%       for valid linetypes).
%
%   The parameters above can be followed by parameter/value pairs to
%   specify additional properties as with the PLOT function. All
%   unrecognized options will be passed through to the PLOT command. The
%   following options are used by this function:
%
%   Parameter  Default Description
%   ---------  ------- -----------
%   num        20      Number of points plotted per axis.
%   sortpoints false   Sort points in x order before plotting          
%
%   Example
%
%       ternplot(f, 20)
%
%
%   See also TERNPLOT TERNLABEL PLOT POLAR QUIVER

%       b
%      / \
%     /   \
%    c --- a 

% Author: JOSEPH MCKINSEY 20180509

% To do

% Modifications

function handles = ternquiver(f, num, varargin)

if nargin < 2
    num = 20;
end


[varargin, majors] = extractpositional(varargin, 'majors', 10);
[varargin, sortpoints] = extractpositional(varargin, 'sortpoints', false);

[A, B] = meshgrid(linspace(0.01,0.99,num), linspace(0.01, 0.99, num));
C = 1 - A - B;

U = zeros(size(A));
V = zeros(size(A));
W = zeros(size(A));

for i = 1:size(A,1)
    for j = 1:size(A, 2)
        if (A(i, j) + B(i, j) >= 1)
            U(i, j) = nan;
            V(i, j) = nan;
            W(i, j) = nan;
        else
            new = f(0, [A(i, j); B(i, j); C(i, j)]);
            U(i, j) = new(1);
            V(i, j) = new(2);
            W(i, j) = new(3);
        end
    end
end

[fA, fB, fC] = fractions(A, B, C);
[x, y] = terncoords(fA, fB, fC);

[u, v] = ternarrow(U, V, W);

% Sort data points in x order
if sortpoints
    [x, i] = sort(x);
    y = y(i);
end

% Make ternary axes
[hold_state, cax, next] = ternaxes(majors);

% plot data
q = quiver(x, y, u, v, varargin{:});
if nargout > 0
    handles = q;
end
if ~hold_state
    set(gca,'dataaspectratio',[1 1 1]), axis off; set(cax,'NextPlot',next);
end

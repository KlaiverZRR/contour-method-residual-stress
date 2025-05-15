function [fitresult, gof] = createFit(xq, yq, zq, n)
%CREATEFIT(XQ,YQ,ZQ)
%  Create a fit.
%
%  Data for ' fit 4' fit:
%      X Input : xq
%      Y Input : yq
%      Z Output: zq
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  另请参阅 FIT, CFIT, SFIT.

%  由 MATLAB 于 08-Nov-2022 15:01:50 自动生成


%% Fit: 'untitled fit 1'.
[xData, yData, zData] = prepareSurfaceData( xq, yq, zq );
% Set up fittype and options.
switch n
    case 1
        ft = fittype( 'poly11' );
    case 2
        ft = fittype( 'poly22' );
    case 3
        ft = fittype( 'poly33' );
    case 4
        ft = fittype( 'poly44' );
    case 5
        ft = fittype( 'poly55' );
end

% Fit model to data.
[fitresult, gof] = fit( [xData, yData], zData, ft,'Normalize', 'off');

% Plot fit with data.
figure( 'Name', 'fit' );
h = plot( fitresult, [xData, yData], zData );
legend( h, 'fit', 'zq vs. xq, yq', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'xq', 'Interpreter', 'none' );
ylabel( 'yq', 'Interpreter', 'none' );
zlabel( 'zq', 'Interpreter', 'none' );
grid on



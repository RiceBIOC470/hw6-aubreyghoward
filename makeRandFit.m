function [fit_out,fit_metric] = makeRandFit(xx, noise_lvl,figNum)

x = figNum+1;
figure(x); subplot(2,2,1); hold on;
D = noise_lvl;%Noise level selected at 1, as per the instructions.
yy = -7*xx.^3+90*xx.^2+2*xx-7+((rand(length(xx),1)-0.5)*D);
plot (xx,yy,'.','MarkerSize',10);
hold off;



% Part 2. Fit your data with polynomials from order 1 to 9. Plot the fitted
% polynomials together with the data. 
subplot(2,2,2);
plot (xx,yy,'b.','MarkerSize',10); hold on;
polytype = {'poly1','poly2','poly3','poly4','poly5','poly6','poly7','poly8','poly9'};

for ii = 1:9
[fit_out{ii},fit_metric{ii}] = fit(xx,yy,polytype{ii});
plot(fit_out{ii}); set(gca,'Fontsize',8); hold on;
end
legend(polytype);
hold off;

% Part 3. On a separate plot, plot the R^2 and adjusted R^2 as a function
% of the order of the polynomial. 

subplot(2,2,3);
for ii = 1:9
    plot(ii,fit_metric{ii}.rsquare,'rs'); hold on;
    plot(ii,fit_metric{ii}.adjrsquare,'bo'); hold on;
    xlabel('Polynomial Order','FontSize',14); ylabel('R^2 value');
    legend({'R^2','R^2 Adjusted'})
end
hold off;

end
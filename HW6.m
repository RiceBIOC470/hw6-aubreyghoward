%HW6

%GB comments
1a 95 no axis labels
1b 100
1c 100
1d 100
1e 95 no axis lables
2a 100
2b 100
2c 100
Overall: 99

clear all
% Problem 1. Curve fitting. 
% Part 1. Take 10 x values on the interval 0 < x <= 10 and then create y
% values from the x values by plugging the x values into a third order
% polynomial of your choice. Add random noise to the data by choosing a 
% random number% in the interval [-D, D]. Start with D = 1. Plot your data 
% in the x-y plane.

figure (1); hold on;
D = 1;%Noise level selected at 1, as per the instructions.
numopts = 10;
xx = sort(rand(numopts,1)*10);
yy = -7*xx.^3+90*xx.^2+2*xx-7+((rand(numopts,1)-0.5)*D);
plot (xx,yy,'.','MarkerSize',10);
hold off;



% Part 2. Fit your data with polynomials from order 1 to 9. Plot the fitted
% polynomials together with the data. 
figure (2);
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

figure(3);
for ii = 1:9
    plot(ii,fit_metric{ii}.rsquare,'rs'); hold on;
    plot(ii,fit_metric{ii}.adjrsquare,'bo'); hold on;
    xlabel('Polynomial Order','FontSize',14); ylabel('R^2 value');
    legend({'R^2','R^2 Adjusted'})
end
hold off;



% Part 4. Repeat parts 1 - 3 for D = 10 and D = 1000. Comment on the
% results. 
%%
%Adam Howard:Steps 1-3 passed to the function called "makeRandFit" to 
%simply part 4.
clear all
numopts = 10;
xx = sort(rand(numopts,1)*10);
[fit_out,fit_metric] = makeRandFit(xx,1,4);
[fit_out1,fit_metric1] = makeRandFit(xx,10,5);
[fit_out2,fit_metric2] = makeRandFit(xx,1000,6);

%The difference caused by the nosie from almost no noise (1) to a ten fold
%increase in nosie was nearly undetecable. The fit function had almost no
%trouble fitting a third order regression to it. The 1000 noise level,
%however, significanly disrupted the ability to describe the regression
%accurately and could only be modeled (in my example) by an eight order
%regression. 


% Part 5. Now repeat parts 1-3 but take 100 x values on the interval 0 < x <=
% 10. Comment on the results. 
clear all
numopts = 100;
xx = sort(rand(numopts,1)*10);
[fit_out,fit_metric] = makeRandFit(xx,1,7);

%The fit function still correctly identifies the regression as a 3rd order
%fit. The major change is oberserved in the plot of the residuals. The
%adjusted residual value is now the same as the residual due to the
%increased sample size. 


%%
% Problem 2. Basic statistics. 
% Part 1. Consider two different distributions - Gaussian numbers with a mean of
% 0 and variance 1 and Gaussian numbers with a mean of 1 and variance 1.
clear all

% (1) Make a plot of the average p-value for the t-test comparing N random
% numbers chosen from each of these two distributions as a function of N.

for N = 2:50
    for ii = 1:100
    Gaus0 = randn(N,1);
    Gaus1 = randn(N,1)+1;
    [is_sig(ii), pval(ii)] = ttest2(Gaus0,Gaus1);
    end
    avgPval(N) = mean(pval);
end

figure(8); plot(1:50,avgPval,'b.')

%%
clear all

% Part 2. Now keep the first distribution the same, but vary the mean of
% the second distribution between 0 and 10 with the same variance and
% repeat part one. Make a plot of all of these different curves on the same
% set of axes. What is special about the case where the mean of the second
% distribution is 0? 

for N = 2:50
    for q = 1:11
        for ii = 1:100
        Gaus0 = randn(N,1);
        Gaus1 = randn(N,1)+(q-1);
        [is_sig(ii), pval(ii)] = ttest2(Gaus0,Gaus1);
        end
        avgPval(q,N) = mean(pval);
    end
    
end

figure(9);
lnclr = {'b-','g-','r-','c-','m-','y-','k-','k--','b--','r--'};
xx = [1:50]; 
for ii = 1:q
plot(xx,avgPval(ii,:))
hold on;
end
xlabel('number of samples');ylabel('pvalue');legend('mean Dif = 0','mean Dif = 1','mean Dif = 2','mean Dif = 3',...
    'mean Dif = 4','mean Dif = 5','mean Dif = 6','mean Dif = 7','mean Dif = 8','mean Dif = 9','mean Dif = 10');
disp('end q2 part 2')
%Adam: There is a special case when the means are the same shows that they
%do not trend towards becoming more different with an increased number of
%samples in the set. Under the other conditions with different means
%between the two sets, as sample size increases, so does likely hood that
%their means will be different. If the means are the same, however, this
%will never be true.
%%
% Part 3. Now keep the means of the two distributions at 0 and 1 as in part
% 1, but vary the variance of both distributions simultaneiously between 0.1 and 10 and plot the 
% p-values vs the number of numbers drawn as before. Comment on your results.  
clear all

for N = 2:100
    N
    for q = 1:100
        for ii = 1:100
        Gaus0 = (q/10).*randn(N,1);
        Gaus1 = 1+(q/10).*randn(N,1);
        [is_sig(ii), pval(ii)] = ttest2(Gaus0,Gaus1);
        end
        avgPval(q,N) = mean(pval);
    end
end

figure(10);
xx = [1:100]; 
for ii = 1:q
plot(xx,avgPval(ii,:))
hold on;
end
xlabel('number of samples');ylabel('pvalue');

%Adam Howard: The pvalues are the same for each analysis becasue the t-test
%only measures the difference between the means, but does not take into
%account the size of the variance within the data. So as we vary the data,
%no matter how widely, only



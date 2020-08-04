function plot_channels(Data,time, Labels, deltaV, title_fig)
[m,n] = size(Data);
tickY = zeros(1,m);
figure
for ii = 1:m
    plot(time,Data(ii,:) + (ii-1)*deltaV)
    tickY(ii) = (ii-1)*deltaV;
    hold on
end
yticks(tickY)
yticklabels(Labels)
ylabel(' # Channel [microV] ')
xlabel(' Time ')
title(title_fig, 'interpreter','none')
ylim([ -200 tickY(end) + 200])
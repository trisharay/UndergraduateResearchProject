function r = plot_lmp(label,ms,figNum)
figure(figNum)
cmap = colormap(parula(ms.nb));
x = (1:ms.nt)';
for i = 1:ms.nb
    y1 = ms.lamP(i,:)';
    r =plot(x, y1,'Color',cmap(i,:)); hold on;
end
xlabel('Time (hours)');
ylabel('$/MW');
title(label);
end
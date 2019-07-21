function y = plot_generation(label,md,ms,figNum)

%% default idx
% idx = find(any(md.UC.CommitKey == 0, 2) | any(md.UC.CommitKey == 1, 2));
% nidx = length(idx);
% if nidx > 1 && size(idx, 1) == 1
%     idx = idx';     %% convert row vector to column vector
% end
% b = md.mpc.gen(i, 1);

%% generator labels
%uc1 = md.UC.CommitSched(idx, :);
m = length(ms.Pg);
opt.rowlabels = cell(m, 1);
if isfield(md.mpc, 'genfuel')
    for i = 1:m
        opt.rowlabels{i} = sprintf('Gen %d @ Bus %d, %s', i, md.mpc.gen(i, 1), md.mpc.genfuel{i});
    end
else
    for i = 1:m
        opt.rowlabels{i} = sprintf('Gen %d @ Bus %d', i, md.mpc.gen(i, 1));
    end
end
hydro_idx = find(md.mpc.genfuel=="Hydro");
oil_idx = find(md.mpc.genfuel=="Oil");
coal_idx = find(md.mpc.genfuel=="Coal");
nuclear_idx = find(md.mpc.genfuel=="Nuclear");
ngas_idx = find(md.mpc.genfuel=="Ngas");
solar_idx = find(md.mpc.genfuel=="Solar");
%% Plot Generation
figure(figNum)
ax = axes('Position',[0.1300 0.1100 0.60 0.815]);
for j=1:length(ms.Pg)
    if(~isempty(find(hydro_idx==j)))
        y= plot(ax,1:ms.nt,ms.Pg(j,:)','--');
        hold on;
    elseif(~isempty(find(oil_idx==j)))
        y= plot(ax,1:ms.nt,ms.Pg(j,:)','-*');
        hold on;
    elseif(~isempty(find(coal_idx==j)))
        y= plot(ax,1:ms.nt,ms.Pg(j,:)','-.');
        hold on;
    elseif(~isempty(find(nuclear_idx==j)))
        y= plot(ax,1:ms.nt,ms.Pg(j,:)','-x');
        hold on;
    elseif(~isempty(find(ngas_idx==j)))
        y= plot(ax,1:ms.nt,ms.Pg(j,:)','->');
        hold on;
    elseif(~isempty(find(solar_idx==j)))
        y= plot(ax,1:ms.nt,ms.Pg(j,:)','-');
        hold on;
    else
        y= plot(ax,1:ms.nt,ms.Pg(j,:)','-o');
        hold on;
    end
end
label2 = strcat(label,' Generation (MW)');
title(label2);
h = legend(opt.rowlabels); 
set(h,'Position', [0.7 0.1100 0.15 0.815]);
end
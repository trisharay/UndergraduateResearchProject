function y = plot_load(label,md,ms,figNum)
%% Plot Load
figure(figNum)
for i=1:ms.nt    
    PgTot(i) = sum(ms.Pg(:,i));
end
y= plot(1:ms.nt,PgTot); hold on;
label1 = strcat(label,' Load Profile');
title(label1);
ylabel('Net Load (MW)');
xlabel('Period (hr)');

% %% default idx
% idx = find(any(md.UC.CommitKey == 0, 2) | any(md.UC.CommitKey == 1, 2));
% nidx = length(idx);
% if nidx > 1 && size(idx, 1) == 1
%     idx = idx';     %% convert row vector to column vector
% end
% b = md.mpc.gen(idx, 1);
% 
% %% generator labels
% uc1 = md.UC.CommitSched(idx, :);
% m = size(uc1, 1);
% opt.rowlabels = cell(m, 1);
% if isfield(md.mpc, 'genfuel')
%     for i = 1:m
%         opt.rowlabels{i} = sprintf('Gen %d @ Bus %d, %s', idx(i), b(i), md.mpc.genfuel{idx(i)});
%     end
% else
%     for i = 1:m
%         opt.rowlabels{i} = sprintf('Gen %d @ Bus %d', idx(i), b(i));
%     end
% end
% 
% %% Plot Generation
% figure(figNum)
% for j=1:length(ms.Pg)
%     plot(1:ms.nt,ms.Pg(j,:)');
%     hold on;
% end
% label2 = strcat(label,'Generation (MW)');
% title(label2);
% legend(opt.rowlabels);      
% end

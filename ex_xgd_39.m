function xgd_table = ex_xgd_39(mpc)
%EX_XGD_UC  Example xGenData table for stochastic unit commitment.

%   MOST
%   Copyright (c) 2015-2016, Power Systems Engineering Research Center (PSERC)
%   by Ray Zimmerman, PSERC Cornell
%
%   This file is part of MOST.
%   Covered by the 3-clause BSD License (see LICENSE file for details).
%   See http://www.pserc.cornell.edu/matpower/ for more info.

% initial xGenData
xgd_table.colnames = {
    'CommitKey', ...
        'CommitSched'...
            'MinUp'...
                'MinDown'...
                    'PositiveLoadFollowReservePrice', ...
                         'PositiveLoadFollowReserveQuantity', ...
                              'NegativeLoadFollowReservePrice', ...
                                   'NegativeLoadFollowReserveQuantity', ...
};
% xgd_table.colnames = {
%     'CommitKey', ...
%         'CommitSched'...
%             'MinUp'...
%                 'MinDown'...
% };
xgd_table.data = xlsread('mpc_39.xlsx','xgd');
% xgd = xlsread('mpc_39.xlsx','xgd');
% xgd_table.data = xgd(:,1:4);
% xgd_table.data = [
% 1	1;
% 1	1;
% 1	1;
% 1	1;
% 1	1;
% 1	1;
% 1	1;
% 1	1;
% 1	1;
% 1	1;
% 2	1;
% 1	1;
% 1	1;
% 1	1;
% 1	1;
% 1	1;
% 1	1;
% 1	1;
% 1	1;
% 1	1;
% 1	1;
% 1	1;
% 1	1;
% 1	1;
% 2	1;
% 1	1;
% 1	1;
% 1	1;
% 1	1;
% 1	1;
% 1	1;
% 1	1;
% ];

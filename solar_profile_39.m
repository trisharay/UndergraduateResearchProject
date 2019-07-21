function solarprofile = solar_profile_39
%EX_WIND_PROFILE_D  Example wind profile data for deterministic unit commitment.

%   MOST
%   Copyright (c) 2015-2016, Power Systems Engineering Research Center (PSERC)
%   by Ray Zimmerman, PSERC Cornell
%
%   This file is part of MOST.
%   Covered by the 3-clause BSD License (see LICENSE file for details).
%   See http://www.pserc.cornell.edu/matpower/ for more info.

%% define constants
[GEN_BUS, PG, QG, QMAX, QMIN, VG, MBASE, GEN_STATUS, PMAX, PMIN, ...
    MU_PMAX, MU_PMIN, MU_QMAX, MU_QMIN, PC1, PC2, QC1MIN, QC1MAX, ...
    QC2MIN, QC2MAX, RAMP_AGC, RAMP_10, RAMP_30, RAMP_Q, APF] = idx_gen;
[CT_LABEL, CT_PROB, CT_TABLE, CT_TBUS, CT_TGEN, CT_TBRCH, CT_TAREABUS, ...
    CT_TAREAGEN, CT_TAREABRCH, CT_ROW, CT_COL, CT_CHGTYPE, CT_REP, ...
    CT_REL, CT_ADD, CT_NEWVAL, CT_TLOAD, CT_TAREALOAD, CT_LOAD_ALL_PQ, ...
    CT_LOAD_FIX_PQ, CT_LOAD_DIS_PQ, CT_LOAD_ALL_P, CT_LOAD_FIX_P, ...
    CT_LOAD_DIS_P, CT_TGENCOST, CT_TAREAGENCOST, CT_MODCOST_F, ...
    CT_MODCOST_X] = idx_ct;

xls_solar = xlsread('mpc_39.xlsx','solar');

solarprofile = struct( ...
    'type', 'mpcData', ...
    'table', CT_TGEN, ...
    'rows', [1 2 3 4 5 6 7 8 9 10 11], ...
    'col', PMAX, ...
    'chgtype', CT_REL, ...
    'values', [] );

% for i=1:11
%     solarprofile.values(:, :, i) = [1;1;1;1;.5;.5;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0]; %xls_solar(40:63,2);
% end
solarprofile.values(:, :, 1) = xls_solar(40:63,2);
solarprofile.values(:, :, 2) = xls_solar(40:63,2);
solarprofile.values(:, :, 3) = xls_solar(40:63,3);
solarprofile.values(:, :, 4) = xls_solar(40:63,4);
solarprofile.values(:, :, 5) = xls_solar(40:63,5);
solarprofile.values(:, :, 6) = xls_solar(40:63,6);
solarprofile.values(:, :, 7) = xls_solar(40:63,6);
solarprofile.values(:, :, 8) = xls_solar(40:63,7);
solarprofile.values(:, :, 9) = xls_solar(40:63,8);
solarprofile.values(:, :, 10) = xls_solar(40:63,9);
solarprofile.values(:, :, 11) = xls_solar(40:63,9);

%plot(1:24,xls_solar(40:63,2));


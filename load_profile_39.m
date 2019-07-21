function loadprofile = load_profile_39
%   MOST
%   Copyright (c) 2015-2016, Power Systems Engineering Research Center (PSERC)
%   by Ray Zimmerman, PSERC Cornell
%
%   This file is part of MOST.
%   Covered by the 3-clause BSD License (see LICENSE file for details).
%   See http://www.pserc.cornell.edu/matpower/ for more info.

%% define constants
[CT_LABEL, CT_PROB, CT_TABLE, CT_TBUS, CT_TGEN, CT_TBRCH, CT_TAREABUS, ...
    CT_TAREAGEN, CT_TAREABRCH, CT_ROW, CT_COL, CT_CHGTYPE, CT_REP, ...
    CT_REL, CT_ADD, CT_NEWVAL, CT_TLOAD, CT_TAREALOAD, CT_LOAD_ALL_PQ, ...
    CT_LOAD_FIX_PQ, CT_LOAD_DIS_PQ, CT_LOAD_ALL_P, CT_LOAD_FIX_P, ...
    CT_LOAD_DIS_P, CT_TGENCOST, CT_TAREAGENCOST, CT_MODCOST_F, ...
    CT_MODCOST_X] = idx_ct;

loadprofile = struct( ...
    'type', 'mpcData', ...
    'table', CT_TLOAD, ... %per bus load change (see MATPOWER manual table)
    'rows', [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 18 19 20 21 22 23 24 25 26 27 28 29], ... % 0 means apply to all
    'col', CT_LOAD_ALL_PQ, ...
    'chgtype', CT_REL, ... %scale old value 
    'values', [] );
% loadprofile = struct( ...
%     'type', 'mpcData', ...
%     'table', CT_TLOAD, ... %per bus load change (see MATPOWER manual table)
%     'rows', [1 2 3 4 5], ... % 0 means apply to all
%     'col', CT_LOAD_ALL_PQ, ...
%     'chgtype', CT_REL, ... %scale old value 
%     'values', [] );

%% Read Load profile values from excel file
load_profile_xls = xlsread('mpc_39.xlsx','load_profile');

%% Distribution of buses to eight load zones
% CT = [6,7,8,9,10,11,12,20];
% ME = [27,28,29];
% SEMA = 22;
% VT= [1,2];
% NH=[25,26];
% NEMA=[16,21,23,24];
% WCMA= [3,4,5,13,14,15,18];
% RT = 19;
CT = [6,7,8,9,10,11,12,19];
ME = [26,27,28];
SEMA = 21;
VT= [1,2];
NH=[24,25];
NEMA=[16,20,22,23];
WCMA= [3,4,5,13,14,15,17];
RT = 18;


%% Assign profile to each load zone
for i=1:length(CT)
   loadprofile.values(:, 1, CT(i))= load_profile_xls(:,1);
end

for i=1:length(ME)
   loadprofile.values(:, 1, ME(i))= load_profile_xls(:,2);
end

loadprofile.values(:, 1, SEMA)= load_profile_xls(:,3);


for i=1:length(VT)
   loadprofile.values(:, 1, VT(i))= load_profile_xls(:,4);
end

for i=1:length(NH)
   loadprofile.values(:, 1, NH(i))= load_profile_xls(:,5);
end

for i=1:length(NEMA)
   loadprofile.values(:, 1, NEMA(i))= load_profile_xls(:,6);
end

for i=1:length(WCMA)
   loadprofile.values(:, 1, WCMA(i))= load_profile_xls(:,7);
end

loadprofile.values(:, 1, RT)= load_profile_xls(:,8);



% for i=1:length(loadprofile.rows)
%     loadprofile.values(:, 1, i) = [
%     0.65
%     0.63
%     0.65
%     0.63
%     0.63
%     0.61
%     0.62
%     0.64
%     0.69
%     0.75
%     0.80
%     0.84
%     0.90
%     0.92
%     0.94
%     0.97
%     0.99
%     1
%     0.97
%     0.95
%     0.92
%     0.86
%     0.76
%     0.69
%     ];
% end

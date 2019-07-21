%% Read Excel Files

%Read generation data
excelGen = xlsread('mpc_39.xlsx', 'gen');
[~,genFuel] = xlsread('mpc_39.xlsx', 'gen','B2:B33');
gen = excelGen(:,3:23);

%Read bus data
bus = xlsread('mpc_39.xlsx', 'bus');

%Read generation data
gencost = xlsread('mpc_39.xlsx','gencost');
gencost = gencost(1:30,2:7);

%Read reserve data (if running with contingencies)
% reserve = xlsread('mpc_39.xlsx','reserve');
% req = reserve(8:11,5);
% qty = reserve(8:40,1);
% zones = reserve(2:5,2:33);

%Default
mpopt = mpoption;

%% define named indices into data matrices
[PQ, PV, REF, NONE, BUS_I, BUS_TYPE, PD, QD, GS, BS, BUS_AREA, VM, ...
     VA, BASE_KV, ZONE, VMAX, VMIN, LAM_P, LAM_Q, MU_VMAX, MU_VMIN] = idx_bus;
 [GEN_BUS, PG, QG, QMAX, QMIN, VG, MBASE, GEN_STATUS, PMAX, PMIN, ...
     MU_PMAX, MU_PMIN, MU_QMAX, MU_QMIN, PC1, PC2, QC1MIN, QC1MAX, ...
     QC2MIN, QC2MAX, RAMP_AGC, RAMP_10, RAMP_30, RAMP_Q, APF] = idx_gen;
 [F_BUS, T_BUS, BR_R, BR_X, BR_B, RATE_A, RATE_B, RATE_C, ...
     TAP, SHIFT, BR_STATUS, PF, QF, PT, QT, MU_SF, MU_ST, ...
     ANGMIN, ANGMAX, MU_ANGMIN, MU_ANGMAX] = idx_brch;
 [PW_LINEAR, POLYNOMIAL, MODEL, STARTUP, SHUTDOWN, NCOST, COST] = idx_cost;
 [CT_LABEL, CT_PROB, CT_TABLE, CT_TBUS, CT_TGEN, CT_TBRCH, CT_TAREABUS, ...
     CT_TAREAGEN, CT_TAREABRCH, CT_ROW, CT_COL, CT_CHGTYPE, CT_REP, ...
     CT_REL, CT_ADD, CT_NEWVAL, CT_TLOAD, CT_TAREALOAD, CT_LOAD_ALL_PQ, ...
     CT_LOAD_FIX_PQ, CT_LOAD_DIS_PQ, CT_LOAD_ALL_P, CT_LOAD_FIX_P, ...
     CT_LOAD_DIS_P, CT_TGENCOST, CT_TAREAGENCOST, CT_MODCOST_F, ...
     CT_MODCOST_X] = idx_ct;
 
%% load base case file
mpc = loadcase('case39a');
mpc.gen=gen;
mpc.bus=bus;
mpc.gencost=gencost;
mpc.genfuel=genFuel;

%% Zonal Reserve Data
% mpc.reserves.zones=zones;
% mpc.reserves.req=[500;500;500;500];
% % mpc.reserves.req=req;
% mpc.reserves.cost=zeros(32,1);
%mpc.reserves.qty =qty;
%runpf(mpc);

%% Determine Size
nb = size(mpc.bus, 1);
nl = size(mpc.branch, 1);
ng = size(mpc.gen, 1);

%% Load xgd and profiles
xgd = loadxgendata('ex_xgd_39', mpc);
[solar, mpc, xgd] = addwind('solar_39', mpc, xgd); %addwind used for solar
mpc.genfuel(31:41)={'Solar'}; %change genfuel from wind to solar
[iwind, mpc, xgd] = addwind('wind_39', mpc, xgd);
profiles = getprofiles('solar_profile_39');
profiles = getprofiles('solar_profile_39', solar);
profiles = getprofiles('wind_profile_39', profiles, iwind);
profiles = getprofiles('load_profile_39', profiles);
nt = size(profiles(2).values, 1);

%% Uncomment for case without solar or wind
%profiles = getprofiles('load_profile_39');
%nt = size(profiles.values, 1);

%% Full mpc and xgd
mpc_full = mpc;
xgd_full = xgd;

%% Remove constraints 
mpc.gencost(:, [STARTUP SHUTDOWN]) = 0; % remove startup/shutdown costs
xgd.MinUp(:) = 1;                       % remove min up-time constraint
xgd.MinDown(:) = 1;                       % remove min down-time constraint
xgd.PositiveLoadFollowReserveQuantity(:) = 1000;
xgd.NegativeLoadFollowReserveQuantity(:) = 1000;% remove ramp reserve
xgd.PositiveLoadFollowReservePrice(:) = 1e-6;   % constraint and costs
xgd.NegativeLoadFollowReservePrice(:) = 1e-6;
mpc0 = mpc;
xgd0 = xgd;
figNum =1;

%% Base
mpopt = mpoption(mpopt, 'most.solver', mpopt.opf.dc.solver);
mpopt = mpoption(mpopt,  'most.storage.cyclic', 1);
 
t = sprintf('base (econ disp, no network)');
mpc = mpc0;
xgd = xgd0;
mpopt = mpoption(mpopt, 'most.dc_model', 0);
mdi = loadmd(mpc, nt, xgd, [], [], profiles);
%mdi = loadmd(mpc,[],xgd);
mdo = most(mdi, mpopt);
ms = most_summary(mdo);

%%----Plot Load--------
load = plot_load('24 Hour',mdo,ms,figNum);
saveas(load, '\Users\trisharay\Documents\Research\Images\plotLoad.png','png');
figNum = figNum+1;

%----Plot Results------
figure(figNum);
ED12 = plot_uc(mdo, [], 'title', 'Base : No Network');
saveas(ED12, '\Users\trisharay\Documents\Research\Images\ED12.png','png');
figNum = figNum+1;
plot_generation('Base : No Network',mdo,ms,figNum);
figNum = figNum+1;
ED12_all = plot_lmp('Base : No Network',ms,figNum);
saveas(ED12_all, '\Users\trisharay\Documents\Research\Images\ED12_lmp.png','png');
%% DC OPF Constraints
figNum = figNum+1;
figure(figNum)
t = sprintf('DC OPF constraints');
%mpc = mpc0;
% mpc.gen(iwind, PMAX) = 50;
mpopt = mpoption(mpopt, 'most.dc_model', 1);
mdi = loadmd(mpc, nt, xgd, [], [], profiles);
%mdi = loadmd(mpc, nt, xgd, [], []);
mdo = most(mdi, mpopt);
ms = most_summary(mdo);

%----Plot Results------
DC12 = plot_uc(mdo, [], 'title', '+ DC Network');
saveas(DC12, '\Users\trisharay\Documents\Research\Images\AddDC12.png','png');
figNum = figNum+1;
plot_generation('+ DC Network',mdo,ms,figNum);
figNum = figNum+1;
DC12_all = plot_lmp('+ DC Network',ms,figNum);
saveas(DC12_all, '\Users\trisharay\Documents\Research\Images\AddDC12_lmp.png','png');
%% Add startup/shutdown costs
figNum = figNum+1;
figure(figNum)
t = sprintf('startup/shutdown costs : ');
if mpopt.out.all
    fprintf('Add STARTUP and SHUTDOWN costs\n');
end
mpc = mpc_full;
mdi = loadmd(mpc, nt, xgd, [], [], profiles);
mdo = most(mdi, mpopt);
ms = most_summary(mdo);

%----Plot Results------
AddStart12 = plot_uc(mdo, [], 'title', '+ Startup/Shutdown Costs');
saveas(AddStart12, '\Users\trisharay\Documents\Research\Images\AddStart12.png','png');
figNum = figNum+1;
plot_generation('+ Startup/Shutdown Costs',mdo,ms,figNum);
figNum = figNum+1;
AddStart12_all = plot_lmp('+ Startup/Shutdown Costs',ms,figNum);
saveas(AddStart12_all, '\Users\trisharay\Documents\Research\Images\AddStart12_lmp.png','png');
%% + min up/down time constraints
figNum = figNum +1;
figure(figNum)
t = sprintf('+ min up/down time constraints : ');
if mpopt.out.all
     fprintf('Add MinUp time\n');
end
xgd=xgd_full;
xgd.PositiveLoadFollowReserveQuantity(:) = 1000;
xgd.NegativeLoadFollowReserveQuantity(:) = 1000;% remove ramp reserve
xgd.PositiveLoadFollowReservePrice(:) = 1e-6;   % constraint and costs
xgd.NegativeLoadFollowReservePrice(:) = 1e-6;
mdi = loadmd(mpc, nt, xgd, [], [], profiles);
mdo = most(mdi, mpopt);
ms = most_summary(mdo);

%----Plot Results------
AddMin12 = plot_uc(mdo, [], 'title', '+ Min Up/Down Time Constraints');
saveas(AddMin12, '\Users\trisharay\Documents\Research\Images\AddMin12.png','png');
figNum = figNum+1;
plot_generation('+ Min Up/Down Time Constraints',mdo,ms,figNum);
figNum = figNum+1;
AddMin12_all = plot_lmp('+ Min Up/Down Time Constraints',ms,figNum);
saveas(AddMin12_all, '\Users\trisharay\Documents\Research\Images\AddMin12_lmp.png','png');
%% + ramp constraint/ramp res cost
figNum = figNum +1;
figure(figNum)
t = sprintf('+ ramp constraint/ramp res cost');
if mpopt.out.all
      fprintf('Restrict ramping and add ramp reserve costs\n');
end
xgd = xgd_full;
mdi = loadmd(mpc, nt, xgd, [], [], profiles);
mdo = most(mdi, mpopt);
ms = most_summary(mdo);

%----Plot Results------
AddRamp12 = plot_uc(mdo, [], 'title', '+ Ramping Constraints/Ramp Reserve Costs');
saveas(AddRamp12, '\Users\trisharay\Documents\Research\Images\AddRamp12.png','png');
figNum = figNum+1;
plot_generation('+ Ramping Constraints/Ramp Reserve Costs',mdo,ms,figNum);
figNum = figNum+1;
AddRamp12_all = plot_lmp('+ Ramping Constraints/Ramp Reserve Costs',ms,figNum);
saveas(AddRamp12_all, '\Users\trisharay\Documents\Research\Images\AddRamp12_lmp.png','png');

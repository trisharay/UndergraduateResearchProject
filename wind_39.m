function wind = wind_39(mpc)
%EX_WIND_UC  Example Wind data file for stochastic unit commitment.

%   MOST
%   Copyright (c) 2015-2016, Power Systems Engineering Research Center (PSERC)
%   by Ray Zimmerman, PSERC Cornell
%
%   This file is part of MOST.
%   Covered by the 3-clause BSD License (see LICENSE file for details).
%   See http://www.pserc.cornell.edu/matpower/ for more info.

xls_wind = xlsread('mpc_39.xlsx','wind');

%%-----  wind  -----
%% generator data
%	bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
wind.gen = xls_wind(1:9,:);
    
wind.gencost = xls_wind(23:31,1:6);
%% xGenData
wind.xgd_table.colnames = {
	'CommitKey', ...
		'CommitSched'...
            'MinUp'...
                'MinDown'...
                    'PositiveLoadFollowReservePrice', ...
                             'PositiveLoadFollowReserveQuantity', ...
                                  'NegativeLoadFollowReservePrice', ...
                                       'NegativeLoadFollowReserveQuantity', ...
					
};

wind.xgd_table.data = xls_wind(12:20,1:8);

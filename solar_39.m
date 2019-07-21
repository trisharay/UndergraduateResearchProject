function solar = solar_39(mpc)

xls_solar = xlsread('mpc_39.xlsx','solar');

%%-----  solar  -----
%% generator data
%	bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
solar.gen = xls_solar(1:11,:);

solar.gencost = xls_solar(27:37,1:6);
%% xGenData

solar.xgd_table.colnames = {
	'CommitKey', ...
		'CommitSched'...
            'MinUp'...
                'MinDown'...
                    'PositiveLoadFollowReservePrice', ...
                             'PositiveLoadFollowReserveQuantity', ...
                                  'NegativeLoadFollowReservePrice', ...
                                       'NegativeLoadFollowReserveQuantity', ...
					
};

solar.xgd_table.data = xls_solar(14:24,1:8);

end
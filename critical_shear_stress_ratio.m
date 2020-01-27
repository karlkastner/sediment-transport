% Sat Feb 14 15:50:12 CET 2015
% 2016-03-16 14:05:54.243257026 +0100
% Fr 25. Sep 14:52:02 CEST 2015
% Karl Kastner, Berlin
%
%% critical shields parameter
%% aka critical shear stress ratio
%% aka shields curve
%
% d in mm
% Note: wilcok uses in his lecture notes the "dimensionless viscosity"
function theta = critical_shear_stress_ratio(d_mm,mode)
	% mm to m
	d = 1e-3*d_mm;
	if (nargin() < 2 || isempty(mode))
		mode = 'soulsby';
	end
	switch (lower(mode))
	case {'soulsby'} % soulsby 1997, miedema 2010
		dstar  = dimensionless_grain_size(d_mm);
		theta = 0.3./(1+1.2*dstar) + 0.055*(1-exp(-0.02*dstar));
	case {'brownlie-bonneville'}
		% Miedema 2010
		% Note: Brownlie (1981) uses the power 10, e^-17.73 = 10^7.7
		dstar  = dimensionless_grain_size(d_mm)
		theta = 0.22*dstar.^(-0.9)+0.06*exp(-17.77*dstar.^(-0.9));
	case {'brownlie'}
		% brownlie 1981, eq. 6.3 p. 161.
		% garcia 2000
		rhos  = Constant.density.quartz;
		rhow  = Constant.density.water;
		% particle Reynolds number
		Rg    = sqrt(Constant.g*d.^3)/Constant.viscosity.kinematic.water;
		Y     = ( sqrt(rhos/rhow-1)*Rg).^(-0.6);
		theta = 0.22*Y  + 0.06*exp(-7.7*Y);
	case {'julien'} 
		ds     = dimensionless_grain_size(d_mm);
		theta = 0.24./ds + 0.055*(1-exp(-0.020*ds));
	case {'rijn'}
		% Rijn, 1984
		% D_* : non-dimensional particle diameter
		d
		ds     = dimensionless_grain_size(d_mm)
        	theta = ...
	          (ds >= 150)*0.055 ...
		        + (ds <  150).*( ...
		              (ds >=  20).*(0.013*ds.^0.29) ...
		            + (ds <   20).*( ...
		                  (ds >=  10).*(0.04*ds.^-0.1) ...
		                + (ds <   10).*( ...
		                      (ds >=   4).*(0.14*ds.^-0.64) ...
		                    + (ds <    4).*(0.24*ds.^-1.0) ...
		                                ) ...
					    ) ...
					);
	otherwise
		error('undefined');
	end % switch
end % critical shear stress


% Tue 16 Jun 13:17:14 +08 2020
% function c = vertical_ssc_profile_constant_viscosity(us,ws,z,h)
% corresponding to constant eddy viscosity
function c = vertical_ssc_profile_exponential(c0,us,ws,z,h)
	if (issym(z))
		syms k;
	else
		k = Constant.Karman;
	end
	c = c0*exp(-(6*ws*z)./(h*k*us));
end


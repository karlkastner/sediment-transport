% Tue 16 Jun 13:29:30 +08 2020
% function T = settling_time_constant_eddy_viscosity(ws,us,h)
function T = settling_time_constant_eddy_viscosity(ws,us,h)
	k = 0.41;
% depth averaged
	%nu_t = 
	%T = -(h./ws.^2.*(ws.*6.0 + k.*us - k.*us.*exp((ws.*6.0)./(k.*us)))./6.0)./(exp((ws.*6.0)./(k.*us))-1.0);
	% a indicates an average position in the water column
	a = k/6*us./ws;
	T = h./ws.*(1./(1 - exp(1./a))+a)
if (0)
	% approximation, at the 1/exp term is essentially zero 
	T = a*h./ws
end
% flux averaged with log profile
if (0)
	T = (ws.*((1.0./ws.^3.*(c0.*h.^2.*k.*us.^3.*ei((ws.*z0.*-6.0)./(h.*k.*us))-c0.*h.^2.*k.*us.^3.*exp((ws.*z0.*-6.0)./(h.*k.*us))))./3.6e+1+(c0.*h.^2.*us.^2.*1.0./ws.^3.*exp((ws.*-6.0)./(k.*us)).*(k.*us+ws.*log(h).*6.0-ws.*log(z0).*6.0+k.*us.*log(h)-k.*us.*log(z0)-k.*us.*exp((ws.*6.0)./(k.*us)).*ei((ws.*-6.0)./(k.*us))))./3.6e+1).*1.2e+1)./(c0.*h.*us.^2.*log(ws.*6.0).*2.0-c0.*h.*us.^2.*log(ws.*3.6e+1)+c0.*h.*us.^2.*pi.*2.0i-c0.*h.*us.^2.*ei((ws.*-6.0)./(k.*us)).*2.0-c0.*h.*us.^2.*log(ws)+c0.*h.*us.^2.*ei((ws.*z0.*-6.0)./(h.*k.*us)).*2.0+c0.*h.*us.^2.*exp((ws.*-6.0)./(k.*us)).*log(h).*2.0-c0.*h.*us.^2.*exp((ws.*-6.0)./(k.*us)).*log(z0).*2.0);
end
end


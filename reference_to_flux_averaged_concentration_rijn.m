% Wed 10 May 09:42:56 CEST 2017
function F = reference_to_flux_averaged_concentration(a_d,zt)
	% 12. eq. 44 F-factor
	% note, series expansion for zt->0 as proposed by
	% van rijn seems not necessary
	F = ((a_d).^zt - (a_d).^1.2)./((1-a_d).^zt.*(1.2 - zt));
end


% Mon 11 May 15:32:40 +08 2020
% function [Qs,Y] = sediment_load_ART_syvitski_2003(A,R,T)
function [Qs_kg_s, yield_kg_m2_s] = sediment_load_ART_syvitski_2003(A_m2,R_m,T_C)
	alpha = 2e-5;                                                               
	k     = 0.1331;

	% note the conversion to km^2, p6. Syvitsky 2003
	A_km2 = A_m2 / 1e6;	

	Qs_kg_s       = alpha*R_m.^(1.5).*A_km2.^(0.5).*exp(k*T_C);
	yield_kg_m2_s = Qs_kg_s./A_m2;                                     
end


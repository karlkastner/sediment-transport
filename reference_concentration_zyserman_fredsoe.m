% Sun 21 Jun 14:42:27 +08 2020
function cb = reference_concentration_zyserman_fredsoe(U,h,Cz,d_mm,theta_c)
	if (nargin()<5)
		theta_c = 0.045;
	end
	ks = grain_roughness_nikuradse(d_mm);
	Cz_f = z02chezy(ks2z0(ks),h);

	% determine skin friction
	S = U./(Cz.*sqrt(h));
	Dt = zeros(size(U));
	g = 9.81;
	for idx=1:length(U)
		Dt(idx) = lsqnonlin(@(Dt) U(idx) - sqrt(g*Dt.*S(idx)).*(6 + 2.5*log(Dt./ks)),0.1*h(idx),0);
	end
	Usf = sqrt(g*Dt.*S);
	Uf  = Cz_f.*sqrt(Dt.*S);

	theta   = shields_number(Cz_f,Uf,d_mm);
	cb = 0.331*(theta - theta_c).^(1/75) ...
                ./ ( 1 + 0.720*(theta - theta_c).^(1.75)); 
end


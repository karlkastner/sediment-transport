% Sun 21 Jun 14:37:34 +08 2020
function cb     = reference_concentration_einstein(U,Cz,d_mm,theta_c)
	theta   = shields_number(Cz,U,d_mm);
	if (nargin()<4)
		theta_c = 0.047;
	end
	us      = shear_velocity(Cz,U);
	qbs     = 8*(theta - theta_c).^(3/2);
	delta   = 2*d_mm;
	cb      = 1/11.6*qbs./(delta*us);
end


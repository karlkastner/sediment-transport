% Fri  9 Mar 10:40:28 CET 2018
%% adaptatoion lenght of bed morphology
function lambda_s = adaptation_length_bed(C,W,H,U,d50_mm,rhos,rhow)
	if (nargin()<6)
		rhos = Constant.density.quartz;
	end
	if (nargin()<7)
		rhow = Constant.density.water;
	end
	if (~issym(C))
		Pi = pi;
	else
		syms Pi
	end

	fs  = 1.5;
	d50 = d50_mm*1e-3;
	
	theta    = U^2/(C^2*(rhos-rhow)/rhow*d50)
	lambda_s = 1/Pi^2*(W/H)^2*fs*theta.^0.5*H;
end

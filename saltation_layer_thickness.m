% Mon 13 May 13:29:48 CEST 2019
% wiberg 1987
% wiberg 1989
% bennet 1995
function delta = saltation_layer_thickness()
	a1    = 15;  % 10..19
	a2    = 2.5; % 0.5 .. 4.5 
	% 1987 taust = tau0t/(gamma*(rhos/rhow-1)*d50)
	% tua0t : grain shear stress
	taust = taut0/taucr;
	delta = d50*a1*taust/(1+a2*taust);
	delta < 5 d50 (somewhat smaller than van rhine)
end

function suspended_load_mclean()
	% int_a^h c*u dz
	% (13, bennet-1995)
-> rouse should be calculated from total shear stress
	ca = reference_concentration_mclean()
	% concentration profile 12 in bennet
	% TODO schmidt number missing
	c = ca*( (h-z)/z*1/(h-a))^ws/(kappa*us)
-> has to be evaluated numerically
	-> gauss?

end

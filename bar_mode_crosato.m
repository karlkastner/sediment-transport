% Mon 19 Mar 15:34:25 CET 2018
% Karl Kastner, Berlin
%% bar mode of a river according to crosato
function [m] = bar_mode_crosato(Q,W,H,C,d50_mm)
	beta = W/H;
	g    = Constant.gravity;
	d_50 = 1e-3*d50_mm;
	rho_s = Constant.density.quartz;
	rho_w = Constant.density.water;

	U = Q/(W*H);
	S = U^2/(C^2*H);

	b = 5; % eh, crossato used 4 for sand and 10 for gravel
%	b = 4;
	m = sqrt(    (0.17*g*(b-3)*W^3*S) ...
                   / (sqrt((rho_s-rho_w)*d_50)*C*Q) ...
                );
end % bar_mode_crosato

	 
 

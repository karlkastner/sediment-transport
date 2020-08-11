% Tue 10 Dec 16:51:37 +08 2019
% qsb_m : bed load mass transport per unit with
%     c : celerity
% dh    : dune height (crest to trough)
function c = dune_celerity(qsb_m,dh)
	rho_s = Constant.density.quartz;
	% packing density
	p = Constant.packing_density.spheres;
	% volumetric transport
	qsb_vol = qsb_m/rho_s;
	% 2 is for triangular dune shape
	% area = 1/2 dh l
	% h_bar = a/l = 1/2 dh
	dh_bar = 0.5 * dh;
	c = (qsb_vol/p)./dh_bar;
end



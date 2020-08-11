% 2020-06-20 00:52:23.195494008 +0800 adaptation_length_armanini.m
function [L] = adataptation_length_armanini(h,C,U,ws)
	g = 9.81;
	kappa = 0.41;
	us = shear_velocity(C,U)
	a = 33*h.*exp(-(1+kappa*C/sqrt(g)))
	%a=1/6*h
	-1.5*(a./h).^(-1/6).*ws./us
	L = h.*U./ws.*( a./h + (1-a./h).*exp(-1.5*(a./h).^(-1/6).*ws./us))

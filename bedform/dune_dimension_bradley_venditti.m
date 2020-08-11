% Thu 30 Jul 14:30:59 +08 2020
% Ts = tau / tau_c
% h : depth
% function [H,L] = dune_dimenision_bradley_venditty(Ts,h)
function [H,L] = dune_dimenision_bradley_venditty(Ts,h,year)
if (nargin()<3)
	year = 2019;
end
switch (year)
case {2019}
        a_H = -0.0014                            
	b_H =  16;
	c_H =  0.42;
	a_L =  0.031;                               
        b_L =  9.6;
	c_L =  5.7;
case {2018}
	a_H =  -0.0010
	b_H =  17.69;
	c_H =   0.4169;
	a_L = 0.0192;
	b_L = 8.459;
	c_L = 6.226;
end
	H = h*(a_H*(Ts - b_H).^2 + c_H); 
	L = h*(a_L*(Ts - b_L).^2 + c_L);    
	H = max(H,0);
	L = max(L,L);
end                                        

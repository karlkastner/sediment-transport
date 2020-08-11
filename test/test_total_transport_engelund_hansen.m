clear
C = 60;
d50_mm = 1;
u = 2;
H = 12;
W = 1;
a = 1
g = 9.81;
d50_m = 1e-3*d50_mm;

Delta = 1.65

Qs(1) = 0.05*a*u^5/(sqrt(g)*C^3*Delta^2*d50_m) 
Qs(2) = 1/2650*total_transport_engelund_hansen(C,d50_mm,u,H,W) %,rho_s,rho_w)

if (diff(Qs).^2 < eps*mean(Qs))
	'passed'
else
	'failed'
end

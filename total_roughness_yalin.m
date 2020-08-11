% Thu 30 Jul 11:55:23 +08 2020
% function Cz = total_roughness_yalin(H,L,h,d_mm)
function Cz = total_roughness_yalin(H,L,h,d_mm)
	D   = 1e-3*d_mm;
	g = 9.81;
	% 1.27,1.30 in yalin                                                            
	ks  = 2*D;                                                                       
	cf  = 2.5*log(11*h./ks);      
	% 1.38, 3.30, 3.91                                                    
	c   = 1./sqrt(1./cf.^2 + 1/2*(H./L).^2.*L./h);                                       
	Cz  = c*sqrt(g) 
end


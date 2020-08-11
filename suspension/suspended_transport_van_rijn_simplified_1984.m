function (u,h,w,d50,d90,T_C);
% c.f. rijn 1993, eq 7.3.46
% 	qs = u*h*((u - uc)./sqrt((s-1)*g*d50))^2.4*(d50/h)*(1/ds)^0.6;
% cancellation of H :
 	qs = u*((u - uc)./sqrt((s-1)*g*d50))^2.4*d50*(1/ds)^0.6;
	Qs = w*qs;

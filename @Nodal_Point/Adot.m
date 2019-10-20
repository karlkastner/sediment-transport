% Tue  6 Mar 15:34:12 CET 2018
%% ODE of the nodal point relation (time-derivative of branch cs-area)
%
% zb wing 1995
%
% BC:
% Q0, Qs0
% zs1_down, zs2_down (assumed zero)
%
% not that zs is determined by a quartic polynomial
function [Adot] = Adot(obj,t,A)
	% surface elevation at the bifurcation
	% continuity of discharge
%	fq = (C1*L2^(1/2)*w1*(zb1 - zs)^(3/2))/(C1*L2^(1/2)*w1*(zb1 - zs)^(3/2) + C2*L1^(1/2)*w2*(zb2 - zs)^(3/2))
%	h = max(h,0);
	% depth in channels
	% h = zs-zb;
	% discharge into branches
	% Q = C.*w.*h.*sqrt(h.*zs./L);

	[h,w,R] = obj.geometry(A)

	%h      = rvec(h);

	Q      = obj.discharge(h,w,R);
	Qs_in  = obj.Qs_in(Q,w);
	Qs_out = obj.Qs_out(Q,h,w);

	if (~issym(h))
		Adot = 1/obj.packing_density*bsxfun(@times,1./(obj.L),(Qs_out - Qs_in));
		%hdot = 1/(1-s)*bsxfun(@times,1./(obj.w.*obj.L),(Qs_out - Qs_in));
	else
		Adot = 1/obj.packing_density*1./(obj.L).*(Qs_out - Qs_in);
		%hdot = 1/(1-s)*1./(obj.w.*obj.L).*(Qs_out - Qs_in);
	end

	if (isnumeric(h))
		Adot(A<0) = NaN;
	end

	%Adot = Adot.';

%	[w h Q/1e3 Qsin Qsout Qsin-Qsout, (Qsin-Qsout)./w]
%	hdot
%	pause
end


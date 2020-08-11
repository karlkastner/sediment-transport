% Wed  7 Mar 18:38:57 CET 2018
%% discharge through branches
%% there is a problem with this relation, as soon as the bed of one channel is perturbed,
%% the water level at the bifurcation changes, so the depth of the second channel is not
%% entirely independent
% syms C L W Q0 zs zb1 zb2 w1 w2; solve(C*w1*sqrt(zs/L)*(zs-zb1).^1.5 + C*w2*sqrt(zs/L)*(zs-zb2).^1.5 - Q0,zs)
function [Q,fq] = discharge(obj, h, w, R)
	% ratio of flow capacities
	% TODO make roughness an optional function
	fq =    ( obj.C(1,:)*w(1,:).*h(1,:).*sqrt(R(1,:)/obj.L(1,:)) ) ...
	     ./ ( obj.C(2,:)*w(2,:).*h(2,:).*sqrt(R(2,:)/obj.L(2,:)) );

	%fq = (C1*w1*(zb1 - zs)*(-((zb1 - zs))/L1)^(1/2))/(C2*w2*(zb2 - zs)*(-((zb2 - zs))/L2)^(1/2));
	%fq = (C1*w1*(zb1 - zs)*(-(zs*(zb1 - zs))/L1)^(1/2))/(C2*w2*(zb2 - zs)*(-(zs*(zb2 - zs))/L2)^(1/2));
	if (~issym(h))
		Q  = bsxfun(@times,obj.Q0./(1+fq),[fq;ones(size(fq))]);
	else
		Q  = obj.Q0./(1+fq).*[fq;ones(size(fq))];
	end
end


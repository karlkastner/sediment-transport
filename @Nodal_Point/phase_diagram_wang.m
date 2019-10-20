% 2018-03-07 15:34:20.367229092 +0100
%% phase diagram of Nodal point relation
function [h,dh,HH] = phase_diagram_wang(hmax,Q0,Qs0,w,L,C,k,a,b,n)
%	n = 20;
	h = (1:n)'*hmax/n;
	dh = zeros(n,n,2);
	for idx=1:length(h)
	for jdx=1:length(h)
		h_ = [h(idx);h(jdx)];
		dh(idx,jdx,:) = nodal_point_wang(0,h_,Q0,Qs0,w,L,C,k,a,b);
	end
	end
	HH = repmat(h,1,n);
end


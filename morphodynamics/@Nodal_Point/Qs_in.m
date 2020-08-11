% Wed  7 Mar 18:38:57 CET 2018
%% sediment entering branches
%
%function [Qsin, fs] = Qs_in(obj, Q, w)
function [Qsin, fs] = Qs_in(obj, Q, w)
	if (obj.kfixed)
		k = obj.k;
	else
		p = obj.k;
		k = 1 + 2*abs(Q(1,:)-Q(2,:)).^p/abs(Q(1,:)+Q(2,:)).^p;
		%k = (Q(:,1)./Q(:,2))
	end

	% discharge to sediment division factor
	%fs = (fq).^k.*(w(1)/w(2)).^(1-k);
	fs = (Q(1,:)./Q(2,:)).^k.*(w(1,:)./w(2,:)).^(1-k);
%	syms fs
	%f = (Q(1)/Q(2)).^k;
	
	% sediment entering branches
	% (continuity of sediment tranport)
	if (~issym(Q))
		Qsin = bsxfun(@times,obj.Qs0./(1+fs),[fs;ones(size(fs))]);
	else
		Qsin = obj.Qs0./(1+fs).*[fs;ones(size(fs))];
	end
end


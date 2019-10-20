% Fri 12 May 11:34:37 CEST 2017
%% fractional sediment transport according to engelund and hansen
% function [Qs_i Qs] = fractional_transport_engelund_hansen(p,C,d_mm,U,H,W)
function [Qs_i Qs] = fractional_transport_engelund_hansen(p,C,d_mm,U,H,W)
	d_mm = rvec(d_mm);
	nd  = length(d_mm);
	m = 1;
	if (~isscalar(C))
		m = max(m,length(C));
		C = cvec(C)*ones(1,nd);
	end
	if (~isscalar(U))
		m = max(m,length(U));
		U = cvec(U)*ones(1,nd);
	end
	if (~isscalar(H))
		m = max(m,length(H));
		H = cvec(H)*ones(1,nd);
	end
	if (~isscalar(W))
		m = max(m,length(W));
		W = cvec(W)*ones(1,nd);
	end
	d_mm = repmat(d_mm,m,1);
	% potential transport per fraction
	[Qs_i_pot] = total_transport_engelund_hansen(C,d_mm,U,H,W);
	% normalise (to make sure that the pdf is a pdf)
	p    = p/sum(p);
	% transport per fraction
	Qs_i = bsxfun(@times,Qs_i_pot,rvec(p));
	% transport summed over all fractions
	Qs = sum(Qs_i);
end



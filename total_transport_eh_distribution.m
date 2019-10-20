% Fri 23 Mar 15:48:25 CET 2018
%% total sediment transport according to engelund hansen
%% for a given graqin size distribution
function [Qs_m] = total_transport_engelund_hansen_distribution(C,phi,U,H,W,varargin)
	% TODO, this function fails when distribution is too narrow
	Dmin = 1e-2;
	Dmax = 1e2;
	
	Qs_m = integral(@(logD)  exp(logD).*phi(exp(logD)).*double(total_transport_engelund_hansen(C,exp(logD),U,H,W,varargin{:})), log(Dmin), log(Dmax));
%	Qs_m = integral(@phiQs,Dmin,Dmax)

	function y = phiQs(D)
		phi_ = phi(D);
		if (isrow(D))
			phi_ = rvec(phi_);
		end
		Qs = total_transport_engelund_hansen(C,D,U,H,W,varargin{:});
		y = phi_.*Qs;
		y = double(y);
	end
end


% Wed  7 Mar 18:38:57 CET 2018
%% sediment leaving branches
% TODO use EH
function [Qsout, fs] = Qs_out(obj, Q, h, w)
	if (~issym(h))
		A     = bsxfun(@times,h,w);
	else
		A = h.*w;
	end
	U     = (Q./A);
	if (~issym(Q))
		switch (obj.transport.relation)
		case {'power'}
			Qsout = obj.transport.m*bsxfun(@times,w,U.^obj.transport.n);
		case {'eh'}
			u = Q./(h.*w);
			Qs_m   = total_transport_engelund_hansen(obj.C,obj.transport.d_mm,u,h,w);
			Qsout = Qs_m/2650;
		case {'vanRijn'}
			u = Q./(h.*w);
			Qs_m = total_transport_rijn(obj.C,obj.transport.d50,obj.transport.d90,[],u,h,w);
			Qsout = Qs_m/2650;
		end
	else
		% power law
		Qsout = obj.transport.m*w.*U.^obj.transport.n;
	end
end % function Qs_out


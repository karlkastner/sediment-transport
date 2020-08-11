% Thu  8 Mar 12:04:32 CET 2018
%% staility analysis for a given configuration
function [obj] = stability_analysis(obj, hc, wc)
	Ac = hc.*wc;
	for idx=1:size(hc,1)
		fprintf('%d\n',idx);
		% TODO, analytic
		J = hessian_from_gradient(@(A) obj.Adot([],A),Ac(idx,:))
		% test, must be zero when not rounded
		g = obj.Adot([],Ac(idx,:))
		dh = J \ g
		E = eig(J)
		T = -1./(E*86400*365.25);
		
		fprintf('hc %g %g\n',hc(idx,:));
		fprintf('wc %g %g\n',wc(idx,:));
		fprintf('T  %g %g\n',T);
	end
end


% Wed  7 Mar 18:38:57 CET 2018
%% solve the nodal point relation for critical points
function [t,h,w,R,A] = solve(obj,T_range,h_initial,w_initial)
	opt = odeset('InitialStep',1,'RelTol',1e-3,'AbsTol',1e-4);
	if (obj.wfixed)
		obj.w = w_initial;
	end
	A_initial = h_initial.*w_initial;
	[t,A] = ode23s(@(t,A) obj.Adot(t,A), ...
				T_range, A_initial, opt);
%			[t,A] = ode45(@(t,A) obj.Adot(t,A), ...
%						T_range, A_initial, opt);
	%[h,w,R] = obj.geometry(A);
%	for idx=1:2
		[h,w,R] = obj.geometry(A');
%	end
	%[h,w,R] = obj.geometry(A);
end % solve


% Mon 19 Feb 16:07:09 CET 2018
%% convert chezy to manning
function [n] = chezy_to_manning(C,R)
	n = 1./C.*R.^(1/6);
end


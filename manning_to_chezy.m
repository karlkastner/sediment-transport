% 2018-02-19 14:58:48.380392520 +0100
%
%% manning to chezy conversion
function [C] = manning_to_chezy(n,R)
	C = 1./n.*R.^(1/6);
end


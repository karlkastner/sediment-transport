% Wed 17 May 13:50:30 CEST 2017
%% suspended sediment concentration profile
classdef Rouse_Profile < handle
	properties
		c
		s2c
		serr
		clog
		% reference depth
		% note: only reference concentration, but not the rouse number
		%       depend on reference depth
		z_ref  = 1;
		nlfit = false;
		nwin   = 0;
	end % properties
	methods (Static)
		[ro, obj] = rouse_number(D,us);
		[D, ws, obj] = rouse_number_to_grain_diameter(ro,us);
	end % Static methods
	methods
		% constructor
		function obj = Rouse_profile()
		end % constructor
	end % methods
end % Rouse_profile


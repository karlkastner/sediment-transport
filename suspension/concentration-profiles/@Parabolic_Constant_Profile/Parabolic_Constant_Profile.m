% Wed 17 May 13:50:30 CEST 2017
%% parabolic-constant profile
classdef Parabolic_Constant_Profile < handle
	properties
		c
		clog
		% reference depth
		% note: only reference concentration, but not the rouse number
		% depend on reference depth
		z_ref  = 1;
		nlflag = true; %false;
	end % properties
	methods
		% constructor
		function obj = Rouse_profile()
		end
	end % methods
end % Rouse_profile


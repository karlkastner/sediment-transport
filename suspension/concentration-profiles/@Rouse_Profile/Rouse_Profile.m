% Wed 17 May 13:50:30 CEST 2017
%% suspended sediment concentration profile
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <https://www.gnu.org/licenses/>.
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
		fun;
	end % properties
	methods (Static)
		%[ro, obj]    = rouse_number(d_mm,us);
		[D, ws, obj] = rouse_number_to_grain_diameter(ro,us);
	end % Static methods
	methods
		% constructor
		function obj = Rouse_Profile()
			obj.fun.settling_velocity = @settling_velocity;
		end % constructor
	end % methods
end % Rouse_profile


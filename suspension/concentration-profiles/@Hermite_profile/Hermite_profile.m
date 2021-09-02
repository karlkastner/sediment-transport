% Wed 17 May 13:50:30 CEST 2017
%% suspended sedimen profile in form of a hermite polynomial
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
classdef Hermite_profile < handle
	properties
		c
		% support points along vertical
		nz = 10;
		% reference depth
	end % properties
	methods
		% constructor
		function obj = Hermite_profile()
			
		end
	end % methods
end % Rouse_profile


% Fri 19 May 13:49:49 CEST 2017
d = logspace(-1,1,10)'; ws = settling_velocity(d); d(:,2)=settling_velocity_to_diameter(ws)


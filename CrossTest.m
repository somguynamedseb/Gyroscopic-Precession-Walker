clearvars

syms F1 F2 F3 F4

% distances (cm)
% x distance from feet to center of bot
disXcm = 8;
disX = disXcm * .01;
% y distance from feet to center of bot
disYcm = 14;
disY = disYcm * .01;
% z distance from feet to center of bot
disZcm = 4;
disZ = disZcm * .01;

% angle of flywheels
theta1 = 75;

% RPM of Motorss
RPM = 1000;
% Percent of original speed (positive = right wheel = 1, negative = left wheel = 2)
decPer = .4;

% Slowdown time
deltaT = .1;

%radians per second
DeltaRPS = 2 * pi * decPer / 60;
RPS2 = 2* pi * RPM / 60;
RPS1 = -RPS2;
DeltaRPS1 = RPS1;
DeltaRPS2 = RPS2;

if (DeltaRPS > 0) 
    DeltaRPS1 = RPS1 * decPer;
else
    DeltaRPS2 = RPS2 * abs(decPer);
end



%unit vectors for Angular Velocity Vector Direction
unit1 = [cosd(theta1),sind(theta1),0];
unit2 = [-cosd(theta1),sind(theta1),0];

% Inital Angluar Velocity of Wheels
WAngVel1 = unit1 * RPS1;
WAngVel2 = unit2 * RPS2;
DeltaWAngVel1 = unit1 * DeltaRPS1;
DeltaWAngVel2 = unit2 * DeltaRPS2;

% Wheel mass (lb)
WMasslb = 1.5;
WMass = WMasslb * 0.453592;

% Wheel Radius ( cm)
WRadcm = 20;
% Convert to m
WRad = WRadcm * .01;

% Inertia of right/Left Spinning Wheel
I1 = .5 * WMass * WRad^2;
I2 = I1;

% Angluar Momentum (Kgm/s^2)
L1 = I1 * WAngVel1;
L2 = I2 * WAngVel2;

LPrime1 = I1 * DeltaWAngVel1;
LPrime2 = I2 * DeltaWAngVel2;


% The torque generated is the sum of the change in Angular Momentum over
% time.
T1 = (LPrime1 - L1 + LPrime2 - L2)/ deltaT;
R1 = [disX,-disY,disZ];
R2 = [-disX,-disY,disZ];
R3 = [disX,-disY,-disZ]; 
R4 = [-disX,-disY,-disZ];

% R = xprodmat(r);
% Finding the Forces Generated on the feet of the robot
% during rotation 
F1 = cross(T1,R1);
F2 = cross(T1,R2);
F3 = cross(T1,R3);
F4 = cross(T1,R4);
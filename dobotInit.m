function robot = dobotInit()

zz=zeros(3,1); ex = [1;0;0]; ey = [0;1;0]; ez = [0;0;1];


L1=100;
L2=135;
L3=160;
L5 = 50;
L6 = 50;

% P
p01=0*ex+L1*ez;
p12=zz;
p23=L2*ez;
p34=L3*ex;
p4T = L5*ex-L6*ez;

% H
h1=ez;
h2=ey;
h3=ey;
h4=ey;

robot.P=[p01 p12 p23 p34 p4T]/1000;
robot.H=   [h1 h2   h3  h4];
robot.joint_type=[0 0 0 0];

end
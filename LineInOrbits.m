function LineInOrbits(r,spdfactor,spd,rot)
% This program plots a second circle C1 with radius r inside the unit 
% circle C0 and traces the trajectory of a line segment connecting one 
% point from each circle, represented by P0 and P1.

% Input Arguments:
% r: the radius of circle C1;
% spdfactor: how faster the point P1 on C1 rotates than the point P0 on C0;
% spd: control the speed of the rotation of P0 on C0; it is the pause 
% between each move, spd>=0.
% rot: number of rotations;

% figure('visible','on'); This command is needed if the commands are
% implemented in live script; 
% plot C0 and C1;

fimplicit(@(x,y) x.^2 + y.^2 - 1);
set(gca,'Color','k')
hold on;
fimplicit(@(x,y) x.^2 + y.^2 - r^2);
Rlim = max(1,r);
axis equal;
axis([-Rlim Rlim -Rlim Rlim]);
axis manual;
% plot the initial points and the line segment connecting them;
line([r,1],[0,0],'Color','white');

numSampInt = 50;
t0 = 0:2*pi/numSampInt:rot*2*pi;
numSampt = length(t0);
t1 = spdfactor*t0;

for ii = 1:numSampt
    pause(spd);
    % draw line segment for each sample pair;
    line([cos(t0(ii)) r*cos(t1(ii))],[sin(t0(ii)) r*sin(t1(ii))],'Color','white');
    drawnow;
end
rectangle('Position',[-0.1 -0.1 0.2 0.2],'Curvature',[1 1],'FaceColor','y','EdgeColor',[1 1 0.8],'LineWidth',5);
end

function TwoCircIn(R,r1,r2,pos,rot,speed)
% Draw a fixed circle C0 centered at the origin, followed by another circle 
% C1 touching it internally at (R,0), and then a circle C2 touching them
% internally at (R,0). C1 rolls clockwise along C0's circumference. C2 
% rolls clockwise along C1's circumference. The program traces the movement
% of the point pos initially located at P=(R-r2+pos,0) in C2. The point P1 
% is a reference point that was initally located at P=(R,0) on C1.

% Input parameter:
% R: radius of C0;
% r1: radius of C1;
% r2: radius of C2;
% pos: the point to trace; indicated by the distance from the center of C2;
% 0<pos<r2;
% rot: number of rotations C1 rolls around;
% speed: the speed factor that describes how faster C2 rolls
% than C1; if speed = 1, they rolls the same number of
% rotations during the same time period;


% figure('visible','on'); This command is needed if the commands are
% implemented in live script; 
if pos > r2
    error('The trace point must be inside the last circle! (pos <= r2)');
end
% plot C0;
Rlim = 2*max([R,r1,r2])-R;
fimplicit(@(x,y) x.^2 + y.^2 - R^2);
axis equal;
axis([-Rlim Rlim -Rlim Rlim]);
hold on;
axis manual;
% plot the initial C1;
s = 0:2*pi/50:2*pi;
x1 = R-r1+r1*cos(s);
y1 = r1*sin(s);
h1 = plot(x1,y1,'r');
% plot the initial C2;
x2 = R-r2+r2*cos(s);
y2 = r2*sin(s);
h2 = plot(x2,y2,'g');
p = plot(R-r2+pos,0,'o','MarkerFaceColor','red');
% t1 is the parameter angle formed by the radius of C0 through the center 
% of C1 and the radius of C1 through the point P1;
% t2 is the parameter angle formed by the radius of C1 through the center 
% of C2 and the radius of C2 through the point P2;
% alpha1 is the angle formed by the radius of C0 through the 
% center of C1 and the positive x-axis; 
% alpha2 is the angle formed by the radius of C1 through the
% center of the third circer and the radius of C1 through
% the point P1;
t1 = 0:2*pi/50:rot*2*pi;
t2 = t1*speed;
alpha1 = r1*t1/R;
alpha2 = r2*t2/r1;
for ii =1:length(t1)
    % pause(0.01);
    % draw C1 after rotation;
    x1mov = (R-r1)*cos(alpha1(ii))+r1*cos(s);
    y1mov = (R-r1)*sin(alpha1(ii))+r1*sin(s);
    h1.XData = x1mov;
    h1.YData = y1mov;
    % draw C2 after rotation;
    x2mov = (R-r1)*cos(alpha1(ii))+(r1-r2)*cos(alpha1(ii)-t1(ii)+alpha2(ii))+r2*cos(s);
    y2mov = (R-r1)*sin(alpha1(ii))+(r1-r2)*sin(alpha1(ii)-t1(ii)+alpha2(ii))+r2*sin(s);
    h2.XData = x2mov;
    h2.YData = y2mov;
    p.XData = (R-r1)*cos(alpha1(1:ii))+(r1-r2)*cos(alpha1(1:ii)-t1(1:ii)+alpha2(1:ii))+pos*cos(alpha1(1:ii)-t1(1:ii)+alpha2(1:ii)-t2(1:ii));
    p.YData = (R-r1)*sin(alpha1(1:ii))+(r1-r2)*sin(alpha1(1:ii)-t1(1:ii)+alpha2(1:ii))+pos*sin(alpha1(1:ii)-t1(1:ii)+alpha2(1:ii)-t2(1:ii));
    drawnow;
end
end


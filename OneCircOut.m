function OneCircOut(R,r,pos,rot)
% Draw a fixed circle C0 centered at the origin and another circle C1 
% touching it externally at (R,0). C1 rolls counterclockwise along C0's 
% circumference. The program traces the movement of the point 
% pos initially located at P=(R+r-pos,0) in C1; 
% Input parameter:
% R: radius of C0;
% r: radius of C1;
% pos: the point to trace; indicated by the distance from the center of C1; 
% 0<pos<r;
% rot: number of rotations C1 rolls around;


% figure('visible','on'); This command is needed if the commands are
% implemented in live script; 
if pos > r
    error('The trace point must be inside the last circle! (pos <= r)');
end
% plot C0;
Rlim = R+2*r;
fimplicit(@(x,y) x.^2 + y.^2 - R^2);
axis equal;
axis([-Rlim Rlim -Rlim Rlim]);
hold on;
axis manual;
% plot the initial second circle;
s = 0:2*pi/50:2*pi;
x1 = R+r+r*cos(s);
y1 = r*sin(s);
h1 = plot(x1,y1,'r');
p = plot(R+r-pos,0,'.','MarkerFaceColor','red');
% t is the parameter angle formed by the radius of C0 through the center 
% of C1 and the radius of C1 through the point P1;
% alpha is the angle formed by the radius of C0 through the 
% center of C1 and the positive x-axis;
t = 0:2*pi/50:rot*2*pi;
alpha = r*t/R;
for ii =1:length(t)
    % pause(0.01);
    x1mov = (R+r)*cos(alpha(ii))+r*cos(s);
    y1mov = (R+r)*sin(alpha(ii))+r*sin(s);
    h1.XData = x1mov;
    h1.YData = y1mov;
    p.XData = (R+r)*cos(alpha(1:ii))+pos*cos(pi+alpha(1:ii)+t(1:ii));
    p.YData = (R+r)*sin(alpha(1:ii))+pos*sin(pi+alpha(1:ii)+t(1:ii));
    drawnow;
end
end


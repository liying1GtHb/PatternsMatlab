function OneCircIn(R,r,pos,rot)
% Draw a fixed circle centered at the origin followed by another circle 
% touching it internally at (R,0). The second circle rolls clockwise along 
% the first circle's circumference. The program traces the movement of the 
% point pos initially located at P=(R-r+pos,0) in the second circle; 
% Input parameter:
% R: radius of the first circle;
% r: radius of the second circle;
% pos: the point to trace; indicated by the distance from the center of the 
% second circle; 0<pos<r;
% rot: number of rotations the second circle rolls around;


% figure('visible','on'); This command is needed if the commands are
% implemented in live script; 
if pos > r
    error('The trace point must be inside the small circle! (pos <= r)');
end
Rlim = max(R,r);
% plot the first circle;
fimplicit(@(x,y) x.^2 + y.^2 - R^2);
axis equal;
axis([-Rlim Rlim -Rlim Rlim]);
hold on;
axis manual;
% plot the initial second circle;
s = 0:2*pi/50:2*pi;
x = R-r+r*cos(s);
y = r*sin(s);
h = plot(x,y,'r');
p = plot(R-r+pos,0,'.','MarkerFaceColor','red');
% t is the parameter angle formed by the radius of the first circle through 
% the center of the second circle and the radius of the second circle 
% through the point Ps;
% alpha is the angle formed by the radius of the first circle through the 
% center of the second circle and the positive x-axis;
t = 0:2*pi/50:rot*2*pi;
alpha = r*t/R;
for ii =1:length(t)
    % pause(0.01);
    xmov = (R-r)*cos(alpha(ii))+r*cos(s);
    ymov = (R-r)*sin(alpha(ii))+r*sin(s);
    h.XData = xmov;
    h.YData = ymov;
    p.XData = (R-r)*cos(alpha(1:ii))+pos*cos(alpha(1:ii)-t(1:ii));
    p.YData = (R-r)*sin(alpha(1:ii))+pos*sin(alpha(1:ii)-t(1:ii));
    drawnow;
end
end


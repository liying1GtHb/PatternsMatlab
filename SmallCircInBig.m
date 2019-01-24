function SmallCircInBig(R,r,pos,rot)
% Draw a big circle centered at the origin and a smaller inner circle 
% touching it at (R,0). The smaller circle rolls clockwise along the big
% circle's circumference. The program traces the movement of the point Ps
% initially located at P=(R,0) on the small circle; 
% Input parameter:
% R: radius of the big circle;
% r: radius of the small circle;
% pos: the point to trace; indicated by the distance from the center of the 
% small circle; 0<pos<r;
% rot: number of rotations the small circle rolls around;


% figure('visible','on'); This command is needed if the commands are
% implemented in live script; 
if pos > r
    error('The trace point must be inside the small circle! (pos <= r)');
end
axis([-R R -R R]);
% plot the big circle;
fimplicit(@(x,y) x.^2 + y.^2 - R^2);
axis equal;
hold on;
% plot the initial small circle;
s = 0:2*pi/50:2*pi;
xsmall = R-r+r*cos(s);
ysmall = R-r+r*sin(s);
hsmall = plot(xsmall,ysmall,'r');
p = plot(R-r+pos,0,'.','MarkerFaceColor','red');
% t is the parameter angle formed by the radius of the big circle through 
% the center of the smaller circle and the radius of the smaller circle 
% through the point Ps;
% alpha is the angle formed by the radius of the big circle through the 
% center of the smaller circle and the positive x-axis;
t = 0:2*pi/50:rot*2*pi;
alpha = r*t/R;
for ii =1:length(t)
    % pause(0.01);
    xsmallmov = (R-r)*cos(alpha(ii))+r*cos(s);
    ysmallmov = (R-r)*sin(alpha(ii))+r*sin(s);
    hsmall.XData = xsmallmov;
    hsmall.YData = ysmallmov;
    p.XData = (R-r)*cos(alpha(1:ii))+pos*cos(alpha(1:ii)-t(1:ii));
    p.YData = (R-r)*sin(alpha(1:ii))+pos*sin(alpha(1:ii)-t(1:ii));
    drawnow;
end
axis equal;
end


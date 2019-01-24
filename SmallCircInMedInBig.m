function SmallCircInMedInBig(R,rm,rs,pos,rot,speed)
% Draw a big circle centered at the origin and a smaller inner circle 
% touching it at (R,0), then an even smaller circle touching the medium one
% at (R,0). The medium circle rolls clockwise along the big circle's 
% circumference. The small circle rolls clockwise along the medium
% circle's circumference. The program traces the movement of the point pos
% initially located at P=(R-rs+pos,0) in the small circle. The point Pm is a
% reference point that was initally located at P=(R,0) on the medium circle.

% Input parameter:
% R: radius of the big circle;
% rm: radius of the medium circle;
% rs: radius of the small circle;
% pos: the point to trace; indicated by the distance from the center of the 
% small circle; 0<pos<rs;
% rot: number of rotations the medium circle rolls around;
% speed: the speed factor that describes how faster the small circle rolls
% than the medium circle; if speed = 1, they rolls the same number of
% rotations during the same time period;


% figure('visible','on'); This command is needed if the commands are
% implemented in live script; 
axis([-R R -R R]);
% plot the big circle;
fimplicit(@(x,y) x.^2 + y.^2 - R);
axis equal;
hold on;
% plot the initial medium circle;
s = 0:2*pi/50:2*pi;
xmedium = R-rm+rm*cos(s);
ymedium = R-rm+rm*sin(s);
hmedium = plot(xmedium,ymedium,'r');
% plot the initial small circle;
xsmall = R-rs+rs*cos(s);
ysmall = R-rs+rs*sin(s);
hsmall = plot(xsmall,ysmall,'g');
p = plot(R-rs+pos,0,'o','MarkerFaceColor','red');
% tm is the parameter angle formed by the radius of the big circle through 
% the center of the medium circle and the radius of the medium circle 
% through the point Pm;
% ts is the parameter angle formed by the radius of the medium circle
% through the center of the small circle and the radius of the small circle
% through the point Ps;
% alpham is the angle formed by the radius of the big circle through the 
% center of the medium circle and the positive x-axis; 
% alphas is the angle formed by the radius of the medium circle through the
% center of the small circer and the radius of the medium circle through
% the point Pm;
tm = 0:2*pi/50:rot*2*pi;
ts = tm*speed;
alpham = rm*tm/R;
alphas = rs*ts/rm;
for ii =1:length(tm)
    % pause(0.01);
    % draw new medium circle;
    xmediummov = (R-rm)*cos(alpham(ii))+rm*cos(s);
    ymediummov = (R-rm)*sin(alpham(ii))+rm*sin(s);
    hmedium.XData = xmediummov;
    hmedium.YData = ymediummov;
    % draw new small circle;
    xsmallmov = (R-rm)*cos(alpham(ii))+(rm-rs)*cos(alpham(ii)-tm(ii)+alphas(ii))+rs*cos(s);
    ysmallmov = (R-rm)*sin(alpham(ii))+(rm-rs)*sin(alpham(ii)-tm(ii)+alphas(ii))+rs*sin(s);
    hsmall.XData = xsmallmov;
    hsmall.YData = ysmallmov;
    p.XData = (R-rm)*cos(alpham(1:ii))+(rm-rs)*cos(alpham(1:ii)-tm(1:ii)+alphas(1:ii))+pos*cos(alpham(1:ii)-tm(1:ii)+alphas(1:ii)-ts(1:ii));
    p.YData = (R-rm)*sin(alpham(1:ii))+(rm-rs)*sin(alpham(1:ii)-tm(1:ii)+alphas(1:ii))+pos*sin(alpham(1:ii)-tm(1:ii)+alphas(1:ii)-ts(1:ii));
    drawnow;
end
axis equal;
end


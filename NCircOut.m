function NCircOut(R,r,pos,rot,spd)
% Draw a fixed circle C0 centered at the origin, followed by a sequence of 
% circles Ci, all touching the previous one externally on the right, each 
% rolling counterclockwise along the previous circle's circumference. The 
% program traces the movement of the point pos initially located at P=(R-r(n)+pos,0)
% in Cn. The point Pi is a
% reference point that was initally located at P=(R,0) on Ci.

% Input parameter:
% R: radius of C0;
% r: a vector of n radii of the sequence of circles;
% pos: the point to trace; indicated by the distance from the center of Cn; 
% 0<pos<r(n);
% rot: number of rotations C1 rolls around;
% speed: a vector of n-1 components, each of the speed factor  
% describes how faster Ci+1 rolls than Ci; 
% if speed = 1, they rolls the same number of rotations during the same 
% time period;


% figure('visible','on'); This command is needed if the commands are
% implemented in live script; 
% plot C0;
numCirc = length(r);
if pos > r(numCirc)
    error('The trace point must be inside the last circle! (pos <= r(n))');
end
Rlim = R+2*sum(r);
fimplicit(@(x,y) x.^2 + y.^2 - R^2);
axis equal;
axis([-Rlim Rlim -Rlim Rlim]);
hold on;
axis manual;
% plot the initial sequence of circles;
s = 0:2*pi/50:2*pi;
h = gobjects(1,numCirc);
for ii = 1:numCirc
    x = (R+2*sum(r(1:ii))-r(ii))*cos(s);
    y = r(ii)*sin(s);
    h(ii) = plot(x,y,'r');
end
p = plot(R+2*sum(r)-r(numCirc)-pos,0,'.','MarkerFaceColor','red');
%
% t(i) is the parameter angle formed by the radius of C(i-1) through the
% center of Ci and the radius of Ci through the point Pi;
% alpha(i) is the angle formed by the radius of C(i-1) through the center 
% of Ci and the radius of C(i-1) through the point P(i-1);
numSampInt = 200;
t = 0:2*pi/numSampInt:rot*2*pi;
numSampt = length(t);
t = repmat(t,numCirc,1);
t = diag([1,spd])*t;
alpha = zeros(numCirc,numSampt);
alpha(1,:)=r(1)*t(1,:)/R;
for ii = 2:numCirc
    alpha(ii,:) = r(ii)*t(ii,:)/r(ii-1);
end
% record the centers of the last circle during rotations;
lastxcenter = zeros(1,numSampt);
lastycenter = zeros(1,numSampt);
for ii = 1:numSampt
    % pause(0.01);
    % draw C1 after rotation;
    xcenter = (R+r(1))*cos(alpha(1,ii));
    ycenter = (R+r(1))*sin(alpha(1,ii));
    h(1).XData = xcenter+r(1)*cos(s);
    h(1).YData = ycenter+r(1)*sin(s);
    % draw the other circles after rotation;
    for jj = 2:numCirc
        xcenter = xcenter+(r(jj-1)+r(jj))*cos(sum(alpha(1:jj-1,ii))+sum(t(1:jj-1,ii))+alpha(jj,ii));
        ycenter = ycenter+(r(jj-1)+r(jj))*sin(sum(alpha(1:jj-1,ii))+sum(t(1:jj-1,ii))+alpha(jj,ii));
        h(jj).XData = xcenter+r(jj)*cos(s);
        h(jj).YData = ycenter+r(jj)*sin(s);
    end
    lastxcenter(ii) = xcenter;
    lastycenter(ii) = ycenter;
    % trace the point pos;
    p.XData = lastxcenter(1:ii)+pos*cos(pi+sum(alpha(:,1:ii),1)+sum(t(:,1:ii),1));
    p.YData = lastycenter(1:ii)+pos*sin(pi+sum(alpha(:,1:ii),1)+sum(t(:,1:ii),1));
    drawnow;
end
end


function RotatingCircles(r,InOutInd,pos,rot,spdfactor,spd)
% Draw the unit circle C0 centered at the origin, followed by a sequence of 
% circles Ci, all touching the previous one, either internally, or 
% externally on the right. If a circle touches the previous one internally,
% it rolls clockwise along the previous circle's circumference. Otherwise
% it rolls counterclockwise along the previous circle's circumference. The 
% program traces the movement of the point pos located inside the last 
% circle. If the last circle rotates externally around the previously, pos 
% is located on the left horizontal radius. Otherwise it is located on the 
% right horizontal radius. 

% Input parameter:
% 
% r: a vector of n radii of the sequence of circles; each entry is <1.
% InOutInd: a vector of length n, with entries 1 or -1. 1 indicates that
% the corresponding circle rotates around the previous one internally. -1
% indicates that the corresponding circle rotates around the previous one
% externally. 
% pos: the point to trace; indicated by the distance from the center of Cn; 
% 0<pos<r(n);
% rot: number of rotations C1 rolls around;
% spdfactor: a vector of n-1 components, each of the speed factor  
% describes how faster C_i+1 rolls than C1; 
% if spdfactor = 1, they rolls the same number of rotations during the same 
% time period;
% spd: control the speed of the whole rotation; it is the pause between
% each move, spd>=0.


% figure('visible','on'); This command is needed if the commands are
% implemented in live script; 
% plot C0;
numCirc = length(r);
if pos > r(numCirc)
    error('The trace point must be inside the last circle! (pos <= r(n))');
end
fimplicit(@(x,y) x.^2 + y.^2 - 1);
% compute the region that accommodate all circles; 
Rlim = 1;
if InOutInd(1) < 0
    Rlim = Rlim+2*r(1);
else
    Rlim = max(Rlim-2+2*r(1),Rlim);
end
for ii = 2:numCirc
    if InOutInd(ii) < 0
        Rlim = Rlim+2*r(ii);
    else
        Rlim = max(Rlim,Rlim-2*r(ii-1)+2*r(ii));
    end
end
axis equal;
axis([-Rlim Rlim -Rlim Rlim]);
hold on;
axis manual;
% plot the initial sequence of circles;
s = 0:2*pi/50:2*pi;
h = gobjects(1,numCirc);
xcenter = 1-InOutInd(1)*r(1);
x = xcenter+r(1)*cos(s);
y = r(1)*sin(s);
h(1) = plot(x,y,'r');
for ii = 2:numCirc
    xcenter = xcenter+r(ii-1)-InOutInd(ii)*r(ii);
    x = xcenter+r(ii)*cos(s);
    y = r(ii)*sin(s);
    h(ii) = plot(x,y,'r');
end
% plot the point to trace in the last circle;
p = plot(xcenter+InOutInd(numCirc)*pos,0,'.','MarkerFaceColor','red');


% t(i) is the parameter angle formed by the radius of C(i-1) through the
% center of Ci and the radius of Ci through the point Pi;
% alpha(i) is the angle formed by the radius of C(i-1) through the center 
% of Ci and the radius of C(i-1) through the point P(i-1);
numSampInt = 200;
t = 0:2*pi/numSampInt:rot*2*pi;
numSampt = length(t);
t = repmat(t,numCirc,1);
t = diag([1,spdfactor])*t;
alpha = zeros(numCirc,numSampt);
alpha(1,:)=r(1)*t(1,:)/1;
for ii = 2:numCirc
    alpha(ii,:) = r(ii)*t(ii,:)/r(ii-1);
end
t = diag(-InOutInd)*t; % +theta if external; -theta if internal;

% record the trajectories of the last touching point during rotations;
traceP = (-InOutInd(numCirc)+1)/2*pi+sum(alpha+t);
% record the polar angle formed by the centers of the circles;
allCenters = cumsum(alpha+t)-t;
% record the trajectory of the last circle;
lastxcenter = zeros(1,numSampt);
lastycenter = zeros(1,numSampt);
for ii = 1:numSampt
    pause(spd);
    % draw C1 after rotation;
    xcenter = (1-InOutInd(1)*r(1))*cos(allCenters(1,ii));
    ycenter = (1-InOutInd(1)*r(1))*sin(allCenters(1,ii));
    h(1).XData = xcenter+r(1)*cos(s);
    h(1).YData = ycenter+r(1)*sin(s);
    % draw the other circles after rotation;
    for jj = 2:numCirc
        xcenter = xcenter+(r(jj-1)-InOutInd(jj)*r(jj))*cos(allCenters(jj,ii));
        ycenter = ycenter+(r(jj-1)-InOutInd(jj)*r(jj))*sin(allCenters(jj,ii));
        h(jj).XData = xcenter+r(jj)*cos(s);
        h(jj).YData = ycenter+r(jj)*sin(s);
    end
    lastxcenter(ii) = xcenter;
    lastycenter(ii) = ycenter;
    % trace the point pos;
    p.XData = lastxcenter(1:ii)+pos*cos(traceP(1:ii));
    p.YData = lastycenter(1:ii)+pos*sin(traceP(1:ii));
    drawnow;
end
end


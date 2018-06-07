function carsketch(state,info,r,g,o,second,w)
secperiod=rem(second,r+g+o);
if(secperiod<r)
    plot(-w/2,-w/2,'r.','markersize',40);
    plot(w/2,w/2,'r.','markersize',40);
elseif(secperiod>=r&&secperiod<=r+g)
    plot(-w/2,-w/2,'g.','markersize',40);
    plot(w/2,w/2,'g.','markersize',40);
elseif(secperiod>r+g)
    plot(-w/2,-w/2,'y.','markersize',40);
    plot(w/2,w/2,'y.','markersize',40);
end;
if(secperiod<=g)
    plot(-w/2,w/2,'g.','markersize',40);
    plot(w/2,-w/2,'g.','markersize',40);
elseif(secperiod>g&&secperiod<o+g)
    plot(-w/2,w/2,'y.','markersize',40);
    plot(w/2,-w/2,'y.','markersize',40);
elseif(secperiod>o+g)
    plot(-w/2,w/2,'r.','markersize',40);
    plot(w/2,-w/2,'r.','markersize',40);
end;
d=[];
col=['m','c','b','k'];
for i=1:numel(state)/3
    if(abs(state(i,1))==w/4&&abs(state(i,2))~=w/4)
        d=[d 2];
    else
        d=[d 1];
    end;
end;
for i=1:numel(state)/3
    switch d(i)
        case 1
            rectangle('position',[state(i,1)-info(i,3)/2,state(i,2)-info(i,4)/2,info(i,3),info(i,4)],'EdgeColor',col(info(i,1)));
            fill([state(i,1)-info(i,3)/2,state(i,1)-info(i,3)/2,state(i,1)+info(i,3)/2,state(i,1)+info(i,3)/2],[state(i,2)-info(i,4)/2,state(i,2)+info(i,4)/2,state(i,2)+info(i,4)/2,state(i,2)-info(i,4)/2],col(info(i,1)));
        case 2
            rectangle('position',[state(i,1)-info(i,4)/2,state(i,2)-info(i,3)/2,info(i,4),info(i,3)],'EdgeColor',col(info(i,1)));
            fill([state(i,1)-info(i,4)/2,state(i,1)-info(i,4)/2,state(i,1)+info(i,4)/2,state(i,1)+info(i,4)/2],[state(i,2)-info(i,3)/2,state(i,2)+info(i,3)/2,state(i,2)+info(i,3)/2,state(i,2)-info(i,3)/2],col(info(i,1)));
    end;
end;
end

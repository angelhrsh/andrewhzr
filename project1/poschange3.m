function nextpos3=poschange3(current3,info3,v,tchange)%now current3 only has the cars at current 3 and their positions, info3 too
numbers3=numel(current3)/2;
nextpos3=current3;
for i=1:numbers3
    if((floor((info3(i,1)+1)/2)==1&&info3(i,2)==0)||((floor((info3(i,1)+1)/2)==2)&&info3(i,2)~=0))
        nextpos3(i,1)=nextpos3(i,1)+sign(nextpos3(i,1))*tchange*v;
    else
        nextpos3(i,2)=nextpos3(i,2)+sign(nextpos3(i,1))*tchange*v;
    end;
end;
end
function isnocrash=judgecrash(nextpos2,info2,w)
numbers2=numel(nextpos2)/3;
d=[];
isnocrash=1;
for i=1:numbers2%assign 1 means that the car is horizontal(west east), 2 means vertical(south north)
    if(floor((info2(i,1)+1)/2)==1&&(info2(i,2)==0||(info2(i,2)==1&&nextpos2(i,1)~=-((-1)^info2(i,1))*w/4)||(info2(i,2)==-1&&nextpos2(i,1)~=((-1)^info2(i,1))*w/4)))
        d=[d,1];
    elseif(floor((info2(i,1)+1)/2)==2&&((info2(i,2)==1&&nextpos2(i,2)==-((-1)^info2(i,1))*w/4)||(info2(i,2)==-1&&nextpos2(i,2)==((-1)^info2(i,1))*w/4)))
        d=[d,1];
    else
        d=[d,2];
    end
end
for i=1:numbers2%if there is a crash, four more values return: the number of the crashed cars and their directions
    for j=1:numbers2
        if(i<=j)
            break;
        end;
        if(d(i)==1&&d(j)==2)
            if(abs(nextpos2(i,1)-nextpos2(j,1))<=info2(i,3)/2+info2(j,4)/2&&abs(nextpos2(i,2)-nextpos2(j,2))<=info2(i,4)/2+info2(j,3)/2)
                isnocrash=[isnocrash i d(i) j d(j)];                
                isnocrash(1)=0;
            end;
        elseif(d(i)==2&&d(j)==1)
            if(abs(nextpos2(i,1)-nextpos2(j,1))<=info2(i,4)/2+info2(j,3)/2&&abs(nextpos2(i,2)-nextpos2(j,2))<=info2(i,3)/2+info2(j,4)/2)
                isnocrash=[isnocrash i d(i) j d(j)];                
                isnocrash(1)=0;
            end;
        elseif(d(i)==1&&d(j)==1)
            if(abs(nextpos2(i,1)-nextpos2(j,1))<=info2(i,3)/2+info2(j,3)/2&&nextpos2(i,2)==nextpos2(j,2))
                isnocrash=[isnocrash i d(i) j d(j)];
                isnocrash(1)=0;
            end;        
        elseif(d(i)==2&&d(j)==2)
            if(abs(nextpos2(i,2)-nextpos2(j,2))<=info2(i,3)/2+info2(j,3)/2&&nextpos2(i,1)==nextpos2(j,1))
                isnocrash=[isnocrash i d(i) j d(j)];
                isnocrash(1)=0;
            end;
        end;
    end;
end;
end
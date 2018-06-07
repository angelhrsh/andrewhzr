function [next,nostop]=movement(info,second,current,w,r,g,o,posinfo,range)
nostop=[];
next=current;
v=(3*w/2+25)/(o*range(2));%this represenets the velocity of the cars, this will (possibly later) be multiplied some coefficients later for the car to automatically adjust its speed

%first generate the new positions of cars at state 3(after crossing the crossroad)
findstate3=(current(1:end,3)==3)';
findstate3=find(findstate3);
if(~isempty(findstate3))
    nextpos3=poschange3(current(findstate3,[1,2]),info(findstate3,:),v*range(3),0.1);%cars after crossing the cross road rush at the highest speed
    next(findstate3,[1,2])=nextpos3;
    for i=1:numel(findstate3)
        if(abs(next(findstate3(i),1))>125+w/2||abs(next(findstate3(i),2))>125+w/2)
            next(findstate3(i),3)=4;
        end;
    end;
end;
%finish assigning new positions of state3 cars to next


%second, generate the new positions of cars at state 2(at the crossroad,most complicated)
findstate2=find(current(1:end,3)==2)';
%get the positions of cars after 0.3s first, check if there will be crash
%after 0.3s, then according to the situation to adjust the speed
if(~isempty(findstate2))
    nextpos2=poschange2(current(findstate2,:),findstate2,info(findstate2,:),v,0.3,w,[],range);
    
    isnocrash=judgecrash(nextpos2,info(findstate2,:),w);
    
    crash=(numel(isnocrash)-1)/4;%calculate the number of accidents occured
    adjust=[];
    if(crash>0)
        for i=1:crash
            if(isnocrash(4*i-1)==isnocrash(4*i+1))%if the two cars are in the same direction
                if(isnocrash(4*i-1)==1)%if the two cars are horizontal
                    if(sign(nextpos2(isnocrash(4*i-2),1)-nextpos2(isnocrash(4*i),1))*sign(nextpos2(isnocrash(4*i-2),1)-current(findstate2(isnocrash(4*i-2)),1))>=0)
                        adjust=[adjust isnocrash(4*i-2) isnocrash(4*i)];
                    else
                        adjust=[adjust isnocrash(4*i) isnocrash(4*i-2)];%the front one goes faster
                    end;
                else
                    if(sign(nextpos2(isnocrash(4*i-2),2)-nextpos2(isnocrash(4*i),2))*sign(nextpos2(isnocrash(4*i-2),2)-current(findstate2(isnocrash(4*i-2)),2))>=0)
                        adjust=[adjust isnocrash(4*i-2) isnocrash(4*i)];
                    else
                        adjust=[adjust isnocrash(4*i) isnocrash(4*i-2)];%the front one goes faster
                    end;
                end;
            elseif(isnocrash(4*i-1)==1&&isnocrash(4*i+1)==2)
                if(abs(current(findstate2(isnocrash(4*i-2)),1)-current(findstate2(isnocrash(4*i)),1))>=abs(current(findstate2(isnocrash(4*i-2)),2)-current(findstate2(isnocrash(4*i)),2)))
                    adjust=[adjust isnocrash(4*i) isnocrash(4*i-2)];
                else
                    adjust=[adjust isnocrash(4*i-2) isnocrash(4*i)];
                end;
            elseif(isnocrash(4*i-1)==2&&isnocrash(4*i+1)==1)
                if(abs(current(findstate2(isnocrash(4*i-2)),1)-current(findstate2(isnocrash(4*i)),1))>=abs(current(findstate2(isnocrash(4*i-2)),2)-current(findstate2(isnocrash(4*i)),2)))
                    adjust=[adjust isnocrash(4*i-2) isnocrash(4*i)];
                else
                    adjust=[adjust isnocrash(4*i) isnocrash(4*i-2)];
                end;
            end;
        end;
    end;
    
    nextpos2=poschange2(current(findstate2,:),findstate2,info(findstate2,:),v,0.1,w,adjust,range);
    isnocrash=judgecrash(nextpos2,info(findstate2,:),w);
    for i=1:numel(findstate2)%change the state of car from state 2 to state 3(at the crossroad to after the crossroad)
        switch info(findstate2(i),1)
            case 1
                if(info(findstate2(i),2)==0)
                    end2=1;
                elseif(info(findstate2(i),2)==1)
                    end2=3;
                elseif(info(findstate2(i),2)==-1)
                    end2=4;
                end
            case 2
                if(info(findstate2(i),2)==0)
                    end2=2;
                elseif(info(findstate2(i),2)==1)
                    end2=4;
                elseif(info(findstate2(i),2)==-1)
                    end2=3;
                end
            case 3
                if(info(findstate2(i),2)==0)
                    end2=3;
                elseif(info(findstate2(i),2)==1)
                    end2=2;
                elseif(info(findstate2(i),2)==-1)
                    end2=1;
                end
            case 4
                if(info(findstate2(i),2)==0)
                    end2=4;
                elseif(info(findstate2(i),2)==1)
                    end2=1;
                elseif(info(findstate2(i),2)==-1)
                    end2=2;
                end
        end;
        switch end2
            case 1
                if(nextpos2(i,1)>w/2)
                    nextpos2(i,3)=3;
                end
            case 2
                if(nextpos2(i,1)<-w/2)
                    nextpos2(i,3)=3;
                end
            case 3
                if(nextpos2(i,2)>w/2)
                    nextpos2(i,3)=3;
                end
            case 4
                if(nextpos2(i,2)<-w/2)
                    nextpos2(i,3)=3;
                end
        end;
    end;
    next(findstate2,:)=nextpos2;
    if(isnocrash(1)==0)
        next(findstate2,3)=0;%0 represents crash, it's over
    end;
end;
%finish assigning new positions of state2 cars to next


%third,generate new positions of cars at state 1(before entering crossroad)
findstate1=zeros(1,4);%find the first car on each direction at stage 1(before entering the crossroad)

for i=1:4
    for j=posinfo(i):posinfo(i+1)-1
        if(current(j,3)==1)
            findstate1(i)=j;
            break;
        end;
    end;
end;

posstate1=zeros(1,4);
for i=1:4%find the position of the head of four cars
    if(findstate1(i)~=0)
        posstate1(i)=current(findstate1(i),floor((i+1)/2));
%         posstate1(i)=current(findstate1(i),floor((i+1)/2))-((-1)^i)*info(findstate1(i),3)/2;
    end;
end;

halfway=0;
for i=1:4%judge the position and whether it can move on
    if(posstate1(i)~=0)
        if(abs(posstate1(i))-info(findstate1(i),3)/2>w/2)%if the car has not reached the waiting line yet
            if(findstate1(i)~=posinfo(i)&&current(findstate1(i)-1,3)==2)%if not the very first car and the previous car is now at the crossroad
                if(info(findstate1(i)-1,2)==-1&&abs(current(findstate1(i)-1,floor((i+1)/2)))==4/w)%if the car has already turned right then it is fine
                    nextpos1=poschange1(current(findstate1(i):posinfo(i+1)-1,:),v,info(findstate1(i):posinfo(i+1)-1,:),0,w);
                elseif(abs(current(findstate1(i)-1,floor((i+1)/2))-current(findstate1(i),floor((i+1)/2)))>=info(findstate1(i),3)/2+info(findstate1(i)-1,3)/2+0.1*v);
                    nextpos1=poschange1(current(findstate1(i):posinfo(i+1)-1,:),v,info(findstate1(i):posinfo(i+1)-1,:),0,w);
                else%it stops
                    nextpos1=current(findstate1(i):posinfo(i+1)-1,:);
                end;
            else
                nextpos1=poschange1(current(findstate1(i):posinfo(i+1)-1,:),v,info(findstate1(i):posinfo(i+1)-1,:),0,w);
            end;
            next(findstate1(i):posinfo(i+1)-1,:)=nextpos1;
            posstate1(i)=nextpos1(1,floor((i+1)/2));
            halfway=1;
        end;
        if(abs(posstate1(i))-info(findstate1(i),3)/2-w/2<=0.0002&&abs(posstate1(i))-info(findstate1(i),3)/2-w/2>=-0.0002)%if a car has just moved from >w/2 to ==w/2, and time remaing should be considered
            if(halfway==1)
                remt=0.1-abs(current(findstate1(i),floor((i+1)/2))-next(findstate1(i),floor((i+1)/2)))/v;
            else
                remt=0.1;
            end;
            if(remt~=0)
                whethergo=crossroadstate(i,next,second,r,g,o,w);
                if(info(findstate1(i),5)==0)
                    whethergo=1;
                    nostop=[nostop findstate1(i)];
                end;
                if(whethergo)%the car changes from state 1 to state 2(the following circumstance there will be bug: two car can cross the line in 0.1s, so parameter should be considered fully)
                    nextpos1=poschange1(current(findstate1(i):posinfo(i+1)-1,:),v,info(findstate1(i):posinfo(i+1)-1,:),remt,w);
                    next(findstate1(i):posinfo(i+1)-1,:)=nextpos1;                    
                    next(findstate1(i),3)=2;
                end;
            end;
        end;
    end;
end;
end
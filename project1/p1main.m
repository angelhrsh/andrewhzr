function state=p1main(numbers,w,p,t,r,g,o,range)
v=(3*w/2+25)/(o*range(2));
n=sum(numbers);
info=zeros(n,5);%the first column of the array is to store the info of the directions, the second for turning left or right or going straight, the third and fourth for the sizes of the cars, the fifth for whether the car will stop at red light
posinfo=zeros(1,5);
posinfo(1)=1;posinfo(2)=posinfo(1)+numbers(1);posinfo(3)=posinfo(2)+numbers(2);posinfo(4)=posinfo(3)+numbers(3);posinfo(5)=n+1;
for i=1:4
    if(posinfo(i+1)-posinfo(i)>0)
        info(posinfo(i):posinfo(i+1)-1,1)=i;%assign the directions of the cars to the big information array
    end;
end;
%finish assigning column 1
direction=rand(1,n);
for i=1:n%1 represents left, 0 represents going straight, and -1 represents right
    if(direction(1,i)<=t)
        info(i,2)=1;
    elseif(direction(1,i)>t&&direction(1,i)<=2*t)
        info(i,2)=-1;
    else
        info(i,2)=0;
    end;
end;
%finish assigning column 2
for i=1:n
        info(i,3)=(rand*0.5+0.75)*20;
        info(i,4)=(rand*0.5+0.75)*10;
end;
%finish assigning column 3 and 4, the sizes of cars have been set up
stopred=rand(1,n);
for i=1:n%0 means the car will not stop at the red light, 1 means it will
    if(stopred(i)<p)
        info(i,5)=0;
    else
        info(i,5)=1;
    end;
end;
%finish assigning column 5
%now generate the registration plate
charplate={};
for i=1:26
    charplate=[charplate char(i+64)];
end;
for i=1:10
    charplate=[charplate char(i+47)];
end;
allperm2=findperm2(charplate,5,5,[],{},n);
carplate={};
for i=1:n
    firstletter=randperm(26,1)+64
    carplate=[carplate [char(firstletter),' ',allperm2{i}]];
end;


state=zeros(n,3);%this matrix stores the current positions of the cars
state(:,3)=1;%all the cars are now at the first stage of movement
for i=1:n%generate the initial positions of each car
    if(i==posinfo(1)&&posinfo(2)-posinfo(1)>0)
        state(i,1)=-w/2-100-info(i,3)/2;
        state(i,2)=-w/4;
    elseif(i==posinfo(2)&&posinfo(3)-posinfo(2)>0)
        state(i,1)=w/2+100+info(i,3)/2;
        state(i,2)=w/4;
    elseif(i==posinfo(3)&&posinfo(4)-posinfo(3)>0)
        state(i,1)=w/4;
        state(i,2)=-w/2-100-info(i,3)/2;
    elseif(i==posinfo(4)&&posinfo(5)-posinfo(4)>0)
        state(i,1)=-w/4;
        state(i,2)=w/2+100+info(i,3)/2;
    else
        state(i,1)=(info(i,1)==1)*(state(i-1,1)-info(i-1,3)/2-20-info(i,3)/2)+(info(i,1)==2)*(state(i-1,1)+info(i-1,3)/2+20+info(i,3)/2)+(info(i,1)==3)*(w/4)+(info(i,1)==4)*(-w/4);
        state(i,2)=(info(i,1)==1)*(-w/4)+(info(i,1)==2)*(w/4)+(info(i,1)==3)*(state(i-1,2)-info(i-1,3)/2-20-info(i,3)/2)+(info(i,1)==4)*(state(i-1,2)+info(i-1,3)/2+20+info(i,3)/2);
    end;
end;


tempn=n;%how many cars are still on the screen or waiting to go into the screen
second=0.1;
nostoptot=[];
while(tempn>0)
    [next,nostop]=movement(info,second,state,w,r,g,o,posinfo,range);
    state=next;
    tempn=n;
    for i=1:n
        if(next(i,3)==4)
            tempn=tempn-1;
        end;
    end;
    for i=1:n
        if(next(i,3)==0)
            tempn=-1;
            break;
        end;
    end;
    second=second+0.1;
    clf;
    roadsketch(w);
    carsketch(state,info,r,g,o,second,w);
    if(tempn==-1)
        text(w/2,w/2,'Game failed')
    end;
    nostoptot=[nostoptot nostop];
    pause(0.1);
end;
if(~isempty(nostoptot))
    for i=1:numel(nostoptot)
        text(-100,100-10*i,carplate{nostoptot(i)});
    end;
end;
end


numbers=[9 10 15 11];
w=80;
p=0.1;
t=0.25;
r=20;
g=20;
o=3;
v=(3*w/2+25)/o;%this represenets the velocity of the cars, this will (possibly later) be multiplied some coefficients later for the car to automatically adjust its speed
%the velocity is obtained from the time of the longest car to cross the
%crossroad in one orange light's time
n=sum(numbers);
info=zeros(n,5);%the first column of the array is to store the info of the directions, the second for turning left or right or going straight, the third and fourth for the sizes of the cars, the fifth for whether the car will stop at red light
posinfo=zeros(1,5);
posinfo(1)=1;posinfo(2)=posinfo(1)+numbers(1);posinfo(3)=posinfo(2)+numbers(2);posinfo(4)=posinfo(3)+numbers(3);posinfo(5)=n+1;
for i=1:4
    info(posinfo(i):posinfo(i+1)-1,1)=i;%assign the directions of the cars to the big information array
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

state=zeros(n,2);%this matrix stores the current positions of the cars
for i=1:n%generate the initial positions of each car
    switch i%first let all the cars stay out of the screen, left-turn cars stay in different lane with straight and right-turn cars
        case posinfo(1)
            state(i,1)=-w/2-100-info(i,3)/2;
            state(i,2)=-w/4;
        case posinfo(2)
            state(i,1)=w/2+100+info(i,3)/2;
            state(i,2)=w/4;
        case posinfo(3)
            state(i,1)=w/4;
            state(i,2)=-w/2-100-info(i,3)/2;
        case posinfo(4)
            state(i,1)=-w/4;
            state(i,2)=w/2+100+info(i,3)/2;
        otherwise
            state(i,1)=(info(i,1)==1)*(state(i-1,1)-info(i-1,3)/2-v-info(i,3)/2)+(info(i,1)==2)*(state(i-1,1)+info(i-1,3)/2+v+info(i,3)/2)+(info(i,1)==3)*(w/4)+(info(i,1)==4)*(-w/4);
            state(i,2)=(info(i,1)==1)*(-w/4)+(info(i,1)==2)*(w/4)+(info(i,1)==3)*(state(i-1,2)-info(i-1,3)/2-v-info(i,3)/2)+(info(i,1)==4)*(state(i-1,2)+info(i-1,3)/2+v+info(i,3)/2);
    end;
end;
tempn=n;%how many cars are still on the screen or waiting to go into the screen
second=1;
% while(tempn)
%     state(n,2,second+1)=0;%3-dimensional array state is to record the positions of all cars at all times
%     next=movement(state(:,:,second+1),w,posinfo);
%     state(:,:,second+1)=next;
%     second=second+1;
% end;
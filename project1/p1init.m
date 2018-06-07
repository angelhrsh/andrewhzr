clear all;clc;
n=input('Please input the total number of cars');
w=0;
while(w<=50)
    w=input('Please input the width of the crossroad(!:the width should be greater than 50!!)');%this should be betweee two values which I have not decided yet.(10:38AM Jun 1st 2018)
end;
p=input('Please input the probability that a car does not stop at the red light');
t=1;
while(t>0.5)
    t=input('Please input the probability for a car to turn left or right(!:this value should not be greater than 0.5!)');
end;
A=input('Please input the time of red and orange light, e.g. 10 3','s');
range=input('please input the parameter of the speed range, e.g. 0.75 1.25','s');
A=str2num(A);
r=A(1);o=A(2);g=r-o;
numbers=zeros(1,4);
range=str2num(range);
range=linspace(range(1),range(2),3);
for i=1:n
    nran=randperm(4,1);
    numbers(nran)=numbers(nran)+1;
end;
figure;
state=p1main(numbers,w,p,t,r,g,o,range);

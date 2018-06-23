clc
clear all
%[v_1,fval_1]=fminsearch(@fun,[0.6,0.6])
%[v_2,fval_2]=fminsearch(@fun,[-0.8,1])

% select different starting point
[v_1,val_1,flag_1,time_1,object_value_1]=NMS(@fun,[0.6,0.6]);
[v_2,val_2,flag_2,time_2,object_value_2]=NMS(@fun,[-0.8,1]);
[v_3,val_3,flag_3,time_3,object_value_3]=NMS(@fun,[0.5,1.7]);

% figure the contour image
[x,y]=meshgrid(-2:.01:2);
f=(y-x).^4+12*x.*y-x+y-3;
contour(x,y,f,200);
hold on

% selet some of iteration data
x_1 = object_value_1(1,1:20);  
y_1 = object_value_1(2,1:20);  
x_2 = object_value_2(1,1:20);  
y_2 = object_value_2(2,1:20);
x_3 = object_value_3(1,1:20);  
y_3 = object_value_3(2,1:20);

plot(x_1,y_1,'-or',x_2,y_2,'-*b',x_3,y_3,'-dk');

% some customization of this image
xlabel('x(1)');
ylabel('x(2)');
title('等高线及三个不同初始点的最优点迭代曲线图');

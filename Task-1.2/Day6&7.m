clc;
clear all;
close all;

M = 1;      %mass of the cart in kg
m = 0.3;    %mass of the pendulum in kg
l = 0.5;    %length of the rod in m 
g = 9.81;   %gravity 
q = (M + m) * m * l*l - (m*l)^2;

Kp = 100;
Ki = 0;
Kd = 25;

num_pend = [((m*l)/q) 0];
den_pend = [1 ((m*l^2)/q) -(((M+m)*m*g*l)/q) -((m*g*l)/ q)];
tf_pend = tf(num_pend,den_pend);
disp("The Transfer function of Pendulum :");
disp(tf_pend);

controller = pid(Kp, Ki, Kd);
closed_tf = feedback(tf_pend, controller);
disp(closed_tf);

t = 0: 0.01 : 10;
subplot(2,2,1);
impulse(closed_tf, t);
title("Impulse Response with PD: Kp = 100, Kd = 25");
grid on;

subplot(2,2,2);
step(closed_tf, t);
title("Step Response with PD: Kp = 100, Kd = 25");
grid on;

subplot(2,2,3);
pzmap(closed_tf);
title("Pole-zero map of inverted pendulum system with PD Controller");
grid on;
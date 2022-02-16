clc;
clear all;
close all;

M = 1;      %mass of the cart in kg
m = 0.3;    %mass of the pendulum in kg
l = 0.5;    %length of the rod in m 
g = 9.81;   %gravity 
q = (M + m) * m * l*l - (m*l)^2;

Kp_pd = 100;
Ki_pd = 0;
Kd_pd = 20;

Kp_pid = 100;
Ki_pid = 1;
Kd_pid = 10;


num_pend = [((m*l)/q) 0];
den_pend = [1 ((m*l^2)/q) -(((M+m)*m*g*l)/q) -((m*g*l)/ q)];
tf_pend = tf(num_pend,den_pend);
disp("The Transfer function of Pendulum :");
disp(tf_pend);

pd_controller = pid(Kp_pd, Ki_pd, Kd_pd);
closed_tf_pd = feedback(tf_pend, pd_controller);
disp(closed_tf_pd);

pid_controller = pid(Kp_pid, Ki_pid, Kd_pid);
closed_tf_pid = feedback(tf_pend, pid_controller);
disp(closed_tf_pid);

t = 0: 0.01 : 10;
subplot(2,2,1);
impulse(closed_tf_pd, t);
title("Case#6: Impulse Response with PD: Kp = 100, Kd = 30");
grid on;

subplot(2,2,2);
impulse(closed_tf_pid, t);
title("Case#6: Impulse Response with PID: Kp = 100, Ki = 10, Kd = 25");
grid on;

subplot(2,2,3);
pzmap(closed_tf_pd);
title("Case#6: Pole-zero map of inverted pendulum system with PD Controller");
grid on;

subplot(2,2,4);
pzmap(closed_tf_pid);
title("Case#6: Pole-zero map of inverted pendulum system with PID Controller");
grid on;
clear;

M = 0.5;      //mass of the cart in kg
m = 0.2;    //mass of the pendulum in kg
l = 0.3;    //length of the rod in m 
g = 9.8;   //gravity 

q = (M + m) * m * l*l - (m*l)^2;
s = %s;

pen_n = (m * l * s)/q;
pen_d = s^3 + (m * l^2 * s^2)/q - ((M + m) * m * g * l * s) - ((m * g * l)/q);
pend = syslin('c',pen_n/pen_d);
disp("The Transfer function for Pendulum is :");
disp(pend);

cart_n = ((m * l^2 * s^2) - (g * m * l) / q);
cart_d = ((s^4) + (m * l^2 * s^3)/q - ((M +m)*m * g * l * s^2)/q - (m * g * l * s)/q );
cart = syslin('c',cart_n/cart_d);
disp("The Transfer function for Cart is:");
disp(cart);

subplot(2,1,1);
plzr(cart);
title("Cart (pole zero plot ): ");
subplot(2,1,2);
plzr(pend);
title("Pendulum (pole zero plot): ");

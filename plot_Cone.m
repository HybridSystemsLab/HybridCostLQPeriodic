%close all
v2 = [0 0; 0 8; 8 8; 9 9];
hold on;
grid on;

v3 = [0 0; 0 -8; -8 -8; -9 -9];

patch('Vertices',v2,'FaceColor','black')

patch('Vertices',v3,'FaceColor','black')
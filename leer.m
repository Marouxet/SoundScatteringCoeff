angle = ET250_3D('set', 10);

moviendo = 1;
angle_current = ET250_3D('get', 0);
while angle_current ~= angle
tic 
while toc < 1; 
end; 
angle_current = ET250_3D('get', 0);
end
moviendo = 0
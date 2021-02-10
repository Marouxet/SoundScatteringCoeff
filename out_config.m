load('app_data/current.mat');

clear Writer
clear Record
clear Filename
clear file
clear Reader
clear Player_monitoreo
clear Player_grabacion
clear xlimites
clear MLSorden
clear MLSamplitud
clear MLSrepeticiones
clear transport
clear path
clear pathmain
clear path2
clear username
clear Nombre_signal
clear mls_orden
clear repet_mls
clear angle_mls
clear pointer
nChannels = 0;
flag_rec = 0;
monitoreo = 0;
matriz_filename = {};
previous_pointer = 1;
corregido_filename = {};
save('app_data/current.mat','-v6')


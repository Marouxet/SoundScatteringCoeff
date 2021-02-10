
t1=(0:length(sch{3})-1)/44100;
t2=(0:length(sch{4})-1)/44100;
% t3 = (0:length(map_f{3})-1)/44100;
% t4 = (0:length(map_f{4})-1)/44100;

% figure(1)
% plot(t3,map_f{3}/max(map_f{3}),'r',t4,map_f{4}/max(map_f{4}),'b')
% grid on
% xlabel('Tiempo [Segundos]');
% ylabel('Amplitud Normalizada');
% legend('Respuesta al impulso difusor estático', 'Respuesta al impulso difusor girando');
% xlim([0 1 ]);
% ylim([-1 1]);
% title('Banda de tercio de octava de 1kHz - 400 Hz Equivalente');

figure(1)
plot(t1,sch{3},'r',t2,sch{4},'b')
grid on
%xlabel('Tiempo [Segundos]');
%ylabel('Amplitud Normalizada [dB]');
legend('Decaimiento energético difusor estático', 'Decaimiento energético difusor girando');
%xlim([0 1 ]);
%ylim([-1 1]);
%title('Banda de tercio de octava de 1kHz - 400 Hz Equivalente');
xlim([0 1.2])
ylim([-110 10])
t5=(0:length(sch{7})-1)/44100;
t6=(0:length(sch{8})-1)/44100;
% t7 = (0:length(map_f{7})-1)/44100;
% t8 = (0:length(map_f{8})-1)/44100;
% figure(3)
% plot(t7,map_f{7}/max(map_f{7}),'R', t8,map_f{8}/max(map_f{8}),'B')
% grid on
% xlabel('Tiempo [Segundos]');
% ylabel('Amplitud Normalizada');
% legend('Respuesta al impulso difusor estático', 'Respuesta al impulso difusor girando');
% xlim([0 1 ]);
% ylim([-1 1]);
% title('Banda de tercio de octava de 1kHz - 400 Hz Equivalente');
% %hold on

figure(2)
plot(t5,sch{7},'r',t6,sch{8},'b')
grid on
%xlabel('Tiempo [Segundos]');
%ylabel('Amplitud Normalizada [dB]');
legend('Decaimiento energético difusor estático', 'Decaimiento energético difusor girando');4
xlim([0 1.2])
ylim([-110 10])
%xlim([0 1 ]);
%ylim([-1 1]);
%title('Banda de tercio de octava de 1kHz - 400 Hz Equivalente');
%hold on
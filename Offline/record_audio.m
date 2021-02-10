



Record_Chann1 = dsp.AudioFileWriter('app_data/Chann1.wav','FileFormat','WAV');
Record_Chann2 = dsp.AudioFileWriter('app_data/Chann2.wav','FileFormat','WAV');



tiempo_medicion =20; %tiempo en segundos
sr = Chan1.SampleRate;
spf = Chan1.SamplesPerFrame;
capturas = round(tiempo_medicion*sr/spf);
t = 1:tiempo_medicion*sr;

step_plot_1 = zeros(round(sr/spf),1);
step_plot_2 = zeros(round(sr/spf),1);
step_plot_3 = zeros(round(sr/spf),1);

i = 0;
j = 0;
k = 1;
while j <capturas
    
     chan1_step = step (Chan1);
     step(Record_Chann1, chan1_step);
     chan2_step  = step (Chan2);
     step(Record_Chann2, chan2_step);     
     
     i = i + 1;
     j = j + 1;
     if i < round(sr/spf)
         step_plot_1(i) = chan1_step(300,1);%Decidir qué  mostrar de cada Frame
         step_plot_2(i) = chan1_step(300,2);
         step_plot_3(i) = chan2_step(300);
     elseif i == round(sr/spf);
         step_plot_1(i) = chan1_step(300,1);
         step_plot_2(i) = chan1_step(300,2);
         step_plot_3(i) = chan2_step(300);
         subplot(3,1,1)
         plot(t((1:round(sr/spf))+round(sr/spf)*k),step_plot_1,'b')
         subplot(3,1,2)
         plot(t((1:round(sr/spf))+round(sr/spf)*k),step_plot_2,'r')
         subplot(3,1,3)
         plot(t((1:round(sr/spf))+round(sr/spf)*k),step_plot_3,'g')
         
         k = k+1;
         drawnow
         hold on
         i = 0;
     end
     

     
 
end

release(Chan1);
release(Record_Chann1);
release(Chan2);
release(Record_Chann2);


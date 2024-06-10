%calculate the voltage from line currents weighed by distance from
%electrode
total_no_neurons = 440; %perform LFP calc for these many neurons

uni_max = 25; % the maximum no. of trials and hence the upper limit for the uniform distribution
rng('default'); % to get repeatable results .. i.e. same numbers generated on every run of this code
r= randi(uni_max,total_no_neurons,1); %generate random numbers which will decide which neuron
                                      %gets which trial
save('TrialNosForNeurons_synWithH.mat','r');
%save('TrialNosForNeurons_noVGIC.mat','r');
%save('TrialNosForNeurons_synWithHfast.mat','r');



pt_coord=[0 200 0
         0 100 0
         0 0 0
         0 -100 0
         0 -200 0
         0 -250 0
         0 -300 0
         0 -400 0]*1e-6 ;  %contact points on the electrode
                                      
%matlabpool open
resistivity= 3.33; % (Ω m) uniform extracellular resistivity
sigma = 1/resistivity ;

n=8; %no of recording nodes
tstop=1545;
tcount= ((tstop) *40);



for  neuron_no = 1 : total_no_neurons  
   
   
   trialNo = r(neuron_no);
   
   
    
    filename= sprintf('neuron_%d.mat', neuron_no);
    filename
    trialNo
    load(filename); %this file contains h, R, ds
    
    Voltages = zeros(tcount,n);  
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Loop over lines
    
    for line_num=1:5160
     % line_num
        filename = sprintf('Trial_synWithH_%d/synWithH_LineCurrent_Line_num_%d.txt', trialNo, line_num-1 ); %change this for other runs.. Baseline and hfast
        %filename = sprintf('Trial_noVGIC_%d/noVGIC_LineCurrent_Line_num_%d.txt', trialNo, line_num-1 );
        %filename = sprintf('Trial_synWithHfast_%d/synWithHfast_LineCurrent_Line_num_%d.txt', trialNo, line_num-1 );
        
        fileId = fopen(filename, 'r');
        
        I = fscanf(fileId, '%f');
       
        I=I(1:tcount)*1e-9;
       % Voltages = zeros(size(pt_coord,1), 22000);

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Call the Calculation Routine

            [Voltage_segs]= get_phi_line(h(line_num,:),R(line_num,:),ds(line_num),I,sigma, pt_coord,line_num);
            
            Voltage_segs=Voltage_segs *1000 ;%convert to mV

            Voltages = Voltages + Voltage_segs; 
                      
        fclose('all');
    end %end of line_num
    
    filename = ['Results_synWithH/V_line_neuron_no_' num2str(neuron_no) '.mat']; %change this for other runs.. Baseline, noVGIC and hfast
   % filename = ['Results_noVGIC/V_line_neuron_no_' num2str(neuron_no) '.mat'];    
   % filename = ['Results_synWithHfast/V_line_neuron_no_' num2str(neuron_no) '.mat']; 
    
    save(filename, 'Voltages');
        fclose('all');
end %end for       
 
 

    
    
    
    
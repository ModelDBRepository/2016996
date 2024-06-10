clear;
clc;

%% Uncomment one of the following four to run 
 f1 = 'Results_noVGIC'
% f2 = 'Results_synWithH'
% f3 = 'Results_synWithHfast'
%f4 = 'Results_synWithHSlow'

%%


%load DiffMorphNeurons_noVGIC.mat

total_no_neurons = 440; %9400; % change this for increasedVolume

 load('V_line_neuron_no_1.mat'); 

 broadband = Voltages(1:57600,:);  %% for the first neuron, let lfp get the dimensions of Voltages
% 
% %%from 2nd neuron onwards, keep suming Voltages to lfp
% 
 for neuron_no = 2 : total_no_neurons
     
    
% 
     filename = ['V_line_neuron_no_' num2str(neuron_no) '.mat'];

     load(filename); %%load the voltages one neuron at a time 
%     
     broadband = broadband + Voltages(1:57600,:);
    
     
 end
% 


%%         

v1 = broadband(:,1);
v2 = broadband(:,2);
v3 = broadband(:,3);
v4 = broadband(:,4);
v5 = broadband(:,5);
v6 = broadband(:,6);
v7 = broadband(:,7);
v8 = broadband(:,8);

if(exist('f1','var'))
    
    save('Broadband_noVGIC.mat','broadband');
    save('v1_noVGIC.txt','v1','-ascii');
    save('v2_noVGIC.txt','v2','-ascii');
    save('v3_noVGIC.txt','v3','-ascii');
    save('v4_noVGIC.txt','v4','-ascii');
    save('v5_noVGIC.txt','v5','-ascii');
    save('v6_noVGIC.txt','v6','-ascii');
    save('v7_noVGIC.txt','v7','-ascii');
    save('v8_noVGIC.txt','v8','-ascii');
    
    smooth_noVGIC =zeros(size(broadband));
    smooth_noVGIC(:,1) = smooth(broadband(:,1),1000);
    smooth_noVGIC(:,2) = smooth(broadband(:,2),1000);
    smooth_noVGIC(:,3) = smooth(broadband(:,3),1000);
    smooth_noVGIC(:,4) = smooth(broadband(:,4),1000);
    smooth_noVGIC(:,5) = smooth(broadband(:,5),1000);
    smooth_noVGIC(:,6) = smooth(broadband(:,6),1000);
    smooth_noVGIC(:,7) = smooth(broadband(:,7),1000);
    smooth_noVGIC(:,8) = smooth(broadband(:,8),1000);
    save('smooth_noVGIC.mat','smooth_noVGIC');
    
end


if(exist('f2','var'))
    
    save('Broadband_synWithH.mat','broadband');
    save('v1_synWithH.txt','v1','-ascii');
    save('v2_synWithH.txt','v2','-ascii');
    save('v3_synWithH.txt','v3','-ascii');
    save('v4_synWithH.txt','v4','-ascii');
    save('v5_synWithH.txt','v5','-ascii');
    save('v6_synWithH.txt','v6','-ascii');
    save('v7_synWithH.txt','v7','-ascii');
    save('v8_synWithH.txt','v8','-ascii');
    
    smooth_synWithH =zeros(size(broadband));
    smooth_synWithH(:,1) = smooth(broadband(:,1),1000);
    smooth_synWithH(:,2) = smooth(broadband(:,2),1000);
    smooth_synWithH(:,3) = smooth(broadband(:,3),1000);
    smooth_synWithH(:,4) = smooth(broadband(:,4),1000);
    smooth_synWithH(:,5) = smooth(broadband(:,5),1000);
    smooth_synWithH(:,6) = smooth(broadband(:,6),1000);
    smooth_synWithH(:,7) = smooth(broadband(:,7),1000);
    smooth_synWithH(:,8) = smooth(broadband(:,8),1000);
    save('smooth_synWithH.mat','smooth_synWithH');
    
end


if(exist('f3','var'))
    
    save('Broadband_synWithHfast.mat','broadband');
    save('v1_synWithHfast.txt','v1','-ascii');
    save('v2_synWithHfast.txt','v2','-ascii');
    save('v3_synWithHfast.txt','v3','-ascii');
    save('v4_synWithHfast.txt','v4','-ascii');
    save('v5_synWithHfast.txt','v5','-ascii');
    save('v6_synWithHfast.txt','v6','-ascii');
    save('v7_synWithHfast.txt','v7','-ascii');
    save('v8_synWithHfast.txt','v8','-ascii');
    
    smooth_synWithHfast =zeros(size(broadband));
    smooth_synWithHfast(:,1) = smooth(broadband(:,1),1000);
    smooth_synWithHfast(:,2) = smooth(broadband(:,2),1000);
    smooth_synWithHfast(:,3) = smooth(broadband(:,3),1000);
    smooth_synWithHfast(:,4) = smooth(broadband(:,4),1000);
    smooth_synWithHfast(:,5) = smooth(broadband(:,5),1000);
    smooth_synWithHfast(:,6) = smooth(broadband(:,6),1000);
    smooth_synWithHfast(:,7) = smooth(broadband(:,7),1000);
    smooth_synWithHfast(:,8) = smooth(broadband(:,8),1000);
    save('smooth_synWithHfast.mat','smooth_synWithHfast');
  
end

if(exist('f4','var'))
   
    save('Broadband_synWithHSlow.mat','broadband');
    save('v1_synWithHSlow.txt','v1','-ascii');
    save('v2_synWithHSlow.txt','v2','-ascii');
    save('v3_synWithHSlow.txt','v3','-ascii');
    save('v4_synWithHSlow.txt','v4','-ascii');
    save('v5_synWithHSlow.txt','v5','-ascii');
    save('v6_synWithHSlow.txt','v6','-ascii');
    save('v7_synWithHSlow.txt','v7','-ascii');
    save('v8_synWithHSlow.txt','v8','-ascii');
    
    smooth_synWithHSlow =zeros(size(broadband));
    smooth_synWithHSlow(:,1) = smooth(broadband(:,1),1000);
    smooth_synWithHSlow(:,2) = smooth(broadband(:,2),1000);
    smooth_synWithHSlow(:,3) = smooth(broadband(:,3),1000);
    smooth_synWithHSlow(:,4) = smooth(broadband(:,4),1000);
    smooth_synWithHSlow(:,5) = smooth(broadband(:,5),1000);
    smooth_synWithHSlow(:,6) = smooth(broadband(:,6),1000);
    smooth_synWithHSlow(:,7) = smooth(broadband(:,7),1000);
    smooth_synWithHSlow(:,8) = smooth(broadband(:,8),1000);
    save('smooth_synWithHSlow.mat','smooth_synWithHSlow');
    
end








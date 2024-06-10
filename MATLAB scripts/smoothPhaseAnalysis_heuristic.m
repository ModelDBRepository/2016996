%%Calculating spike phase wrt LFP

%%changed Jan 5 2014

%%first load the appropriate broadband.mat
%%then take the somatic (v3) lfp from it
clear
oscFreq = 8  %change this for osc freq = 5 Hz!!!!!

electrode_loc = 3 % 3 for the pyramidale layer

start_index = 40000/oscFreq; %skip 1 cycle and start with the 2nd one
end_index = start_index + 40000; % go upto 1 sec which has 40000 points

 if(oscFreq == 5)
     end_index = start_index + 50000;
 end

 f1 = sprintf('Results_noVGIC')
% f2 = sprintf('Results_synWithH')
% f3 = sprintf('Results_synWithHfast')


if(exist('f1','var'))
    cd(f1);
    load('smooth_noVGIC.mat');
    v_noVGIC = smooth_noVGIC(:,electrode_loc);
    clear smooth_noVGIC;
    cd ..
    load('Smooth_Phase_Analysis_noVGIC.mat');
    trough_index_full = 2000 + index_smooth_noVGIC(:,electrode_loc); 
    v = v_noVGIC;

    popfname = sprintf('NoVGIC_PopPhaseVals_v%d.txt',electrode_loc); 
    popfname_mat = sprintf('NoVGIC_PopPhaseVals_v%d.mat',electrode_loc);

    simTimePoints = size(v_noVGIC,1);
end

if(exist('f2','var'))
    cd(f2);
    load('smooth_synWithH.mat');
    v_synWithH = smooth_synWithH(:,electrode_loc);
    clear smooth_synWithH;
    cd ..
    load('Smooth_Phase_Analysis_synWithH.mat');
    trough_index_full = 2000 + index_smooth_synWithH(:,electrode_loc); %index_synWithH(:,3);
    v = v_synWithH;

    popfname = sprintf('SynWithH_PopPhaseVals_v%d.txt',electrode_loc); 
    popfname_mat = sprintf('SynWithH_PopPhaseVals_v%d.mat',electrode_loc);
    
    simTimePoints = size(v_synWithH,1);
end
 
if(exist('f3','var'))
    cd(f3);
    load('smooth_synWithHfast.mat');
    v_synWithHfast = smooth_synWithHfast(:,electrode_loc);
    clear smooth_synWithHfast;
    cd ..
    load('Smooth_Phase_Analysis_synWithHfast.mat');
    trough_index_full = 2000 + index_smooth_synWithHfast(:,electrode_loc);
    v = v_synWithHfast;
    
    popfname = sprintf('SynWithHfast_PopPhaseVals_v%d.txt',electrode_loc); 
    popfname_mat = sprintf('SynWithHfast_PopPhaseVals_v%d.mat',electrode_loc);
    
    simTimePoints = size(v_synWithHfast,1);
end



first50ms = zeros(2000,1);
v= [first50ms ; v];




simDuration = simTimePoints/40; % the actual duraction of the simulation in ms

modFactor = 500/oscFreq; % (1000/2)/oscFreq considering [-pi, pi] 

NumCycles = floor(simDuration/(modFactor*2)); % How many cycles within the simulation time 
                                   % will be used to find the phase
                                                                                                                                                                  

trough_index = zeros(size(trough_index_full,1),1);

max_locs = zeros(oscFreq+1,1);

trough_index_times = zeros(simTimePoints,1);
max_loc_times = zeros(simTimePoints,1);

%for electrode_loc = 1 : 8
    trough_index = trough_index_full(trough_index_full>=start_index & trough_index_full<=end_index);


% Finding locations of maxima
    I = find(trough_index_full>=start_index,1)

    
    if(I==1)
        prev_trough = trough_index(1)
        current_trough = trough_index(2);
        current_trough_index =2;
    else
        prev_trough = trough_index_full(I-1)
        current_trough = trough_index(1);
        current_trough_index =I;
    end
    
    

    no_of_troughs = size(trough_index,1)

    if(oscFreq == 5)
        for i=1:no_of_troughs
             i
            [value, max_locs(i)] = max(v(prev_trough:current_trough));
            max_locs(i) = max_locs(i) + prev_trough;

            prev_trough = current_trough;


             if(I+i <= size(trough_index_full,1))
                 I+i
             current_trough = trough_index_full(I+i);
             end
        end
    end
    
        
    if(oscFreq == 8)

            for i=1:no_of_troughs+1

               [value, max_locs(i)] = max(v(prev_trough:current_trough));
                max_locs(i) = max_locs(i) + prev_trough;

                prev_trough = current_trough;
                current_trough_index = current_trough_index+1;

                if(I+i < numel(trough_index_full))
                 current_trough = trough_index_full(current_trough_index);
                end
                
                
                
            end %end of finding locs of maxima
            
            
            if(trough_index(1)<max_locs(1))
                    I = find(trough_index_full>max_locs(1));
                    trough_index = trough_index_full(I:I+7);
            end
    end
        

     %end of finding locs of maxima
    display ended
   
    trough_index_times(trough_index) = 0.1;
    
    max_loc_times(max_locs) = 0.1;
    
%end

        
%max_locs = max_locs + 2000;


pop_num_spikes = 25 * oscFreq;

pop_spike_phase = zeros(pop_num_spikes,1) + 3108;


for trial_no = 1 : 25
    
   
   trial_no
    
    %%change directory name depending on noVGIC, synWithH or withHfast
    if(exist('f1','var'))
         dirname = sprintf('Trial_withNaKdr_withoutH_%d',trial_no);
         fname = sprintf('SpikeTimes_withH_v%d.txt',electrode_loc);
    end
    
    if(exist('f2','var'))
         dirname = sprintf('Trial_hNaKdr_%d', trial_no);
         fname = sprintf('SpikeTimes_withH_v%d.txt',electrode_loc);
    end
    
    if(exist('f3','var'))
          dirname = sprintf('Trial_hfastNaKdr_%d', trial_no); 
          fname = sprintf('SpikeTimes_withHfast_v%d.txt',electrode_loc);
    end
   
    
        cd(dirname);
        
        fid = fopen(fname, 'r');
        sptimes = fscanf(fid, '%e');
        fclose(fid);
    
        sptimes_index = abs(sptimes*40); %sptimes contains values in ms.. convert them to index values
        sptimes_index = floor(sptimes_index(sptimes_index<simTimePoints));
        
        phase = zeros(oscFreq,1) + 3108;
        
        

        FirstSpikeTimes = zeros(simTimePoints,1);
        
        FirstSpike_index = zeros(oscFreq,1) + 90000 ;
        
        
        AllSpikeTimes = zeros(simTimePoints,1);
        AllSpikeTimes(sptimes_index) = 0.1;
        AllSpikes_index = zeros(size(sptimes_index,1),1);
        AllSpikes_index = sptimes_index;
        
        sptimes_v3 = sptimes_index;
         sptimes_v3 = sptimes_v3(sptimes_v3>=max_locs(1) & sptimes_v3<=max_locs(end)); %get spikes within 1 sec
        sptimes_index = sptimes_v3;
        
        num_spikes = size(sptimes_index,1)
        
        if(numel(sptimes_index)==0)
            phase = 5642;
            phase
            pop_spike_phase((trial_no*oscFreq)-7:(trial_no*oscFreq)) = 5642;
            FirstSpike_index = 90000;
            fn = sprintf('Phase_values_v%d.txt',electrode_loc); 
            fn_mat = sprintf('Phase_values_v%d.mat',electrode_loc); 
            save(fn,'phase','-ascii');
            save(fn_mat,'phase','FirstSpike_index','AllSpikes_index','FirstSpikeTimes','AllSpikeTimes','trough_index_times','trough_index','sptimes_index','max_locs','max_loc_times');
            cd .. 
            continue;
        end
        
         value = zeros(oscFreq,1);
         index = zeros(oscFreq,1);
         

        spike_num = 1;
       
        for cycle = 1 : oscFreq
            cycle
            
                 
            
%                   
%             while(spike_num < num_spikes) 
%                 if(sptimes_index(spike_num)<max_locs(cycle))
%                     spike_num = spike_num + 1;
%                 else 
%                     break
%                 end
%             end
            
              
                 
                
                 if(sptimes_index(spike_num)>=max_locs(cycle) &&   sptimes_index(spike_num)<=max_locs(cycle+1)) 
                     display first
                       phase(cycle) = ((sptimes_index(spike_num) - trough_index(cycle))/40)*(360*oscFreq/1000);
                       while((phase(cycle)<-180) && spike_num<numel(sptimes_index) &&  sptimes_index(spike_num)<=max_locs(cycle+1))
                          display second
                          spike_num = spike_num + 1;
                          phase(cycle) = ((sptimes_index(spike_num) - trough_index(cycle))/40)*(360*oscFreq/1000);
                          
                       end %%end of while
                       
                        if(phase(cycle)>=-180 && phase(cycle)<=180) %-20
                            display third
                            FirstSpikeTimes(sptimes_index(spike_num)) = 0.1;
                            FirstSpike_index(cycle) = sptimes_index(spike_num);
                           
                           
                        else 
                            display fourth
                            phase(cycle) = 5642 % this cycle doesn't have a spike.. hence store a junk value > 180
                            FirstSpike_index(cycle) = 90000; %large value to indicate no spike in this cycle
                        end
                        
                            pop_spike_phase(cycle+((trial_no-1 )*oscFreq)) = phase(cycle);

                            
                  

                       while(sptimes_index(spike_num)<=max_locs(cycle+1) && (spike_num < num_spikes)) 
                            display fifth
                           spike_num = spike_num + 1;
                            if(spike_num > num_spikes)
                                break;
                            end
                       end


                 else 
                    display sixth
                    phase(cycle) = 5642 % this cycle doesn't have a spike.. hence store a junk value > 180
                    pop_spike_phase(cycle+((trial_no-1 )*oscFreq)) = phase(cycle);
                    
                    FirstSpike_index(cycle) = 90000; %large value to indicate no spike in this cycle
                 end
            display seventh
            phase(cycle)

        end % end of cycle loop
        
            
        
            fn = sprintf('Phase_values_v%d.txt',electrode_loc); 
            fn_mat = sprintf('Phase_values_v%d.mat',electrode_loc); 
            save(fn,'phase','-ascii');
            save(fn_mat,'phase','FirstSpike_index','AllSpikes_index','FirstSpikeTimes','AllSpikeTimes','trough_index_times','trough_index','sptimes_index','max_locs','max_loc_times');
            cd .. %%go back to parent directory
    
end  %end of trials


save(popfname, 'pop_spike_phase','-ascii');
save(popfname_mat, 'pop_spike_phase');


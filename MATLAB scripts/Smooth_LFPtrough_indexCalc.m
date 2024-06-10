%%Calculating phase difference between LFPs
%Date modified: Jan 5 2015

clear
clc

oscFreq=8  %%DO NOT FORGET TO CHANGE THIS FOR A DIFFERENT FREQUENCY!!!

%% Uncomment one fo the following 4 options to run the code

 f1 = sprintf('Results_noVGIC');
% f2 = sprintf('Results_synWithH');
% f3 = sprintf('Results_synWithHfast');


%%


if(exist('f1','var'))
    cd(f1);
    load('smooth_noVGIC.mat');
    v_noVGIC = smooth_noVGIC;
    clear smooth_noVGIC;
    cd ..
    
    simTimePoints = size(v_noVGIC,1);
    
    simDuration = simTimePoints/40; % the actual duraction of the simulation in ms


    modFactor =500/oscFreq; % (1000/2)/oscFreq considering [-pi, pi] 

    NumCycles = floor(simDuration/(modFactor*2)); % How many cycles within the simulation time 
                                   % will be used to find the phase
                                   
    if(oscFreq == 5)
        NumCycles = 7
    end
    
    value = zeros(NumCycles,8);

    index_smooth_noVGIC = zeros(NumCycles,8);
    
    
    for loc = 1 : 8
    
        lowindex = 1;
        highindex_start = floor(40000/oscFreq) ; %period of 1 cycle    %floor(simDuration/NumCycles)*40;
        highindex = highindex_start ;

        for cycle = 1 : NumCycles

             if(highindex >= simTimePoints)
                    highindex = simTimePoints; %last cycle and ending point of simulation
             end

             if(lowindex >=simTimePoints)
                 continue
             end

         [value(cycle,loc),index_smooth_noVGIC(cycle,loc)] = min(v_noVGIC(lowindex:highindex,loc)); %trough corresponds to 0degrees


        index_smooth_noVGIC(cycle,loc) = index_smooth_noVGIC(cycle,loc) + lowindex;

        lowindex = index_smooth_noVGIC(cycle,loc) + (highindex_start/2);
        highindex = lowindex + floor(highindex_start);

        end
    
    end
    
    save('Smooth_Phase_Analysis_noVGIC.mat','index_smooth_noVGIC');
    save('index_smooth_noVGIC.txt','index_smooth_noVGIC','-ascii');
    
end


 if(exist('f2','var'))
  
    cd(f2);
    load('smooth_synWithH.mat');
    v_synWithH = smooth_synWithH;
    clear smooth_synWithH;
    cd ..
    
    simTimePoints = size(v_synWithH,1);
    
        simDuration = simTimePoints/40; % the actual duraction of the simulation in ms


    modFactor =500/oscFreq; % (1000/2)/oscFreq considering [-pi, pi] 

    NumCycles = floor(simDuration/(modFactor*2)); % How many cycles within the simulation time 
                                   % will be used to find the phase
                                   
    if(oscFreq == 5)
        NumCycles = 7
    end
    
     value = zeros(NumCycles,8);
    
    index_smooth_synWithH = zeros(NumCycles,8); 
    
    
    for loc = 1 : 8
    
        lowindex = 1;
        highindex_start = floor(40000/oscFreq) ; %period of 1 cycle    %floor(simDuration/NumCycles)*40;
        highindex = highindex_start ;

        for cycle = 1 : NumCycles

             if(highindex >= simTimePoints)
                    highindex = simTimePoints; %last cycle and ending point of simulation
             end

             if(lowindex >=simTimePoints)
                 continue
             end

         [value(cycle,loc),index_smooth_synWithH(cycle,loc)] = min(v_synWithH(lowindex:highindex,loc)); %trough corresponds to 0degrees


        index_smooth_synWithH(cycle,loc) = index_smooth_synWithH(cycle,loc) + lowindex;


        lowindex = index_smooth_synWithH(cycle,loc) + (highindex_start/2);
        highindex = lowindex + floor(highindex_start);

        end

     end
    
    save('Smooth_Phase_Analysis_synWithH.mat','index_smooth_synWithH');
    save('index_smooth_synWithH.txt','index_smooth_synWithH','-ascii');
    
end

if(exist('f3','var'))

    cd(f3);
    load('smooth_synWithHfast.mat');
    v_synWithHfast = smooth_synWithHfast;
    clear smooth_synWithHfast;
    cd ..
    
    simTimePoints = size(v_synWithHfast,1);
    
    simDuration = simTimePoints/40; % the actual duraction of the simulation in ms


    modFactor =500/oscFreq; % (1000/2)/oscFreq considering [-pi, pi] 

    NumCycles = floor(simDuration/(modFactor*2)); % How many cycles within the simulation time 
                                   % will be used to find the phase
                                   
    if(oscFreq == 5)
        NumCycles = 7
    end
    
     value = zeros(NumCycles,8);
     
     index_smooth_synWithHfast = zeros(NumCycles,8);
     
     for loc = 1 : 8
    
        lowindex = 1;
        highindex_start = floor(40000/oscFreq) ; %period of 1 cycle    %floor(simDuration/NumCycles)*40;
        highindex = highindex_start ;

        for cycle = 1 : NumCycles

             if(highindex > simTimePoints)
                    highindex = simTimePoints; %last cycle and ending point of simulation
             end

            if(lowindex >=simTimePoints)
                continue
            end

         [value(cycle,loc),index_smooth_synWithHfast(cycle,loc)] = min(v_synWithHfast(lowindex:highindex,loc)); %trough corresponds to 0degrees


        index_smooth_synWithHfast(cycle,loc) = index_smooth_synWithHfast(cycle,loc) + lowindex;

        lowindex = index_smooth_synWithHfast(cycle,loc) + (highindex_start/2);
        highindex = lowindex + floor(highindex_start);

        end

    end

     save('Smooth_Phase_Analysis_synWithHfast.mat','index_smooth_synWithHfast');
    save('index_smooth_synWithHfast.txt','index_smooth_synWithHfast','-ascii');

     
end



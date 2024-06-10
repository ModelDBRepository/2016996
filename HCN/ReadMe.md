Run HCN_Rin.hoc to compute the input resistance along the trunk of the morphology n123

Run HCN_Zap.hoc to compute the local and transfer voltage response to a chirp stimulus. The resultant files from this code will be used to compute the local and transfer impedance phase and resonance frequency.

Create 25 folders with the name "Trial_hNaKdr_i" where i is the trial number from 1 to 25.
Run spikes_withH.hoc to compute the spike timings. Change the value of variable "trialNo" from 1 to 25 to change the synaptic distribution.

Create 25 folders with the name "Trial_synWithH_i" where i is the trial number from 1 to 25
Similarly, run HCN_TotalCurrent.hoc with different trialNo values (1 to 25) to compute the total currents in each compartment.

Then run HCN_LineCurrent.hoc (again with different trialNo values) to compute the line currents for each line segment in the morphology. These line currents will be used by the MATLAB code to compute the LFPs.



HCN Plasticity:

Change the value of the variable gh to 55 or 160 for the two HCN conductance plasticity simulations.

For simulations on v1/2 of activation of HCN channels, in the procedure gh_gradient() after computing the value of vhalf_hd(x) for the SectionList Trunk, do the following: 

	forsec Trunk{
	vhalfl_hd(x)=vhalfl_hd(x)-5
	}

and at the end of the procedure, make the following changes in the blocks “soma” and Basal: 

	forsec "soma" {
        ghdbar_hd=gh vhalfl_hd=-82-5
	}	
    
	forsec Basal {
        ghdbar_hd=gh vhalfl_hd=-82-5
	}	 

The code shown above is for hyperpolarization of v1/2 of activation by 5 mV. Change -5 to +5 for the depolarization plasticity simulations.



Synaptic scaling:

To change the unitary epsp amplitude at the soma to 4.3 µV, change gexFac to 1 and for 5.4 µV, change gexFac to 0.8

To change gin, multiply gin by 0.5 or 2 to run simulations with gin = 50 pS or 200 pS respectively.

To change the phase difference between excitation and inhibition, change phi to 0 (for zero deg) and to –PI/3 for (–60 deg)




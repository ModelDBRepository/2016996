Create 25 folders with the name "Trial_hfastNaKdr_i" where i is the trial number from 1 to 25.

Run spikes_withHfast.hoc to compute the spike timings. Change the value of variable "trialNo" from 1 to 25 to change the synaptic distribution.


Create 25 folders with the name "Trial_synWithHfast_i" where i is the trial number from 1 to 25.
Similarly, run FastHCN_TotalCurrent.hoc with different trialNo values (1 to 25) to compute the total currents in each compartment.

Then run FastHCN_LineCurrent.hoc (again with different trialNo values) to compute the line currents for each line segment in the morphology. These line currents will be used by the MATLAB code to compute the LFPs.

HCNFast plasticity:

Change the value of the variable gh to 12 or 65 for the two HCNFast conductance plasticity simulations.


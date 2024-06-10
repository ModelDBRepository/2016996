Create 25 folders with the name "Trial_withNaKdr_withoutH_i" where i is the trial number from 1 to 25.

Run spikes_noVGIC.hoc to compute the spike timings. Change the value of variable "trialNo" from 1 to 25 to change the synaptic distribution.


Create 25 folders with the name "Trial_noVGIC_i" where i is the trial number from 1 to 25.
Similarly, run noVGIC_TotalCurrent.hoc with different trialNo values (1 to 25) to compute the total currents in each compartment.

Then run noVGIC_LineCurrent.hoc (again with different trialNo values) to compute the line currents for each line segment in the morphology. These line currents will be used by the MATLAB code to compute the LFPs.


Synaptic scaling:

To change the unitary epsp amplitude at the soma to 4.3 µV, change gexFac to 1 and for 5.4 µV, change gexFac to 0.8

To change gin, multiply gin by 0.5 or 2 to run simulations with gin = 50 pS or 200 pS respectively.

To change the phase difference between excitation and inhibition, change phi to 0 (for zero deg) and to –PI/3 for (–60 deg)

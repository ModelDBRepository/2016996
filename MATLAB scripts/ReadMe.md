1) Compute indivudual neuron contribution to LFP using codes in the folder called Mat.

2) Sum up the LFP using Final_Sum.m

3) Run Smooth_LFPtrough_indexCalc.m to compute the troughs of the LFPs. These will be used for computing LFP phase.

4) To compute spike phase coherence, use All_spikes_phase.m to find the phase of all spikes in 1 sec time window.

5) To compute first spike phase within a time window sec, use smoothPhaseAnalysis_heuristic.m. The spike phases computed using this will be used for computing spike phase difference.
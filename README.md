# Final-Project-7770
The 4 NetLogo code files are stored in 
  Reynolds Notch-Delta.nlogo (the original model that all the work in this project is based on)
  Static Differentiation Cascade.nlogo (the simulation of the Morsut et al. 3 layer cascade)
  Static Differentiation Pulse.nlogo (the simulation of the new pulse circuit structure)
  Simple Cadherin.nlogo (the implementation of the random walking Cadherin cells which self assemble into a ball)
  
The 3 movie files are stored in
  MorsutStaticDifferentiationCascade.mp4 (shows a single green cell causing a 3 layer system to form)
  Static Differentiation Pulse.nlogo (shows a single green cell propagating a 3 layer pulse until it hits the wall)
  SimpleCadherin.mp4 (shows a random spread of cadherin expressing cells self assembling into set of nuclei in a sea on nonexpressing cells)
  
One note about running NetLogo code:
  Many user-set variables in netlogo are derived directly from the GUI. This makes it difficult to 
  run a new model from the txt code in the code tab alone. All the models given here have GUI variables
  so they must be run directly from the NetLogo files given.
  
  To run any of these NetLogo models, simply start by clicking the setup button on the left. Then click on and of the go buttons.
  Go-x runs the model for x ticks. Go with the spiral arrows runs the code until clicked again. 
  
  For the sliders and GUI variables:
  
  For all simulations, the initial-rate slider indicates the base rate of transcription of the protein per cell per tick in percentage points. The sender-cells slider indicates the number of sender cells you want in the simulation. The diffusion time and activation time sliders indicate how long it takes for cleaved notch to return to the nucleus and how long delta has to be in the membrane before it can being cleavage.
  
  For Static Differentiation Pulse.nlogo, the repressor strength sliders indicate how much each repressor reduces the rate of transcription of the protein in percentage points
  
  For Simple Cadherin.nlogo, the Cadherin-Energy slider indicates how much relative energy a single coarse-grained cadherin bind has. It is roughly equivalent to U/kbT for the Metropolis method.

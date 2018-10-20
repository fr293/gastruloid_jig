# gastruloid_jig
CAD for the 2018 BioMakerChallenge- a device for holding pogo pins to cast wells in agarose for gastruloid culture.

There are three design files required to generate the geometry of the device. These design files are supported by two libraries, all written in OpenSCAD.

The design files are as follows:

lid- The top of the device, which houses the pogo pins.
base- The base of the device, which is threaded to match the lid.
indenter_jig_Parameters- This holds parameters common to both the lid and base components.

The libraries are as follows:

threads- provides ISO standard thread dimensions.
knurledFinishLib_v2- provides a knurled service for the lid.

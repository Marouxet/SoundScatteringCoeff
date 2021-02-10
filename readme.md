# Measuring Sound Scattering Coefficient in Random Incidence - ISO 17497-1


This software is the result of my degree thesis for _became_ a sound engineer in the University of Tres de Febrero (Argentina).
It is made fully in MATLAB and was tested under 2013b version. It has now some obsolet dependencies, from the Signal Processing Toolbox. It wont work with newer versions.

[Full thesis document is available in ResearchGate](https://www.researchgate.net/publication/299227485_Software_development_for_measuring_random_incidence_scattering_coefficient_ISO_17497_-_1)

questions? marianoarouxet@gmail.com

## Thesis Abstract:

Several previous investigations have pointed out the importance of including surface scattering coefficients, complying with ISO 17497-1, to geometrical acoustic models. However, measurement of this coefficient is usually a complex and time-consuming task. In order to simplify this procedure, a software is designed to measure random incidence sound scattering coefficient in a reverberation room and developed. It includes sound
signal generation (log sine sweeps and MLS sequences), multichannel sound reproduction and recording (using ASIO protocol), turntable handling using computer network, and user guiding during measurements. This software automatically processes the recorded signals, by phased locked averaging in each octave band from 31.5 to 16000 Hz. Applying a noise correction algorithm it calculates the energy decay curves from the impulse response measurement. Absorption and scattering coefficients can be directly deduced from this proceeding. Current software version is then tested on a self-design diffuser in a reverberation room. Measurements are showing interesting time saving results and a correct evaluation of the scattering coefficient

## To run

run maininterface.m

## To verify in this repo:

* Folder "offline" is suppose to be out-of-date and could be deleted



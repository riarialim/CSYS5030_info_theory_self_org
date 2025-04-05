# CSYS5030 Information Theory and Self-Organisation
This unit explores the fundamental concepts of information theory and its role in the emergence of structure in complex systems. 
Topics include entropy, mutual information, transfer entropy, active information storage, and their applications in natural and artificial systems. Students engage in quantitative analysis to study self-organisation and information dynamics.

## Project: Information-Theoretic Analysis of J.S. Bach’s St Matthew Passion
### Summary
* Type: Individual project
* Objective: Analyse the flow and storage of information in musical sequences by applying information-theoretic measures to chorales from St Matthew Passion by J.S. Bach.

### Problem:
* Can we quantify how much predictive information is stored within a voice part (e.g. Soprano) and how much additional information is transferred from other voice parts (e.g. Alto, Tenor, Bass) in a choral composition?

### Solution:
* Preprocessed 13 choral movements using Python and the Music21 toolkit to align, center, and symbolise musical note sequences across Soprano, Alto, Tenor, and Bass.
* Used Active Information Storage (AIS) to quantify how much a voice's own history contributes to its next note prediction.
* Used Transfer Entropy (TE) to measure how much other voices contribute to the predictability of the target voice (Soprano).
* Conducted experiments with AIS and TE using JIDT (Java Information Dynamics Toolkit) in MATLAB, selecting an optimal history length of 4 (quarter-note duration).
* Visualised local AIS and TE over time, highlighting moments of strong self-predictability and information transfer between voice parts.

### Tools & Technologies
* Preprocessing & Symbol Mapping: Python, Music21
* Information Measures: MATLAB, JIDT (Java toolkit)
* Measures Applied
    * Active Information Storage (AIS)
    * Transfer Entropy (TE)
* Target Movement: BWV244.29-a ("The Arrest of Jesus")
* Data Source: [music21/corpus/bach](https://gitub.u-bordeaux.fr/scrime/tabasco/music21/-/tree/tabasco-version/music21/corpus/bach?ref_type=heads) – St Matthew Passion Chorales (bwv244)
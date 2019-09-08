# PoliGPS
PoliGPS is an algorithm able to solve a Multi-Objective Minimum Path Problem. The mathematical model relies completely on "A multi-objective time-dependent route planner: a real world application to Milano city" (2014) by Bruglieri et al. 
The codes are completely programmed by me and are available under the GNU General Public License v3.

# How to use the code 
The main code is under the name: PoliGPS.m. It is a MATLAB function that takes into account some information (such as the origin ID, the destination ID etc.) and it returns the path from the origin to the destination with the lowest cost. 
The data structures are well-defined and they must be as follows:
- The nodes matrix should have three columns: the first one with the nodes ID names, the second one with their coordinates versus the x axis and the third one with their coordinates versus the y axis
- The arcs matrix should have two columns: the first one with the tail node ID (starting point) and the second one with the head node ID (ending point)
- The forbidden turns should have three columns: the first one indicates a node ID before the crossing, the second one indicates the node ID where the crossing occurs and the last one indicates which node it is NOT possible to reach from the previously defined arch (p,q,r).

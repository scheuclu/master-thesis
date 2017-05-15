#meshgen
This folder contains all mesh-generating input-files(gmsh-geo) files.

##FILES

### [nacanodes.txt](nacanodes.txt)
Contains coordinated of the naca-profile nodes. This file is generated via the matlab script in the folder above. The script is generic and can generate any four-digit NACA profile with an arbitrary mesh size.

### [fluid_volume_template.geo](fluid_volume_template.geo)
Generates the fluid volume. The nacaprofile is used as an Attractor, such that the mesh will be finer in aereas close to the profile.

### [embedded_surface_template.geo](embedded_surface_template.geo)
GEnerates a mesh for the embedded surface, based on the nodes provided by [nacanodes.txt](nacanodes/txt). 

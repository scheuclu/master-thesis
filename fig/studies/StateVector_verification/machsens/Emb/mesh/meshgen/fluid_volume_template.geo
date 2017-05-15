<nacanodes>

linelist = {};
For j In {1 : <numnodes>-1}
  Line(j) = {j, j+1};
  linelist += {j};
EndFor
Line(<numnodes>)={<numnodes>,1};
linelist+={<numnodes>};


Point(1000) = {0.0, 0.0, 0.0, <msizefarfield>};
Point(1001) = {0.0,-<size_farfield>, 0.0, <msizefarfield>};
Point(1002) = {-<size_farfield>, 0.0, 0.0, <msizefarfield>};
Point(1003) = {0.0, <size_farfield>, 0.0, <msizefarfield>};
Point(1004) = {<size_farfield>, 0.0, 0.0, <msizefarfield>};

Circle(2001) = {1001,1000,1002};
Circle(2002) = {1002,1000,1003};
Circle(2003) = {1003,1000,1004};
Circle(2004) = {1004,1000,1001};


Line Loop(2005)={2001,2002,2003,2004};
Line Loop(2006)={linelist[]};

Plane Surface(3001) = {2005};


Field[2] = Attractor;
Field[2].NNodesByEdge = 200;
Field[2].EdgesList = {linelist[]};

Field[3] = Threshold;
Field[3].IField = 2;
Field[3].LcMin = <msizesurface>;//cl/2;
Field[3].LcMax = <msizefarfield>;//cl_bg;
Field[3].DistMin = 0.01;
Field[3].DistMax = 12;
Field[3].Sigmoid = 0;

Background Field = 3;

Mesh.SurfaceNumbers = 0;



surfaceextrude[]=Extrude {0, 0, <thickness>} {
  Surface{3001};Layers{1};
};

Physical Volume("FluidMesh")={surfaceextrude[1]};
Physical Surface("InletFixedSurface")={surfaceextrude[2],surfaceextrude[3],surfaceextrude[4],surfaceextrude[5]};
Physical Surface("SymmetrySurface",9)={3001,surfaceextrude[0]};


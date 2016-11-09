DefineConstant[ total_x = {8, Min 0, Max 120, Step 1,
                         Name "1_Total size/size x"} ];

DefineConstant[ total_y = {8, Min 0, Max 120, Step 1,
                         Name "1_Total size/size y"} ];

DefineConstant[ numele_x_per_sub = {1, Min 1, Max 1200, Step 1,
                         Name "2_NumEle/numele x per sub"} ];

DefineConstant[ numele_y_per_sub = {1, Min 1, Max 1200, Step 1,
                         Name "2_NumEle/numele y per sub"} ];

DefineConstant[ numsubs_x = {8, Min 1, Max 1200, Step 1,
                         Name "3_NumSub/numsubs x"} ];

DefineConstant[ numsubs_y = {8, Min 1, Max 1200, Step 1,
                         Name "3_NumSub/numsubs y"} ];

DefineConstant[ tag_pattern1 = {99, Min 1, Max 9999, Step 1,
                         Name "4_Tags/tag_pattern1"} ];

DefineConstant[ tag_pattern2 = {101, Min 1, Max 9999, Step 1,
                         Name "4_Tags/tag_pattern2"} ];

DefineConstant[
  patterntype = {1, Choices{0,1,2},Name "5_Patterntype/Pattern type"}];
  
DefineConstant[
  quadmesh = {1, Choices{0,1},Name "6_Mesh/QuadMesh"}];


width_per_subdomain =total_x/numsubs_x;
height_per_subdomain=total_y/numsubs_y;

lineright = {};
lineleft={};
linebottom= {};
linetop={};


// grid_size = width_per_subdomain/numele_x_per_sub;
grid_size = (total_x/numsubs_x)/numele_x_per_sub;
Point(1) = {0,0,0,grid_size};
Point(2) = {width_per_subdomain,0,0,grid_size};
Line(1) = {1,2};

linebottom += {1};

newsurf_0[0] = 1;

pattern1 = {};
pattern2 = {};




If (quadmesh == 0)
  //Loop in y direction
  For i In {1:numsubs_y}
    newsurf~{i}[] = Extrude{0,height_per_subdomain,0}{Line{newsurf~{i-1}[0]}; Recombine;};
    horsurf_0[0] = newsurf~{i}[2];
    
    If(i==numsubs_y)
     linetop+= {newsurf~{i}[0]};
    EndIf
    
    lineleft+= {Fabs(newsurf~{i}[3])};

    //horizontal stripes
    If (patterntype == 1)
      If (i%2 == 0)
        pattern1 += {newsurf~{i}[]};
      EndIf
      If (i%2 == 1)
        pattern2 += {newsurf~{i}[]};
      EndIf
    EndIf
    
    //checkerboard pattern
    If (patterntype == 0)
      If ((i+0)%2 == 0)
        pattern1 += {newsurf~{i}[]};
      EndIf
      If ((i+0)%2 == 1)
        pattern2 += {newsurf~{i}[]};
      EndIf
    EndIf
    
    
    //Loop in x direction
    For j In {1:numsubs_x-1}
      horsurf~{j}[] = Extrude {width_per_subdomain ,0,0}
  //        {Line{horsurf~{j-1}[0]}; Layers{numele_x_per_sub}; Recombine;};
          {Line{horsurf~{j-1}[0]}; Recombine;};
  //     subdomains~{i}~{j+1} = horsurf~{j}[1];
      
      If(i==1)
       linebottom+= {Fabs(horsurf~{j}[3])};
      EndIf
      
      If(i==numsubs_y)
       linetop+= {horsurf~{j}[2]};
      EndIf
      
      If(j==numsubs_x-1)
       lineright+= {Fabs(horsurf~{j}[0])};
      EndIf
      
      //horizontal stripes
      If (patterntype == 1)
        If (i%2 == 0)
          pattern1 += {horsurf~{j}[1]};
        EndIf
        If (i%2 == 1)
          pattern2 += {horsurf~{j}[1]};
        EndIf
      EndIf
      
      //vertical stripes
      If (patterntype == 2)
        If (j%2 == 1)
          pattern1 += {horsurf~{j}[1]};
        EndIf
        If (j%2 == 0)
          pattern2 += {horsurf~{j}[1]};
        EndIf
      EndIf
      
      //checkerboard pattern
      If (patterntype == 0)
        If ((i+j)%2 == 0)
          pattern1 += {horsurf~{j}[1]};
        EndIf
        If ((i+j)%2 == 1)
          pattern2 += {horsurf~{j}[1]};
        EndIf
      EndIf

    EndFor
    
  EndFor
EndIf


If (quadmesh == 1)
  //Loop in y direction
  For i In {1:numsubs_y}
    newsurf~{i}[] = Extrude{0,height_per_subdomain,0}{Line{newsurf~{i-1}[0]}; Layers{numele_y_per_sub}; Recombine;};
    horsurf_0[0] = newsurf~{i}[2];
    
    If(i==numsubs_y)
     linetop+= {Fabs(newsurf~{i}[0])};
    EndIf
    
    lineleft+= {Fabs(newsurf~{i}[3])};

    //horizontal stripes
    If (patterntype == 1)
      If (i%2 == 0)
        pattern1 += {Fabs(newsurf~{i}[1])};
      EndIf
      If (i%2 == 1)
        pattern2 += {Fabs(newsurf~{i}[1])};
      EndIf
    EndIf
    
    //checkerboard pattern
    If (patterntype == 0)
      If ((i+0)%2 == 0)
        pattern1 += {Fabs(newsurf~{i}[1])};
      EndIf
      If ((i+0)%2 == 1)
        pattern2 += {Fabs(newsurf~{i}[1])};
      EndIf
    EndIf
    
    
    //Loop in x direction
    For j In {1:numsubs_x-1}
      horsurf~{j}[] = Extrude {width_per_subdomain ,0,0}
        {Line{horsurf~{j-1}[0]}; Layers{numele_x_per_sub}; Recombine;};
      
      If(i==1)
       linebottom+= {Fabs(horsurf~{j}[3])};
      EndIf
      
      If(i==numsubs_y)
       linetop+= {Fabs(horsurf~{j}[2])};
      EndIf
      
      If(j==numsubs_x-1)
       lineright+= {Fabs(horsurf~{j}[0])};
      EndIf
      
      //horizontal stripes
      If (patterntype == 1)
        If (i%2 == 0)
          pattern1 += {Fabs(horsurf~{j}[1])};
        EndIf
        If (i%2 == 1)
          pattern2 += {Fabs(horsurf~{j}[1])};
        EndIf
      EndIf
      
      //vertical stripes
      If (patterntype == 2)
        If (j%2 == 1)
          pattern1 += {Fabs(horsurf~{j}[1])};
        EndIf
        If (j%2 == 0)
          pattern2 += {Fabs(horsurf~{j}[1])};
        EndIf
      EndIf
      
      //checkerboard pattern
      If (patterntype == 0)
        If ((i+j)%2 == 0)
          pattern1 += {Fabs(horsurf~{j}[1])};
        EndIf
        If ((i+j)%2 == 1)
          pattern2 += {Fabs(horsurf~{j}[1])};
        EndIf
      EndIf

    EndFor
    
  EndFor
EndIf

vertexbottomleft={1};
vertexbottomright={2*(numsubs_x+1)-1};

Geometry.LabelType=2;
//PrintGeoLabels=1;
Geometry.SurfaceNumbers=1;
Geometry.LineNumbers=1;
Geometry.PointNumbers=1;
Mesh.SurfaceFaces=1;
Solver.ShowInvisibleParameters=1;

Physical Surface("surfaces_pattern_1",tag_pattern1) = pattern1[];
Physical Surface("surfaces_pattern_2",tag_pattern2) = pattern2[];

Physical Point("xy dirichlet point",1)  = vertexbottomleft[];
Physical Line("x dirichlet line",2)     = lineleft[];
Physical Line("neumannline",4)  = lineright[];

allsurface={pattern1[],pattern2[]};
// Physical Line("y neumann ",3)           = tag_pattern1[];
// Physical Surface("surface material steel",4) = {tag_pattern1[],tag_pattern2[]} ;

// vim: set filetype=gmsh :  //

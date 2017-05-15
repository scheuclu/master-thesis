msize_far=1.0;
msize_circle=0.1;


rad_circle=1.0;

size_square=3.0;

Point(1) = {-rad_circle, 0, 0, msize_circle};
Point(2) = {0.0, -rad_circle, 0, msize_circle};
Point(3) = {rad_circle, 0, 0.0, msize_circle};
Point(4) = {0.0, rad_circle, 0, msize_circle};
Point(10) = {0.0, 0.0, 0, msize_circle};

Circle(1) = {1, 10, 2};
Circle(2) = {2, 10, 3};
Circle(3) = {3, 10, 4};
Circle(4) = {4, 10, 1};


Point(5)={-size_square,-size_square,0,msize_far};
Point(6)={ size_square,-size_square,0,msize_far};
Point(7)={ size_square, size_square,0,msize_far};
Point(8)={-size_square, size_square,0,msize_far};
Line(5) = {8, 5};
Line(6) = {5, 6};
Line(7) = {6, 7};
Line(8) = {7, 8};

Line Loop(9) = {5, 6, 7, 8};
Plane Surface(10) = {9};

Field[2] = Attractor;
Field[2].NNodesByEdge = 2;
Field[2].EdgesList = {1,2,3,4};

Field[3] = Threshold;
Field[3].IField = 2;
Field[3].LcMin = 0.1;//cl/2;
Field[3].LcMax = 0.5;//cl_bg;
Field[3].DistMin = 0.01;
Field[3].DistMax = 2;
Field[3].Sigmoid = 0;

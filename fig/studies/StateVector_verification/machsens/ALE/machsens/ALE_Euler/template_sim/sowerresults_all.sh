#/usr/bin/bash!

SOWER_EXECUTABLE=/home/pavery/bin/sower



for item in Density Mach Pressure Temperature TotalPressure VelocityNorm Velocity Meshdisp StateVector; do
#for item in DensitySensitivity; do
# Postprocess fluid solution plus
$SOWER_EXECUTABLE -fluid -merge -con ../mesh/mesh_ref.con -mesh ../mesh/mesh_ref.msh -result ./results/${item}_plus -output ./results/xpost/${item}_plus -precision 15
$SOWER_EXECUTABLE -fluid -merge -con ../mesh/mesh_ref.con -mesh ../mesh/mesh_ref.msh -result ./results/${item}_minus -output ./results/xpost/${item}_minus -precision 15
done

#$SOWER_EXECUTABLE -fluid -merge -con ../mesh/mesh_ref.con -mesh ../mesh/mesh_ref.msh -result ./rst/naca_steady.sol -output ./results/xpost/SteadySolutionolution

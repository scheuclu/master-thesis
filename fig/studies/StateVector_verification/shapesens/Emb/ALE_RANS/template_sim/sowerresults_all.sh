#/usr/bin/bash!

SOWER_EXECUTABLE=/home/pavery/bin/sower



for item in NuTilde Density Mach Pressure Temperature TotalPressure VelocityNorm Velocity Meshdisp StateVector FluidID; do
#for item in DensitySensitivity; do
# Postprocess fluid solution plus
$SOWER_EXECUTABLE -fluid -merge -con ../../../mesh/sower/fluid_sowered.con -mesh ../../../mesh/sower/fluid_sowered.msh -result ./results/${item}_plus -output ./results/xpost/${item}_plus -precision 15
$SOWER_EXECUTABLE -fluid -merge -con ../../../mesh/sower/fluid_sowered.con -mesh ../../../mesh/sower/fluid_sowered.msh -result ./results/${item}_minus -output ./results/xpost/${item}_minus -precision 15
done

for item in FluidID; do
$SOWER_EXECUTABLE -fluid -merge -con ../../../mesh/sower/fluid_sowered.con -mesh ../../../mesh/sower/fluid_sowered.msh -result ./results/${item} -output ./results/xpost/${item}_plus -precision 15
done

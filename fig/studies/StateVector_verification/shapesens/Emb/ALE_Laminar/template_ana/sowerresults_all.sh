#/usr/bin/bash!

SOWER_EXECUTABLE=/home/pavery/bin/sower

../../../mesh/sower/fluid_sowered.con

for item in DensitySensitivity MeshdispSensitivity EddyViscositySensitivity MachSensitivity NuTildeSensitivity StateVectorSensitivity TemperatureSensitivity TotalPressureSensitivity VelocityNormSensitivity VelocitySensitivity LinSolveRHS dFdS_final; do
#for item in DensitySensitivity; do
# Postprocess fluid solution plus
$SOWER_EXECUTABLE -fluid -merge -con ../../../mesh/sower/fluid_sowered.con -mesh ../../../mesh/sower/fluid_sowered.msh -result ./results/${item}_direct -output ./results/xpost/${item}_direct
$SOWER_EXECUTABLE -fluid -merge -con ../../../mesh/sower/fluid_sowered.con -mesh ../../../mesh/sower/fluid_sowered.msh -result ./results/${item}_adjoint -output ./results/xpost/${item}_adjoint
done

for item in Density Velocity Pressure FluidID; do
$SOWER_EXECUTABLE -fluid -merge -con ../../../mesh/sower/fluid_sowered.con -mesh ../../../mesh/sower/fluid_sowered.msh -result ./results/${item} -output ./results/xpost/${item}
done

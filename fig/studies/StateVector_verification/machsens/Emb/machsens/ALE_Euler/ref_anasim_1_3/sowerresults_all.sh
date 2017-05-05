#/usr/bin/bash!

SOWER_EXECUTABLE=/home/pavery/bin/sower


for item in dFdS_final dFdS_viscous dFdS_inviscid DensitySensitivity MeshdispSensitivity MachSensitivity NuTildeSensitivity VelocitySensitivity PressureSensitivity StateVectorSensitivity TemperatureSensitivity TotalPressureSensitivity VelocityNormSensitivity; do
# Postprocess fluid solution plus
echo ${item}
$SOWER_EXECUTABLE -fluid -merge -con ../../../mesh/sower/fluid_sowered.con -mesh ../../../mesh/sower/fluid_sowered.msh -result ./results/${item}_direct -output ./results/xpost/${item}_direct
$SOWER_EXECUTABLE -fluid -merge -con ../../../mesh/sower/fluid_sowered.con -mesh ../../../mesh/sower/fluid_sowered.msh -result ./results/${item}_adjoint -output ./results/xpost/${item}_adjoint
done

for item in Density Velocity Pressure FluidID; do
$SOWER_EXECUTABLE -fluid -merge -con ../../../mesh/sower/fluid_sowered.con -mesh ../../../mesh/sower/fluid_sowered.msh -result ./results/${item} -output ./results/xpost/${item}
done

$SOWER_EXECUTABLE -fluid -merge -con ../../../mesh/sower/fluid_sowered.con -mesh ../../../mesh/sower/fluid_sowered.msh -result ./rst/naca_steady.sol -output ./results/xpost/SteadySolution

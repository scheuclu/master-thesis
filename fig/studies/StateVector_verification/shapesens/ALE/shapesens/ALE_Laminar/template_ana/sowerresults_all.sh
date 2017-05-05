#/usr/bin/bash!

SOWER_EXECUTABLE=/home/pavery/bin/sower



for item in DensitySensitivity MeshdispSensitivity EddyViscositySensitivity MachSensitivity NuTildeSensitivity StateVectorSensitivity TemperatureSensitivity TotalPressureSensitivity VelocityNormSensitivity VelocitySensitivity LinSolveRHS dFdS_final; do
#for item in DensitySensitivity; do
# Postprocess fluid solution plus
$SOWER_EXECUTABLE -fluid -merge -con ../mesh/mesh_ref.con -mesh ../mesh/mesh_ref.msh -result ./results/${item}_direct -output ./results/xpost/${item}_direct
$SOWER_EXECUTABLE -fluid -merge -con ../mesh/mesh_ref.con -mesh ../mesh/mesh_ref.msh -result ./results/${item}_adjoint -output ./results/xpost/${item}_adjoint
done

$SOWER_EXECUTABLE -fluid -merge -con ../mesh/mesh_ref.con -mesh ../mesh/mesh_ref.msh -result ./rst/naca_steady.sol -output ./results/xpost/SteadySolution
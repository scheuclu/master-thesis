#!/bin/bash
XP2EXO_EXECUTABLE=/home/pavery/bin/xp2exo

sed -i 's/Vector /Vector6 /g' ./results/xpost/StateVector*

for method in direct; do

sed -i 's/Vector /Vector6 /g' results/xpost/dFdS_final_${method}.xpost
sed -i 's/Vector /Vector6 /g' results/xpost/LinSolveRHS_${method}.xpost
$XP2EXO_EXECUTABLE ../mesh/naca.top \
                   ./results/exo/all_quantities_${method}.exo \
                   results/xpost/DensitySensitivity_${method}.xpost \
                   results/xpost/MeshdispSensitivity_${method}.xpost \
                   results/xpost/MachSensitivity_${method}.xpost \
                   results/xpost/NuTildeSensitivity_${method}.xpost \
                   results/xpost/StateVectorSensitivity_${method}.xpost \
                   results/xpost/TemperatureSensitivity_${method}.xpost \
                   results/xpost/TotalPressureSensitivity_${method}.xpost \
                   results/xpost/VelocityNormSensitivity_${method}.xpost \
                   results/xpost/VelocitySensitivity_${method}.xpost \
                   results/xpost/dFdS_final_${method}.xpost
done



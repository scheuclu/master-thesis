#!/bin/bash
XP2EXO_EXECUTABLE=/home/pavery/bin/xp2exo

sed -i 's/Vector /Vector6 /g' results/xpost/StateVectorSensitivity.xpost

$XP2EXO_EXECUTABLE ../../../mesh/runmesh/fluid_volume.top \
                   ./results/exo/all_quantities.exo \
                   results/xpost/DensitySensitivity.xpost \
                   results/xpost/MachSensitivity.xpost \
                   results/xpost/Meshdisp_plus.xpost \
                   results/xpost/PressureSensitivity.xpost \
                   results/xpost/TemperatureSensitivity.xpost \
                   results/xpost/TotalPressureSensitivity.xpost \
                   results/xpost/VelocityNormSensitivity.xpost \
                   results/xpost/StateVectorSensitivity.xpost \
                   results/xpost/VelocitySensitivity.xpost \
                   results/xpost/FluidIDSensitivity.xpost \
                   results/xpost/FluidID_plus.xpost \
                   results/xpost/MeshdispSensitivity.xpost








for item  in plus minus; do
$XP2EXO_EXECUTABLE ../../../mesh/runmesh/fluid_volume.top \
                   ./results/exo/all_${item}.exo \
                   results/xpost/Velocity_${item}.xpost \
                   results/xpost/Density_${item}.xpost \
                   results/xpost/Pressure_${item}.xpost \
                   results/xpost/Meshdisp_${item}.xpost \
                   results/xpost/FluidID_${item}.xpost
done

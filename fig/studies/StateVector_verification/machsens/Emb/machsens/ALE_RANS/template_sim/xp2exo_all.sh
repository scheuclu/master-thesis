#!/bin/bash
XP2EXO_EXECUTABLE=/home/pavery/bin/xp2exo

sed -i 's/Vector /Vector5 /g' ./results/xpost/StateVector*

$XP2EXO_EXECUTABLE ../../../mesh/runmesh/fluid_volume.top \
                   ./results/exo/all_quantities.exo \
                   results/xpost/DensitySensitivity.xpost \
                   results/xpost/MachSensitivity.xpost \
                   results/xpost/PressureSensitivity.xpost \
                   results/xpost/TemperatureSensitivity.xpost \
                   results/xpost/TotalPressureSensitivity.xpost \
                   results/xpost/VelocityNormSensitivity.xpost \
                   results/xpost/StateVectorSensitivity.xpost \
                   results/xpost/VelocitySensitivity.xpost \
                   results/xpost/MeshdispSensitivity.xpost \
                   results/xpost/Velocity_plus.xpost \
                   results/xpost/Density_plus.xpost \
                   results/xpost/Temperature_plus.xpost
#!/bin/bash

#PBS -N anasim_1_3_laminar_bodyfitted
#PBS -M lscheuch@stanford.edu
#PBS -l nodes=1:ppn=12
#PBS -l walltime=48:00:00

function printSuccess() {
   RED='\033[1;31m'
   NC='\033[0m'
   printf "${RED}$1${NC}\n\n"
}

CURRENT_DIR='/home/lscheuch/project/testcases/machsens/ALE_Laminar/anasim_1_3'
#AEROF_EXEC=/home/lscheuch/codes/aero-f_build/bin/aerof.opt
AEROF_EXEC='/home/lscheuch/project/testcases/machsens/ALE_Laminar/../../executables/aerof'
SOWER_EXEC='/home/lscheuch/project/testcases/machsens/ALE_Laminar/../../executables/sower'
XP2EXO_EXEC='/home/lscheuch/project/testcases/machsens/ALE_Laminar/../../executables/xp2exo'
SDESIGN_EXEC=/home/lscheuch/codes/sdesign.d/Executables.d/sdesign.Linux.opt

cd $CURRENT_DIR

#cd sdesign
#$SDESIGN_EXEC naca.sdesign
#printSuccess "SDESIGN finished"

#$SOWER_EXEC -fluid -split -con ../../mesh/mesh_ref.con -mesh ../../mesh/mesh_ref.msh -result naca.der -bc -3 -ascii -out naca_sowered.der
#printSuccess "SOWER finished"

#$SOWER_EXEC -fluid -split -con ../../mesh/mesh_ref.con -mesh ../../mesh/mesh_ref.msh -result naca.vmo -bc -3 -ascii -out naca_sowered.vmo
#printSuccess "SOWER on fluid finished"
#cd ..

module load openmpi/openmpi161_intel13

mpirun -n 12 $AEROF_EXEC naca_aerof.steady >& log_steady.log
mpirun -n 12 $AEROF_EXEC naca_direct.aerof.sens >& log_direct.log
mpirun -n 12 $AEROF_EXEC naca_adjoint.aerof.sens >& log_adjoint.log
printSuccess "AERO-F finished"

#mpirun -n 12 $AEROF_EXE naca.aerof.sens

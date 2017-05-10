#!/bin/bash

#PBS -N anasim_1_3_euler_bodyfitted
#PBS -M lscheuch@stanford.edu
#PBS -l nodes=1:ppn=12
#PBS -l walltime=48:00:00

function printSuccess() {
   RED='\033[1;31m'
   NC='\033[0m'
   printf "${RED}$1${NC}\n\n"
}

CURRENT_DIR='/home/lscheuch/project/testcases_emb/shapesens/ALE_RANS/anasim_1_3'
#AEROF_EXEC=/home/lscheuch/codes/aero-f_build/bin/aerof.opt
AEROF_EXEC='/home/lscheuch/project/testcases_emb/shapesens/ALE_RANS/../../executables/aerof'
SOWER_EXEC='/home/lscheuch/project/testcases_emb/shapesens/ALE_RANS/../../executables/sower'
XP2EXO_EXEC='/home/lscheuch/project/testcases_emb/shapesens/ALE_RANS/../../executables/xp2exo'
SDESIGN_EXEC='/home/lscheuch/project/testcases_emb/shapesens/ALE_RANS/../../executables/sdesign'

cd $CURRENT_DIR

cd sdesign
$SDESIGN_EXEC naca.sdesign
printSuccess "SDESIGN finished"

#$SOWER_EXEC -fluid -split -con ../../../../mesh/sower/fluid_sowered.con -mesh ../../../../mesh/sower/fluid_sowered.msh -result naca.der -bc -3 -ascii -out naca_sowered.der
#printSuccess "SOWER finished"

#$SOWER_EXEC -fluid -split -con ../../../../mesh/sower/fluid_sowered.con -mesh ../../../../mesh/sower/fluid_sowered.msh -result naca.vmo -bc -3 -ascii -out naca_sowered.vmo
#printSuccess "SOWER on fluid finished"
cd ..

module load openmpi/openmpi161_intel13

mpirun -n 12 $AEROF_EXEC naca_aerof.steady >& log_steady.log
mpirun -n 12 $AEROF_EXEC naca_direct.aerof.sens >& log_direct.log
mpirun -n 12 $AEROF_EXEC naca_adjoint.aerof.sens >& log_adjoint.log
printSuccess "AERO-F finished"


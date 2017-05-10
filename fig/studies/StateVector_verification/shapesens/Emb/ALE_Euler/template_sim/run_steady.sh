#!/bin/bash

#PBS -N sim_<index_mach>_<index_angle>_<index_shapevar>_<index_perturb>_laminar
#PBS -M lscheuch@stanford.edu
#PBS -l nodes=1:ppn=12
#PBS -l walltime=48:00:00

CURRENT_DIR='/home/lscheuch/project/testcases_emb/shapesens/ALE_Euler/sim_<index_mach>_<index_angle>_<index_shapevar>_<index_perturb>'

function printSuccess() {
   RED='\033[1;31m'
   NC='\033[0m'
   printf "${RED}$1${NC}\n\n"
}

module load openmpi/openmpi161_intel13

AEROF_EXEC='/home/lscheuch/project/testcases_emb/shapesens/ALE_Euler/../../executables/aerof'
SOWER_EXEC='/home/lscheuch/project/testcases_emb/shapesens/ALE_Euler/../../executables/sower'
XP2EXO_EXEC='/home/lscheuch/project/testcases_emb/shapesens/ALE_Euler/../../executables/xp2exo'
SDESIGN_EXEC='/home/lscheuch/project/testcases_emb/shapesens/ALE_Euler/../../executables/sdesign'

cd $CURRENT_DIR

cd sdesign
$SDESIGN_EXEC naca_plus.sdesign
$SDESIGN_EXEC naca_minus.sdesign
printSuccess SDESIGN_ended
cd ..

module load anaconda3/4.3
python3 ./perturb_EmbeddedSurface.py

mpirun -n 12 $AEROF_EXEC naca_plus.aerof.steady >& log_plus.log
mpirun -n 12 $AEROF_EXEC naca_minus.aerof.steady >& log_minus.log
printSuccess AEROF_ENDED


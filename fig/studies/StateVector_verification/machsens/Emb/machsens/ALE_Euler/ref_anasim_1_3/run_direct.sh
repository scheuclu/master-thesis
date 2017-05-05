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

CURRENT_DIR='/home/lscheuch/project/testcases_emb/machsens/ALE_Euler/anasim_1_3'
#AEROF_EXEC=/home/lscheuch/codes/aero-f_build/bin/aerof.opt
AEROF_EXEC='/home/lscheuch/project/testcases_emb/machsens/ALE_Euler/../../executables/aerof'
SOWER_EXEC='/home/lscheuch/project/testcases_emb/machsens/ALE_Euler/../../executables/sower'
XP2EXO_EXEC='/home/lscheuch/project/testcases_emb/machsens/ALE_Euler/../../executables/xp2exo'
SDESIGN_EXEC=/home/lscheuch/codes/sdesign.d/Executables.d/sdesign.Linux.opt

cd $CURRENT_DIR
module load openmpi/openmpi161_intel13
mpirun -n 12 $AEROF_EXEC naca_direct.aerof.sens >& log_direct.log
printSuccess "AERO-F finished"



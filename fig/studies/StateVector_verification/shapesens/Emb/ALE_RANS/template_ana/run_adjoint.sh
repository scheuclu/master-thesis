#!/bin/bash

#PBS -N anasim_<index_mach>_<index_angle>_euler_bodyfitted
#PBS -M lscheuch@stanford.edu
#PBS -l nodes=1:ppn=12
#PBS -l walltime=48:00:00

function printSuccess() {
   RED='\033[1;31m'
   NC='\033[0m'
   printf "${RED}$1${NC}\n\n"
}

CURRENT_DIR='<casepath>/anasim_<index_mach>_<index_angle>'
#AEROF_EXEC=/home/lscheuch/codes/aero-f_build/bin/aerof.opt
AEROF_EXEC='<casepath>/../../executables/aerof'
SOWER_EXEC='<casepath>/../../executables/sower'
XP2EXO_EXEC='<casepath>/../../executables/xp2exo'
SDESIGN_EXEC='<casepath>/../../executables/sdesign'


module load openmpi/openmpi161_intel13

mpirun -n 12 $AEROF_EXEC naca_adjoint.aerof.sens >& log_adjoint.log
printSuccess "AERO-F finished"


#/usr/bin/bash!

CURDIR=$(pwd)
#echo $CURDIR

SIMDIR=$(pwd)

find . -type d -name 'anasim_*' | while read line; do
  cd $line
  echo $line
  qsub -q sandybridge ./run_sens.sh  >& consoleout 
  cd $SIMDIR
done


find . -type d -name 'sim_*' | while read line; do
    echo $line
    cd $line
    qsub -q sandybridge ./run_steady.sh  >& consoleout
    cd $SIMDIR
done



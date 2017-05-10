#/usr/bin/bash!

CURDIR=$(pwd)
#echo $CURDIR

SIMDIR=$(pwd)

find . -type d -name 'anasim_*' | while read line; do
  cd $line
  echo $line
  qsub -q sandybridge ./run_direct.sh  >& consoleout 
  cd $SIMDIR
done

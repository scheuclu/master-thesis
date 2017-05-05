#/usr/bin/bash!

CURDIR=$(pwd)
#echo $CURDIR

find . -type d -name 'anasim_*' | while read line; do
  cd $line
  echo $line
  qsub -q sandybridge ./run_direct.sh 
  cd $CURDIR
done





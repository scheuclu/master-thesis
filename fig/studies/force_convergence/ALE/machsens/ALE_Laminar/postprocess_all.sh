#/usr/bin/bash!

CURDIR=$(pwd)
#echo $CURDIR

SIMDIR=$(pwd)
rm reults/xpost/*
rm results/exo/*
printf "\033[1;4;92mPOSTPROCESSING RESULTS                                                          \033[00m\n"
find . -type d -name 'anasim_*' | while read line; do
  cd $line
  echo $line
  ./sowerresults_all.sh
  ./xp2exo_all.sh
  cd $SIMDIR
done


find . -type d -name 'sim_*' | while read line; do
    echo $line
    cd $line
    ./sowerresults_all.sh
    python3 ./subtract_xpost.py
    ./xp2exo_all.sh
    cd $SIMDIR
done
printf "\033[1;4;92m                                                                                \033[00m\n"



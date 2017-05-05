cd sim_1_3_3
rm results/exo/*
./sowerresults_all.sh
python subtract_xpost.py
./xp2exo_all.sh

cd ..
cd anasim_1_3
rm results/exo/*
./sowerresults_all.sh
./xp2exo_all.sh

cd ..

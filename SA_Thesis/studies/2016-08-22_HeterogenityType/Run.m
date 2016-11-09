% clear
% clc

femacdir = '../../FEMAC/'
addpath(femacdir)


files.cboard.feti1={...
                    './cboard/feti1/tau1.dat'
                    './cboard/feti1/tau10.dat'
                    './cboard/feti1/tau100.dat'
                    './cboard/feti1/tau1000.dat'}'
                  
files.cboard.feti2g={...
                    './cboard/feti2g/tau1.dat'
                    './cboard/feti2g/tau10.dat'
                    './cboard/feti2g/tau100.dat'
                    './cboard/feti2g/tau1000.dat'}'
                  
files.cboard.fetis={...
                    './cboard/fetis/tau1.dat'
                    './cboard/fetis/tau10.dat'
                    './cboard/fetis/tau100.dat'
                    './cboard/fetis/tau1000.dat'}'
                  
                  
files.hstripes.feti1={...
                    './hstripes/feti1/tau1.dat'
                    './hstripes/feti1/tau10.dat'
                    './hstripes/feti1/tau100.dat'
                    './hstripes/feti1/tau1000.dat'}'
                  
files.hstripes.feti2g={...
                    './hstripes/feti2g/tau1.dat'
                    './hstripes/feti2g/tau10.dat'
                    './hstripes/feti2g/tau100.dat'
                    './hstripes/feti2g/tau1000.dat'}'
                  
files.hstripes.fetis={...
                    './hstripes/fetis/tau1.dat'
                    './hstripes/fetis/tau10.dat'
                    './hstripes/fetis/tau100.dat'
                    './hstripes/fetis/tau1000.dat'}'


%% Perform calculations

numiter.cboard.feti1=[];
for iter=files.cboard.feti1
  prob=femac(iter{:})
  numiter.cboard.feti1=[numiter.cboard.feti1,prob.main.solver_.numiter_];
end

numiter.cboard.feti2g=[];
for iter=files.cboard.feti2g
  prob=femac(iter{:})
  numiter.cboard.feti2g=[numiter.cboard.feti2g,prob.main.solver_.numiter_];
end

numiter.cboard.fetis=[];
for iter=files.cboard.fetis
  prob=femac(iter{:})
  numiter.cboard.fetis=[numiter.cboard.fetis,prob.main.solver_.numiter_];
end



numiter.hstripes.feti1=[];
for iter=files.hstripes.feti1
  prob=femac(iter{:})
  numiter.hstripes.feti1=[numiter.hstripes.feti1,prob.main.solver_.numiter_];
end

numiter.hstripes.feti2g=[];
for iter=files.hstripes.feti2g
  prob=femac(iter{:})
  numiter.hstripes.feti2g=[numiter.hstripes.feti2g,prob.main.solver_.numiter_];
end

numiter.hstripes.fetis=[];
for iter=files.hstripes.fetis
  prob=femac(iter{:})
  numiter.hstripes.fetis=[numiter.hstripes.fetis,prob.main.solver_.numiter_];
end


tauvec=[1 10 100 1000];
figure()
loglog(tauvec,numiter.cboard.feti1,'-o',...
     tauvec,numiter.cboard.feti2g,'-o',...
     tauvec,numiter.cboard.fetis,'-o')
legend('FETI-1','FETI-2(Geneo)','FETI-S')
title('checkerboard')


figure()
loglog(tauvec,numiter.hstripes.feti1,'-o',...
     tauvec,numiter.hstripes.feti2g,'-o',...
     tauvec,numiter.hstripes.fetis,'-o')
legend('FETI-1','FETI-2(Geneo)','FETI-S')
title('hstripes')


csvwrite('./data/numiter_cboard_feti1.text',[tauvec,numiter.hstripes.feti1])
csvwrite('./data/numiter_cboard_feti2g.text',[tauvec,numiter.hstripes.feti2g])
csvwrite('./data/numiter_cboard_fetis.text',[tauvec,numiter.hstripes.fetis])
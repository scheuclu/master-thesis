close all
%clear
clc

femacdir = '../../FEMAC/'
addpath(femacdir)

prepare


%/home/lukas/Desktop/SA_Thesis/studies/2016-08-10_Partitioning/chaco/tris/feti1/tau1.dat


%% .
files.feti1={...
    './new/feti1/regular_tris_6x6.dat'
    './new/feti1/chaco_tris_36x1.dat'
    './new/feti1/chaco_tris_6x6.dat'
    './new/feti1/chaco_tris_1x36.dat'}'
  
files.feti2g={...
    './new/feti2g/regular_tris_6x6.dat'
    './new/feti2g/chaco_tris_36x1.dat'
    './new/feti2g/chaco_tris_6x6.dat'
    './new/feti2g/chaco_tris_1x36.dat'}'
  
files.fetis={...
    './new/fetis/regular_tris_6x6.dat'
    './new/fetis/chaco_tris_36x1.dat'
    './new/fetis/chaco_tris_6x6.dat'
    './new/fetis/chaco_tris_1x36.dat'}'
  
files.fetias={...
    './new/fetias/regular_tris_6x6.dat'
    './new/fetias/chaco_tris_36x1.dat'
    './new/fetias/chaco_tris_6x6.dat'
    './new/fetias/chaco_tris_1x36.dat'}'
  
files.fetifas={...
    './new/fetifas/regular_tris_6x6.dat'
    './new/fetifas/chaco_tris_36x1.dat'
    './new/fetifas/chaco_tris_6x6.dat'
    './new/fetifas/chaco_tris_1x36.dat'}'



%% Perform calculations

%% feti1
numiter.feti1=[];
res.feti1={};
for iter=files.feti1
  prob=femac_pre(iter{:})
  prob=femac_main(iter{:})
  numiter.feti1=[numiter.feti1,prob.solver_.numiter_];
  res.feti1{end+1}=prob.solver_.res_;
end


%% feti2g
numiter.feti2g=[];
res.feti2g={};
for iter=files.feti2g
  prob=femac_main(iter{:})
  numiter.feti2g=[numiter.feti2g,prob.solver_.numiter_];
  res.feti2g{end+1}=prob.solver_.res_;
end

%% fetis
numiter.fetis=[];
numsdir.fetis={};
res.fetis={};
for iter=files.fetis
  prob=femac_main(iter{:})
  numiter.fetis=[numiter.fetis,prob.solver_.numiter_];
  numsdir.fetis{end+1}=prob.solver_.numsdir_;
  res.fetis{end+1}=prob.solver_.res_;
end


numsdir.fetis{1}=36*ones(1,numiter.fetis(1))
numsdir.fetis{2}=11*ones(1,numiter.fetis(2))
numsdir.fetis{3}=36*ones(1,numiter.fetis(3))
numsdir.fetis{4}=11*ones(1,numiter.fetis(4))

%% fetias
numiter.fetias=[];
numsdir.fetias={};
res.fetias={};
for iter=files.fetias
  %prob=femac_pre(iter{:})
  prob=femac_main(iter{:})
  numiter.fetias=[numiter.fetias,prob.solver_.numiter_];
  numsdir.fetias{end+1}=prob.solver_.numsdir_;
  res.fetias{end+1}=prob.solver_.res_;
end

%% fetifas
numiter.fetifas=[];
numsdir.fetifas={};
res.fetifas={};
for iter=files.fetifas
  prob=femac_main(iter{:})
  numiter.fetifas=[numiter.fetifas,prob.solver_.numiter_];
  numsdir.fetifas{end+1}=prob.solver_.numsdir_;
  res.fetifas{end+1}=prob.solver_.res_;
end



setups={'regular_6x6','chaco_11x1','chaco_6x6','chaco_1x11'}

for i=1:4
  csvwrite(['./data/numiter_',setups{i},'.txt'],[numiter.feti1(i) numiter.feti2g(i) numiter.fetis(i) numiter.fetias(i) numiter.fetifas(i) ])

  csvwrite(['./data/numsdir_',setups{i},'_fetis.txt'],[numsdir.fetis{i}'] )
  csvwrite(['./data/numsdir_',setups{i},'_fetias.txt'],[numsdir.fetias{i}'] )
  csvwrite(['./data/numsdir_',setups{i},'_fetifas.txt'],[numsdir.fetifas{i}'] )
  
  csvwrite(['./data/res_',setups{i},'_feti1.txt'],  [(1:length(res.feti1{i}) )',res.feti1{i}'] )
  csvwrite(['./data/res_',setups{i},'_feti2g.txt'], [(1:length(res.feti2g{i}) )',res.feti2g{i}'] )
  csvwrite(['./data/res_',setups{i},'_fetis.txt'],  [(1:length(res.fetis{i}) )',res.fetis{i}'] )
  csvwrite(['./data/res_',setups{i},'_fetias.txt'], [(1:length(res.fetias{i}) )',res.fetias{i}'] )
  csvwrite(['./data/res_',setups{i},'_fetifas.txt'],[(1:length(res.fetifas{i}) )',res.fetifas{i}'] )
  
end
close all
clear
clc

femacdir = '../../FEMAC/'
addpath(femacdir)

prepare



contractfacs=[0.1 0.5 0.9 0.95 0.99 0.999 0.9999 0.99999 0.0 0.0 0.0]


file.chaco.fetia={...
  './chaco/chaco_tri_contract0p1.dat'
  './chaco/chaco_tri_contract0p5.dat'
  './chaco/chaco_tri_contract0p9.dat'
  './chaco/chaco_tri_contract0p95.dat'
  './chaco/chaco_tri_contract0p99.dat'
  './chaco/chaco_tri_contract0p999.dat'
  './chaco/chaco_tri_contract0p9999.dat'
  './chaco/chaco_tri_contract0p99999.dat'
  './chaco/chaco_tri_contract_fast.dat'
  './chaco/chaco_tri_contract_block.dat'
  './chaco/chaco_tri_contract_feti1.dat'}'
 

 
numdir.chaco.fetia = {}
res.chaco.fetia = {}
tau.chaco.fetia = []

femac_pre(file.chaco.fetia{1});
 for iter= file.chaco.fetia
   temp=iter{:};
   prob=femac_main(temp)
   numdir.chaco.fetia{end+1}=prob.solver_.numsdir_'
   res.chaco.fetia{end+1}=prob.solver_.res_'
   tau.chaco.fetia=[tau.chaco.fetia,prob.solver_.tau_']
 end
 
   temp=iter{:};
   prob=femac_main(temp)
   numdir.chaco.fetia{end}=prob.solver_.numsdir_'
  
   
 
 
 

 outmat=zeros(length(numdir.chaco.fetia{end}),length(file.chaco.fetia) )
 for i=1:length(file.chaco.fetia)
   outmat(1:length(numdir.chaco.fetia{i}),i)=numdir.chaco.fetia{i}
 end
 
 figure()
 bar3(outmat)
 
 figure()
 for i=1:length(file.chaco.fetia)
   p=semilogy((1:length(res.chaco.fetia{i})),res.chaco.fetia{i})
   set(p,'LineWidth',2)
   hold on
 end
 legend('0p1','0p5,','0p9','0p95','0p99','0p999','0p9999','0p99999','fast', 'block', 'feti1')

 
csvwrite('./data/numsdir_chaco_fetia.txt',outmat)
csvwrite('./data/contract2tau_chaco.txt',[contractfacs',tau.chaco.fetia'])
 

 
 
 
 
 figure()
 loglog(contractfacs,tau.chaco.fetia,'-o')
 xlabel('contarction factor')
 ylabel('tau')
 
 

 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %% Ts developement fetis
 files.taudevelopment={...
  './taudevelopment/chaco_fetis.dat'
  './taudevelopment/chaco_feti2.dat'}'


prob_fetis=femac(files.taudevelopment{1})
ts.fetis=prob_fetis.main.solver_.ts_
ressub.fetis=prob_fetis.main.solver_.ressub_

csvwrite('./data/ts_fetis.txt',[[1:size(ts.fetis,1)]',ts.fetis])


 %% study of tau development FETI-S
 %TODO this must be done with a fetis solver
 figure()
 semilogy(1:size(ts.fetis,1),ts.fetis(:,1),'-o')
 hold on
 semilogy(1:size(ts.fetis,1),ts.fetis(:,2),'-o')
 semilogy(1:size(ts.fetis,1),ts.fetis(:,3),'-o')
 
 legend('iteration 1', 'iteration 2', 'iteration 3')
 
 
 %% study of tau development FETI-S
 %TODO this must be done with a fetis solver
 figure()
 subplot(4,1,1)
 plot(1:size(ts.fetis,1),ts.fetis(:,2)-ts.fetis(:,1),'-o',...
      1:size(ts.fetis,1),ts.fetis(:,2)*0,'--')
 subplot(4,1,2)
 plot(1:size(ts.fetis,1),ts.fetis(:,3)-ts.fetis(:,2),'-o',...
      1:size(ts.fetis,1),ts.fetis(:,2)*0,'--')
 subplot(4,1,3)
 plot(1:size(ts.fetis,1),ts.fetis(:,4)-ts.fetis(:,3),'-o',...
      1:size(ts.fetis,1),ts.fetis(:,2)*0,'--')
 subplot(4,1,4)
 plot(1:size(ts.fetis,1),ts.fetis(:,8)-ts.fetis(:,7),'-o',...
      1:size(ts.fetis,1),ts.fetis(:,2)*0,'--')
 
 legend('iteration 1', 'iteration 2', 'iteration 3')
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ts development

prob_feti2=femac(files.taudevelopment{2})                                 
ts.feti2  =prob_feti2.main.solver_.ts_
ressub.feti2=prob_feti2.main.solver_.ressub_

csvwrite('./data/ts_feti2.txt',[[1:size(ts.feti2,1)]',ts.feti2])

 %TODO this must be done with a feti2 solver
 figure()
 semilogy(1:size(ts.feti2,1),ts.feti2(:,1),'--o')
 hold on
 semilogy(1:size(ts.feti2,1),ts.feti2(:,2),'--o')
 semilogy(1:size(ts.feti2,1),ts.feti2(:,3),'--o')
 
 legend('iteration 1', 'iteration 2', 'iteration 3')
 
%%%

 figure()
  p=plot(1:size(ts.fetis,1),ts.fetis(:,1),'-xm',...
           1:size(ts.feti2,1),ts.feti2(:,1),'--xk',...
           1:size(ts.feti2,1),ts.feti2(:,2),'-ok',...
           1:size(ts.fetis,1),ts.fetis(:,2),'-om')
 legend('initial error','initial error','feti2','fetis')
 set(p,'LineWidth',2)
 

 
%% study of ts scattering in a fetis simulation
 
figure()
p=semilogy(1:size(ts.fetis,1),ts.fetis(:,1),'-o',...
           1:size(ts.fetis,1),ts.fetis(:,5),'-',...
           1:size(ts.fetis,1),ts.fetis(:,7),'-o',...
           1:size(ts.fetis,1),ts.fetis(:,15),'-o')
legend('1','5','7','11')
title('ts FETI-S')
set(p,'LineWidth',2)

figure()
p=semilogy(  1:size(ressub.fetis),ressub.fetis(:,2),'-o',...
         1:size(ressub.fetis,1),ressub.fetis(:,5),'-o',...
         1:size(ressub.fetis,1),ressub.fetis(:,7),'-o',...
         1:size(ressub.fetis,1),ressub.fetis(:,15),'-o')
legend('2','5','7','11')
title('resub FETI-S')
set(p,'LineWidth',2)
 
 
 %% study of ts scattering in a feti2 simulation
 
figure()
p=semilogy(  1:size(ts.feti2,1),ts.feti2(:,1),'-o',...
         1:size(ts.feti2,1),ts.feti2(:,5),'-o',...
         1:size(ts.feti2,1),ts.feti2(:,7),'-o',...
         1:size(ts.feti2,1),ts.feti2(:,15),'-o')
legend('1','5','7','11')
title('ts FETI-2')
set(p,'LineWidth',2)


figure()
p=semilogy(  1:size(ressub.feti2,1),ressub.feti2(:,2),'-o',...
         1:size(ressub.feti2,1),ressub.feti2(:,5),'-o',...
         1:size(ressub.feti2,1),ressub.feti2(:,7),'-o',...
         1:size(ressub.feti2,1),ressub.feti2(:,15),'-o')
legend('2','5','7','11')
title('ressub FETI-2')
set(p,'LineWidth',2)


%% testingground

figure()
subplot(4,1,1)
p=plot(  1:size(ressub.fetis,1),ressub.fetis(:,2)-ressub.fetis(:,3),'-o')
subplot(4,1,2)
p=plot(  1:size(ressub.fetis,1),ressub.fetis(:,5)-ressub.fetis(:,6),'-o')
subplot(4,1,3)
p=plot(  1:size(ressub.fetis,1),ressub.fetis(:,7)-ressub.fetis(:,8),'-o')
subplot(4,1,4)
p=plot(  1:size(ressub.fetis,1),ressub.fetis(:,10)-ressub.fetis(:,11),'-o')

legend('2','5','7','11')
title('ressub FETI-2')
set(p,'LineWidth',2)

 
 
test=[... 
  ts.fetis(:,1)'
  ts.fetis(:,5)'
  ts.fetis(:,7)'
  ts.fetis(:,15)']
surf(test)
 set(gca,'ZScale','log')
 
 
 
 %% Visualisierung der Glaettung
 figure()
p=semilogy(  1:size(ts.fetis,1),ts.fetis(:,1),'-o',...
         1:size(ts.fetis,1),ts.fetis(:,end),'-o')
legend('1','end')
title('Glaettung FETI-S')
set(p,'LineWidth',2)

 figure()
p=semilogy(  1:size(ts.feti2,1),ts.feti2(:,1),'-o',...
         1:size(ts.feti2,1),ts.feti2(:,end),'-o')
legend('1','end')
title('Glaettung FETI-2')
set(p,'LineWidth',2)


 figure()
p=semilogy(1:size(ts.feti2,1),ts.feti2(:,end)./ts.feti2(:,1),'-o',...
           1:size(ts.fetis,1),ts.fetis(:,end)./ts.fetis(:,1),'-o')
legend('feti2','fetis')
title('Difference')
set(p,'LineWidth',2)
 

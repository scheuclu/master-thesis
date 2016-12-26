clear
close all 
clc

nodes=load('./geometry/designelementnodes');
nodesfine=load('./geometry/nodesfine');
nacanodes=load('./geometry/nacanodes');

numnode=size(nodes,1)
numnacanodes=size(nacanodes,1)


for i=1:numnode
    node=nodes(i,:)
    x=node(1)
    y=node(2)
    
    A(i,:)=genlocvec(node);
end

for i=1:numnode
    rhs=zeros(numnode,1)
    rhs(i)=1
    sevalmat(i,:)=[A\rhs]'
end



 
% plotall(figure(),nodes,'ko--',...
%                   nodesfine,'b--',...
%                   nacanodes,'r--');
              
cases={'case1','case2','case3','case4','case5','case6'}

for folder=cases
    folder{:}
    disp=load(strcat(folder{:},'/disp'))
    
    nacanodesmoved=movenodes(nacanodes,sevalmat,disp);
    nodesfinemoved=movenodes(nodesfine,sevalmat,disp);
   
    %% write .csv-files for Tikz
    csvwrite(strcat(folder{:},'/nacanodesmoved.csv'),nacanodesmoved);
    csvwrite(strcat(folder{:},'/nodesfinemoved.csv'),nodesfinemoved);
    
    csvwrite(strcat(folder{:},'/nodesfine.csv'),nodesfine);
    csvwrite(strcat(folder{:},'/nacanodes.csv'),nacanodes);
    
    csvwrite(strcat(folder{:},'/designelementnodes.csv'),nodes);
    
    %% Plot the undeformed configuration
    plotall(figure(),nodes,'ko--',...
                  nodesfine,'b--',...
                  nacanodes,'r--');
              

    %% Plot the deformed configuration
    plotall(gcf,nodes,'ko',...
                nodesfinemoved,'b-',...
                nacanodesmoved,'r-')
    set(gca,'LineWidth',5)
end


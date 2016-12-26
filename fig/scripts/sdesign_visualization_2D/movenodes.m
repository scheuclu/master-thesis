function [nodesout] = movenodes(nodesin,sevalmat,disp)
    
    nodesout=nodesin;
    for i=1:size(nodesin,1)
        curnode=nodesin(i,:)
        weights=sevalmat*genlocvec(curnode)
        movex=weights'*disp(:,1)
        movey=weights'*disp(:,2)
        nodesout(i,1)=nodesout(i,1)+weights'*disp(:,1);
        nodesout(i,2)=nodesout(i,2)+weights'*disp(:,2);
%         nodesout(i,1)=nodesout(i,1)+weights(i,1)*disp(i,1);
%         nodesout(i,2)=nodesout(i,2)+weights(i,2)*disp(i,2);
    end
    
end
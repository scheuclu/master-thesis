function p = plotall(f,nodes,style_nodes,nodesfine,style_nodesfine,nacanodes,style_nacanodes)

    figure(f)
    axis equal
    axis off
    hold on
    plot(nacanodes(:,1),nacanodes(:,2),style_nacanodes);
    plot(nodesfine(:,1),nodesfine(:,2),style_nodesfine);

    p=plot([nodes(1,1),nodes(4,1)],[nodes(1,2),nodes(4,2)],style_nodes,...
         [nodes(4,1),nodes(5,1)],[nodes(4,2),nodes(5,2)],style_nodes,...
         [nodes(5,1),nodes(8,1)],[nodes(5,2),nodes(8,2)],style_nodes,...
         [nodes(8,1),nodes(1,1)],[nodes(8,2),nodes(1,2)],style_nodes,...
         [nodes(2,1),nodes(7,1)],[nodes(2,2),nodes(7,2)],style_nodes,...
         [nodes(3,1),nodes(6,1)],[nodes(3,2),nodes(6,2)],style_nodes       );
 
 
end
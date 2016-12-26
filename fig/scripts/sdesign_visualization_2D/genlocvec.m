function locvec = genlocvec(pos)
    x=pos(1);
    y=pos(2);
    locvec=[...
            1
            x
            x^2
            x^3
            y
            y*x
            y*x^2
            y*x^3];
end
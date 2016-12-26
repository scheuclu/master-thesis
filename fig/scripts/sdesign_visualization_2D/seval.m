function [svals] = seval(sevalmat,loc)
 x=loc(1)
 y=loc(2)
 
 svals=sevalmat*genlocvec(loc);
 
end
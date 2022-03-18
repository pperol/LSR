%% http://lsr.dsi.unimi.it/LSR/Item?id=789

% Based on http://lsr.dsi.unimi.it/LSR/Snippet?id=382
% the #:hspace value controls the amount of space between each dynamic symbol.

dynamicOne = #(make-dynamic-script (markup #:line ( 
             #:dynamic "f" 
             #:dynamic "z" 
             #:dynamic "p" )))

dynamicTwo = #(make-dynamic-script (markup #:line ( 
             #:dynamic "p" #:hspace -0.5 
             #:dynamic "z"  #:hspace -0.5 
             #:dynamic "f"  #:hspace -0.5 
             #:dynamic "z"  #:hspace -0.5 
             #:dynamic "p" )))

dynamicThree = #(make-dynamic-script (markup #:line ( 
             #:dynamic "s" #:hspace -0.8 
             #:dynamic "f" #:hspace -0.8 
             #:dynamic "z" #:hspace -0.8 
             #:dynamic "z" #:hspace -0.8  
             #:dynamic "z" #:hspace -0.8  
             #:dynamic "z"  #:hspace -0.8  
             #:dynamic "p" )))

\relative c'' {
  c1\dynamicOne c2 c c1\dynamicTwo c2 c c1\dynamicThree
}

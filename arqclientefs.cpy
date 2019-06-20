      *Skeleton COBOL Copybook
       01  fs-arqcliente.
           05  fs-arqcliente-1   PIC  X(001).
           05  fs-arqcliente-2   pic  x(001).
           05  fs-arqcliente-r   redefines fs-arqcliente-2  pic 99
           comp-x.

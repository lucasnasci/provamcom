      *Skeleton COBOL Copybook
       01  fs-arqvendedor.
           05  fs-arqvendedor-1   PIC  X(001).
           05  fs-arqvendedor-2   pic  x(001).
           05  fs-arqvendedor-r redefines fs-arqvendedor-2  pic 99
           comp-x.

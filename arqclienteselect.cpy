      *Skeleton COBOL Copybook
       select arqcliente assign to
               "C:\Users\Cliente\Documents\PROVACOBOL\arqcliente.dat"
             organization       is indexed
             access mode        is dynamic
             record key         is arqcliente-chave
             lock mode          is manual

             file status        is fs-arqcliente.

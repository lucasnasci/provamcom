      *Skeleton COBOL Copybook
       select arqvendedor assign to
               "C:\Users\vendedor\Documents\PROVACOBOL\arqvendedor.dat"
             organization       is indexed
             access mode        is dynamic
             record key         is arqvendedor-chave
             lock mode          is manual

             file status        is fs-arqvendedor.

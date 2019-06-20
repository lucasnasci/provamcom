      *Skeleton COBOL Copybook
       fd arqvendedor.

       01  arqvendedor-vendedor.
           03 arqvendedor-chave.
           03 arqvendedor-chave.
            05 arqvendedor-codigo        pic  9(007) value zeros.
            05 arqvendedor-cpf           pic  9(011) value zeros.
            05 arqvendedor-nome          pic  X(040) value spaces.
           03 arqvendedor-latlong.
            05 arqvendedor-lat           pic s9(003)v9(008) value zeros.
            05 arqvendedor-lon           pic s9(003)v9(008) value zeros.

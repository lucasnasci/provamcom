      *Skeleton COBOL Copybook
           fd arqcliente.

       01  arqcliente-cliente.
           03 arqcliente-chave.
            05 arqcliente-codigo           pic  9(007) value zeros.
            05 arqcliente-cnpj             pic  9(014) value zeros.
            05 arqcliente-raz-soc          pic  X(040) value spaces.
           03 arqvendedor-latlong.
            05 arqcliente-lat              pic s9(003)v9(008) value zeros.
            05 arqcliente-lon              pic s9(003)v9(008) value zeros.

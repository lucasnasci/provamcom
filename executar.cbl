       program-id. executar as "executar".

       environment division.
       configuration section.
       special-names.
           decimal-point is comma.

       input-output section.
       file-control.

      * copy arqsaidaselect.cpy.
      * copy arqclienteselect.cpy.
      * copy arqvendedornteselect.cpy.

       data division.

           file section.

      *    copy arqsaidafd.cpy.
      *    copy arqclientefd.cpy.
      *    copy arqvendedorfd.cpy.

      *     LINKAGE SECTION.
      *     wid-arq-vendedor.
      *     wid-arq-cliente.
      *-----------------------------------------------------------------
           WORKING-STORAGE SECTION.
           01 wk-workarea.
              05 wk-resultado           pic 9(001) value zeros.
              05 wk-ordem               pic 9(001) value zeros.
              05 wk-opcao               pic 9(001) value zeros.
              05 fl-ok                  pic x(001) value spaces.
              05 wk-msg                 pic x(050) value spaces.
      *-----------------------------------------------------------------
           01  wk-cliente.
            03  wk-chave-cliente.
             05 wk-codigo               pic  9(007) value zeros.
             05 wk-cnpj                 pic  9(014) value zeros.
             05 wk-raz-soc              pic  X(040) value zeros.
            03  wk-latlong-cliente.
             05 wk-lat                  pic  9(011) value zeros.
             05 wk-lon                  pic  9(011) value zeros.
      *-----------------------------------------------------------------
           01  wk-vendedor.
            03  wk-chave-vendedor.
             05 wk-codigo               pic  9(007) value zeros.
             05 wk-cpf                  pic  9(011) value zeros.
             05 wk-nome                 pic  X(040) value zeros.
            03  wk-latlong-vendedor.
             05 wk-lat                   pic  9(011) value zeros.
             05 wk-lon                   pic  9(011) value zeros.
      *-----------------------------------------------------------------
      *    copy arqsaidafs.cpy.
      *    copy arqclientefs.cpy.
      *    copy arqvendedorfs..cpy
      *-----------------------------------------------------------------
            SCREEN SECTION.
            01  SC-TELA-INICIAL.
               05  blank screen.
               05  line  10  col  43   using wk-msg.
      *-----------------------------------------------------------------
       procedure division.

       perform       0000-controle.

       PERFORM       0010-PROCESSA.

       perform       9999-fim-programa.
      *-----------------------------------------------------------------
       0000-controle.
      *-----------------------------------------------------------------
       INITIALIZE    wk-cliente
                     wk-workarea.
      *     open i-o arqcliente.

      *     display "fs-arqcliente: " fs-arqcliente.

      *     if   fs-arqcliente equal zeros
      *          display "arquivo existente "
      *                  " - fs-arqcliente = " fs-arqcliente
      *     else
      *      if  fs-arqcliente = 05
      *          display "arquivo inexistente"
      *               " - fs-arqcliente = " fs-arqcliente
      *          else
      *              display "arquivo com problema - "
      *              " - fs-arqcliente = " fs-arqcliente.
      *              display "fs-arqcliente: " fs-arqcliente.
      *-----------------------------------------------------------------
      *     open i-o arqvendedor.

      *     display "fs-arqvendedor: " fs-arqvendedor.

      *     if   fs-arqvendedor equal zeros
      *          display "arquivo existente "
      *                  " - fs-arqvendedor = " fs-arqvendedor
      *     else
      *      if  fs-arqvendedor = 05
      *          display "arquivo inexistente"
      *               " - fs-arqvendedor = " fs-arqvendedor
      *          else
      *              display "arquivo com problema - "
      *              " - fs-arqvendedor = " fs-arvendedor.
      *              display "fs-arqvendedor: " fs-arqvendedor.
      *-----------------------------------------------------------------
      *     open i-o arqsaida.

      *     display "fs-arqsaida: " fs-arqsaida.
      *     if   fs-arqsaida equal zeros
      *          display "arquivo existente "
      *                  " - fs-arqsaida = " fs-arqvendedor
      *     else
      *      if  fs-arqsaida = 05
      *          display "arquivo inexistente"
      *               " - fs-arqsaida = " fs-arqsaida
      *          else
      *              display "arquivo com problema - "
      *              " - fs-arqsaida = " fs-arsaida.
      *              display "fs-arqsaida: " fs-arqsaida.
      *---------------------------------------------------------------
       0010-PROCESSA.

           PERFORM   0011-GET-CLIENTE.
      *     UNTIL    FS-ARQCLIENTE      EQUAL       '10'.

      *----------------------------------------------------------------
       0011-GET-CLIENTE.
      *     move      wk-chave-liente   to          arqcliente-chave.
      *     start     arqcliente key is >           arqcliente-chave.
      *     if        fs-arqcliente     equal       zeros
      *      PERFORM  0012-GET-VENDEDOR
      *       UNTIL   FL-ARQVENDEDOR
      *        EQUAL  '10'
      *      PERFORM  0013-GRAVA-SAIDA
      *     else
      *         MOVE  'Registro inexistente'
      *                              to           wk-msg
      *         PERFORM              0030-ALTERACAO
      *     END-IF.
      *----------------------------------------------------------------
       0012-GET-VENDEDOR.
      *    move      wk-chave-vendedor    to      arqvendedor-chave.
      *    start     arqvendedor key is >          arqvendedor-chave.
      *    if        fs-arqvendedor       equal   zeros
      *     compute  wk-resultado         equal
      *              arqvendedor-latlong  -       arqvendedor-latlong
      *     if       wk-resultado         <       wk-resultado-ant
      *      or      wk-resultado-ant     equal   zeros
      *      move    wk-resultado         to      wk-resultado-ant.
      *     end-if
      *    end-if.

      *----------------------------------------------------------------
       0013-GRAVA-SAIDA.
      *    MOVE     arqcliente-codigo     to      arqsaida-cliente-codigo.
      *    MOVE     arqcliente-raz-soc    to      arqsaida-cliente-raz-soc.
      *    MOVE     arqvendedor-codigo    to      arqsaida-vendedor-codigo.
      *    MOVE     arqcliente-raz-soc    to      arqsaida-vendedor-nome.
      *    MOVE     wk-resultado-ant      to      arqsaida-distancia.
      *    WRITE    arqsaida.

      *----------------------------------------------------------------
       9999-fim-programa.

           GOBACK.
      *    close arqsaida.
      *    close arqvendedor.
      *    close arqcliente.
           exit program.

           end program executar.

       program-id. relatoriovendedor as "relatoriovendedor".

       environment division.
       configuration section.
       special-names.
           decimal-point is comma.

       input-output section.
       file-control.

      * copy arqvendedorselect.

       data division.

           file section.

      *     copy arqvendedorfd.

           WORKING-STORAGE SECTION.
           01 wk-workarea.
              05 wk-linha               pic 9(001) value zeros.
              05 wk-ordem               pic 9(001) value zeros.
              05 wk-opcao               pic 9(001) value zeros.
              05 fl-ok                  pic x(001) value spaces.
              05 wk-msg                 pic x(050) value spaces.
           01  wk-vendedor.
            03  wk-chave.
             05 wk-codigo               pic  9(007) value zeros.
             05 wk-cpf                  pic  9(011) value zeros.
             05 wk-nome                 pic  X(040) value zeros.
            03 wk-lat                   pic  9(011) value zeros.
            03 wk-lon                   pic  9(011) value zeros.

      *        copy arqvendedorfs.

            SCREEN SECTION.
            01  SC-TELA-INICIAL.
               05  blank screen.
               05  line  1   col  05 VALUE
                         "Relatorios ".
               05  line  3   col  05 value
                         "1 Para ordenacao ascendente".
               05  line  4   col  05 value
                         "2 Para ordenacao decrescente".
               05  line  4   col  40   using wk-ordem.
               05  line  5   col  05 value
                         "3 Por codigo de vendedor".
               05  line  6   col  05 value
                         "4 Por nome de vendedor".
               05  line  6   col  40   using wk-opcao.
               05  line  7   col  05 value
                         "9 Encerrar".
               05  line  10  col  43   using wk-msg.
      *------------------------------------------------------------------------

            01  SC-TELA-REGISTRO.
               05  blank screen.
               05  line  1   col  05 VALUE
                         "CADASTRO DE DADOS".
               05  line  3   col 05 value
                         "|codigo ".
               05  line  3   col 14 value
                         "|CPF ".
               05  line  3   col 20 value
                         "|Nome ".
               05  line  3   col 30 value
                         "|Latitude ".
               05  line  3   col 41 value
                         "|Longitude ".
            01 SC-REGISTRO.
               05  line  wk-linha   col  05   using wk-codigo.
               05  line  wk-linha   col  14   using wk-cpf.
               05  line  wk-linha   col  20   using wk-nome.
               05  line  wk-linha   col  30   using wk-lat.
               05  line  wk-linha   col  41   using wk-lon.
      *------------------------------------------------------------------------

             01  SC-TELA-CODIGO.
               05  blank screen.
               05  line  1   col  05 VALUE
                         "CONSISTIR VENDEDOR".
               05  line  3   col 05 value
                         "Informe o codigo do vendedor".
               05  line  3   col  43   using wk-codigo.

               05  line  10  col  43  using wk-msg.

      *------------------------------------------------------------------------

             01  SC-TELA-NOME.
               05  blank screen.
               05  line  1   col  05 VALUE
                         "CONSISTIR VENDEDOR".
               05  line  3   col 05 value
                         "Informe o nome do vendedor".
               05  line  3   col  43   using wk-nome.

               05  line  10  col  43  using wk-msg.

       procedure division.

       perform       0000-controle.

       PERFORM       0010-GET-SC-TELA-INICIAL.

       perform       9999-fim-programa.

       0000-controle.
       INITIALIZE    wk-workarea
                     wk-vendedor.
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
      *              " - fs-arqvendedor = " fs-arqvendedor.
      *              display "fs-arqvendedor: " fs-arqvendedor.

      *---------------------------------------------------------------
       0010-GET-SC-TELA-INICIAL.

           DISPLAY     SC-TELA-INICIAL.
           ACCEPT      SC-TELA-INICIAL.

           IF          WK-OPCAO      EQUAL      '3'
             INITIALIZE wk-vendedor
                       wk-workarea
             PERFORM   0020-FILTRO-CODIGO
           END-IF.
           IF          WK-OPCAO      EQUAL      '4'
             PERFORM   0030-FILTRO-NOME
           END-IF.


           IF          WK-OPCAO      NOT EQUAL  '9'
            PERFORM    0010-GET-SC-TELA-INICIAL
           END-IF.

      *---------------------------------------------------------------
       0020-FILTRO-CODIGO.

           DISPLAY    SC-TELA-CODIGO.
           ACCEPT     SC-TELA-CODIGO.
           initialize  wk-msg.
           PERFORM    0025-CONSISTE-TELA.
      *---------------------------------------------------------------
       0025-CONSISTE-TELA.

           IF        wk-codigo      EQUAL        ZEROS
            OR       wk-codigo      EQUAL        SPACES
               MOVE  'Informar o codigo do vendedor'
                                    to           wk-msg
               PERFORM              0020-FILTRO-CODIGO
           ELSE
      *        MOVE  wk-chave      TO           ARQVENDEDOR-CHAVE.
      *        READ  ARQVENDEDOR
      *        IF    FS-ARQVENDEDOR EQUAL        ZEROS
                DISPLAY             SC-TELA-REGISTRO
                ACCEPT              FL-OK                                      *APENAS PARA MOSTRAR A TELA
                                                                               *VISTO QUE A IDE UTILIZADA NAO PERMITE
                                                                               *CRIACAO DE ARQUIVOS
      *         PERFORM             0026-LISTA-VENDEDOR
      *          VARYING            WK-LINHA
      *           FROM              4
      *            BY               1
      *          UNTIL              FS-VENDEDOR  EQUAL '10'
      *        ELSE
      *         MOVE "Vendedor nao cadastrado"
      *                             TO          WK-MSG
      *         PERFORM             0020-FILTRO-CODIGO
      *        END-IF.
           END-IF.

           INITIALIZE WK-OPCAO.
      *-----------------------------------------------------------------
       0026-LISTA-VENDEDOR.
      *
      *     if       fs-arqvendedor equal        zeros
      *      MOVE    ARQVENDENDOR-VENDEDOR
      *                             TO           wk-vendedor
      *      PERFORM                0027-DISPLAY
      *      IF      WK-ORDEM       EQUAL        1
      *       read   arqvendedor    NEXT
      *      ELSE
      *       read   arqvendedor    PREVIOUS
      *      END-IF
      *     END-IF.
      *---------------------------------------------------------------
       0027-DISPLAY.
      *    DISPLAY    SC-REGISTRO.
      *
      *---------------------------------------------------------------
       0030-FILTRO-NOME.
           DISPLAY    SC-TELA-NOME.
           ACCEPT     SC-TELA-NOME.
           initialize  wk-msg.
           PERFORM    0035-CONSISTE-TELA.
           IF         WK-ORDEM      EQUAL         '1'
            PERFORM   0033-SORT-CRESCENTE
           ELSE
            PERFORM   0034-SORT-DECRESCENTE
           END-IF.
           INITIALIZE wk-vendedor
                      wk-workarea.
      *---------------------------------------------------------------
       0033-SORT-CRESCENTE.
      *    SORT ARQVENDEDOR ON ASCENDING         ARQVENDEDOR-NOME.
      *    USING INPUT GIVING OUTPUT.
      *---------------------------------------------------------------
       0034-SORT-DECRESCENTE.
      *    SORT ARQVENDEDOR ON ASCENDING         ARQVENDEDOR-NOME.
      *    USING INPUT GIVING OUTPUT.
      *---------------------------------------------------------------
       0035-CONSISTE-TELA.

           IF        wk-nome        EQUAL        ZEROS
            OR       wk-nome        EQUAL        SPACES
               MOVE  'Informar o nome do vendedor'
                                    to           wk-msg
               PERFORM              0030-FILTRO-NOME
           ELSE
      *        MOVE  WK-CHAVE        TO           ARQVENDEDOR-CHAVE.
      *        READ  ARQVENDEDOR
      *        IF    FS-ARQVENDEDOR EQUAL        ZEROS
                DISPLAY             SC-TELA-REGISTRO
                ACCEPT              fl-ok
      *         PERFORM             0036-LISTA-VENDEDOR
      *          VARYING            WK-LINHA
      *           FROM              4
      *            BY               1
      *          UNTIL              FS-VENDEDOR  EQUAL '10'
      *        ELSE
      *         MOVE "Vendedor nao cadastrado"
      *                             TO          WK-MSG
      *         PERFORM             0020-FILTRO-CODIGO
      *        END-IF.
           END-IF.
      *----------------------------------------------------------------
       0036-LISTA-VENDEDOR.
      *
      *     if       fs-arqvendedor equal        zeros
      *      MOVE    ARQVENDENDOR-VENDEDOR
      *                             TO           wk-vendedor
      *      PERFORM                0037-DISPLAY
      *       read   arqvendedor    NEXT
      *     END-IF.

      *----------------------------------------------------------------
       0037-DISPLAY.
      *    DISPLAY    SC-REGISTRO.
      *----------------------------------------------------------------
       9999-fim-programa.

           GOBACK.
      *    close arqvendedor.
           exit program.

           end program relatoriovendedor.

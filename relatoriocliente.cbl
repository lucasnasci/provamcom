       program-id. relatoriocliente as "relatoriocliente".

       environment division.
       configuration section.
       special-names.
           decimal-point is comma.

       input-output section.
       file-control.

      * copy arqclienteselect.

       data division.

           file section.

      *     copy arqclientefd.
      *-----------------------------------------------------------------
           WORKING-STORAGE SECTION.
           01 wk-workarea.
              05 wk-linha               pic 9(001) value zeros.
              05 wk-ordem               pic 9(001) value zeros.
              05 wk-opcao               pic 9(001) value zeros.
              05 fl-ok                  pic x(001) value spaces.
              05 wk-msg                 pic x(050) value spaces.
           01  wk-cliente.
            03  wk-chave.
             05 wk-codigo               pic  9(007) value zeros.
             05 wk-cnpj                 pic  9(014) value zeros.
             05 wk-raz-soc              pic  X(040) value zeros.
            03 wk-lat                   pic  9(011) value zeros.
            03 wk-lon                   pic  9(011) value zeros.
      *-----------------------------------------------------------------
      *        copy arqclientefs.
      *-----------------------------------------------------------------
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
                         "3 Por codigo de cliente".
               05  line  6   col  05 value
                         "4 Por razao soial de cliente".
               05  line  6   col  40   using wk-opcao.
               05  line  7   col  05 value
                         "9 Encerrar".
               05  line  10  col  43   using wk-msg.
      *-----------------------------------------------------------------
            01  SC-TELA-REGISTRO.
               05  blank screen.
               05  line  1   col  05 VALUE
                         "CADASTRO DE DADOS".
               05  line  3   col 05 value
                         "|codigo ".
               05  line  3   col 14 value
                         "|CNPJ ".
               05  line  3   col 20 value
                         "|Razao social ".
               05  line  3   col 30 value
                         "|Latitude ".
               05  line  3   col 41 value
                         "|Longitude ".
      *-----------------------------------------------------------------
            01 SC-REGISTRO.
               05  line  wk-linha   col  05   using wk-codigo.
               05  line  wk-linha   col  14   using wk-cnpj.
               05  line  wk-linha   col  20   using wk-raz-soc.
               05  line  wk-linha   col  30   using wk-lat.
               05  line  wk-linha   col  41   using wk-lon.
      *-----------------------------------------------------------------
             01  SC-TELA-CODIGO.
               05  blank screen.
               05  line  1   col  05 VALUE
                         "CONSISTIR CLIENTE".
               05  line  3   col 05 value
                         "Informe o codigo do cliente".
               05  line  3   col  43   using wk-codigo.

               05  line  10  col  43  using wk-msg.
      *-----------------------------------------------------------------
             01  SC-TELA-RAZSOC.
               05  blank screen.
               05  line  1   col  05 VALUE
                         "CONSISTIR CLIENTE".
               05  line  3   col 05 value
                         "Informe a razao social do cliente".
               05  line  3   col  43   using wk-raz-soc.

               05  line  10  col  43  using wk-msg.
      *-----------------------------------------------------------------
       procedure division.

       perform       0000-controle.

       PERFORM       0010-GET-SC-TELA-INICIAL.

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
      *---------------------------------------------------------------
       0010-GET-SC-TELA-INICIAL.

           DISPLAY     SC-TELA-INICIAL.
           ACCEPT      SC-TELA-INICIAL.

           IF          WK-OPCAO      EQUAL      '3'
             INITIALIZE wk-cliente
                       wk-workarea
             PERFORM   0020-FILTRO-CODIGO
           END-IF.

           IF          WK-OPCAO      EQUAL      '4'
             PERFORM   0030-FILTRO-RAZSOC
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
               MOVE  'Informar o codigo do cliente'
                                    to           wk-msg
               PERFORM              0020-FILTRO-CODIGO
           ELSE
      *        MOVE  wk-chave       TO           ARQCLIENTE-CHAVE.
      *        READ  ARQCLIENTE
      *        IF    FS-ARQCLIENTE EQUAL        ZEROS
                DISPLAY             SC-TELA-REGISTRO
                ACCEPT              FL-OK                                      *APENAS PARA MOSTRAR A TELA
                                                                               *VISTO QUE A IDE UTILIZADA NAO PERMITE
                                                                               *CRIACAO DE ARQUIVOS
      *         PERFORM             0026-LISTA-CLIENTE
      *          VARYING            WK-LINHA
      *           FROM              4
      *            BY               1
      *          UNTIL              FS-CLIENTE  EQUAL '10'
      *        ELSE
      *         MOVE "cliente nao cadastrado"
      *                             TO          WK-MSG
      *         PERFORM             0020-FILTRO-CODIGO
      *        END-IF.
           END-IF.
           INITIALIZE WK-OPCAO.
      *-----------------------------------------------------------------
       0026-LISTA-CLIENTE.
      *
      *     if       fs-arqcliente equal        zeros
      *      MOVE    ARQVENDENDOR-CLIENTE
      *                             TO           wk-cliente
      *      PERFORM                0027-DISPLAY
      *      IF      WK-ORDEM       EQUAL        1
      *       read   arqcliente    NEXT
      *      ELSE
      *       read   arqcliente    PREVIOUS
      *      END-IF
      *     END-IF.
      *---------------------------------------------------------------
       0027-DISPLAY.
      *    DISPLAY    SC-REGISTRO.
      *---------------------------------------------------------------
       0030-FILTRO-RAZSOC.
           DISPLAY    SC-TELA-RAZSOC.
           ACCEPT     SC-TELA-RAZSOC.
           initialize  wk-msg.
           PERFORM    0035-CONSISTE-TELA.
           IF         WK-ORDEM      EQUAL         '1'
            PERFORM   0033-SORT-CRESCENTE
           ELSE
            PERFORM   0034-SORT-DECRESCENTE
           END-IF.
           INITIALIZE wk-cliente
                      wk-workarea.
      *---------------------------------------------------------------
       0033-SORT-CRESCENTE.
      *    SORT ARQCLIENTE ON ASCENDING         ARQCLIENTE-RAZ-SOC.
      *    USING INPUT GIVING OUTPUT.
      *---------------------------------------------------------------
       0034-SORT-DECRESCENTE.
      *    SORT ARQCLIENTE ON ASCENDING         ARQCLIENTE-RAZ-SOC.
      *    USING INPUT GIVING OUTPUT.
      *---------------------------------------------------------------
       0035-CONSISTE-TELA.

           IF        wk-RAZ-SOC        EQUAL        ZEROS
            OR       wk-RAZ-SOC        EQUAL        SPACES
               MOVE  'Informar A razao social do cliente'
                                    to           wk-msg
               PERFORM              0030-FILTRO-RAZSOC
           ELSE
      *        MOVE  WK-CHAVE        TO           ARQCLIENTE-CHAVE.
      *        READ  ARQCLIENTE
      *        IF    FS-ARQCLIENTE EQUAL        ZEROS
                DISPLAY             SC-TELA-REGISTRO
                ACCEPT              fl-ok
      *         PERFORM             0036-LISTA-CLIENTE
      *          VARYING            WK-LINHA
      *           FROM              4
      *            BY               1
      *          UNTIL              FS-CLIENTE  EQUAL '10'
      *        ELSE
      *         MOVE "cliente nao cadastrado"
      *                             TO          WK-MSG
      *         PERFORM             0020-FILTRO-CODIGO
      *        END-IF.
           END-IF.
      *----------------------------------------------------------------
       0036-LISTA-CLIENTE.
      *
      *     if       fs-arqcliente equal        zeros
      *      MOVE    ARQVENDENDOR-CLIENTE
      *                             TO           wk-cliente
      *      PERFORM                0037-DISPLAY
      *       read   arqcliente    NEXT
      *     END-IF.
      *----------------------------------------------------------------
       0037-DISPLAY.
      *    DISPLAY    SC-REGISTRO.
      *----------------------------------------------------------------
       9999-fim-programa.

           GOBACK.
      *    close arqcliente.
           exit program.

           end program relatoriocliente.

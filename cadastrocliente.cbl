       program-id. cadastros as "cadastros".

       environment division.
       configuration section.
       special-names.
           decimal-point is comma.

       input-output section.
       file-control.

      * copy arqclienteselect.cpy.

       data division.

           file section.

      *     copy arqclientefd.cpy.

           WORKING-STORAGE SECTION.
           01 wk-workarea.
              05 wid-arq-cliente        pic x(070) value spaces.
              05 wk-STOP                pic 9(001) value zeros.
              05 wk-opcao               pic 9(001) value zeros.
              05 fl-ok                  pic x(001) value spaces.
              05 wk-msg                 pic X(050) value spaces.
           01  wk-cliente.
            03  wk-chave.
             05 wk-codigo             pic  9(007) value zeros.
             05 wk-cnpj               pic  9(014) value zeros.
             05 wk-raz-soc            pic  X(040) value zeros.
            03 wk-lat                 pic  9(011) value zeros.
            03 wk-lon                 pic  9(011) value zeros.


      *    copy arqclientefs.cpy.

           SCREEN SECTION.
           01  SC-TELA-ARQUIVO.
               05  blank screen.
               05  line  1   col  05 VALUE
                         "Informe o caminho do arquivo".
               05  line  1   col  40   using wid-arq-cliente.
      *-----------------------------------------------------------------
           01  SC-TELA-INICIAL.
               05  blank screen.
               05  line  1   col  05 VALUE
                         "CADASTRO DE CLIENTE".
               05  line  3   col 05 value
                         "1 Para inclusao".
               05  line  4   col 05 value
                         "2 Para alteracao".
               05  line  5   col 05 value
                         "3 Para exclusao".
               05  line  5   col  30   using wk-opcao.
               05  line  10  col  43   using wk-msg.
      *------------------------------------------------------------------------

           01  SC-TELA-CADASTRO.
               05  blank screen.
               05  line  1   col  05 VALUE
                         "CADASTRO DE CLIENTE".
               05  line  3   col 05 value
                         "Informe o codigo do cliente".
               05  line  3   col  43   using wk-codigo.

               05  line  4   col 05 value
                         "Informe o cnpj do cliente".
               05  line  4   col  43   using wk-cnpj.

               05  line  5   col 05 value
                         "Informe a razao social".
               05  line  5   col  43   using wk-raz-soc.

               05  line  6   col 05 value
                         "Informe a latitude".
               05  line  6   col  43   using wk-lat.

               05  line  7   col 05 value
                         "Informe a longitude".
               05  line  7   col  43   using wk-lon.
               05  line  10   col  43  using wk-msg.
      *------------------------------------------------------------------------

            01  SC-TELA-GENERICA.
               05  blank screen.
               05  line  1   col  05 VALUE
                         "CONSISTIR  CLIENTE".
               05  line  3   col 05 value
                         "Informe o codigo do cliente".
               05  line  3   col  43   using wk-codigo.

               05  line  10   col  43  using wk-msg.

       procedure division.



       perform       0000-controle.

       PERFORM       0010-GET-SC-TELA-INICIAL.

       perform       9999-fim-programa.

       0000-controle.
       INITIALIZE    wk-cliente
                     wk-workarea.
           DISPLAY   SC-TELA-ARQUIVO.
           ACCEPT    SC-TELA-ARQUIVO.
      *     open i-o wid-arq-cliente.

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
            INITIALIZE    wk-cliente
                          wk-workarea
                          SC-TELA-INICIAL
                          SC-TELA-CADASTRO
                          SC-TELA-GENERICA.
           DISPLAY     SC-TELA-INICIAL.
           ACCEPT      SC-TELA-INICIAL.

           IF          WK-OPCAO      EQUAL      '1'
             INITIALIZE wk-cliente
                       wk-workarea
             PERFORM   0020-INCLUSAO
           END-IF.
           IF          WK-OPCAO      EQUAL      '2'
             INITIALIZE wk-cliente
                       wk-workarea
             PERFORM   0030-ALTERACAO
           END-IF.
           IF          WK-OPCAO      EQUAL      '3'
             INITIALIZE wk-cliente
                       wk-workarea
             PERFORM   0040-EXCLUSAO
           END-IF.

           IF          WK-OPCAO      NOT EQUAL  '9'
            PERFORM     0010-GET-SC-TELA-INICIAL
           END-IF.
      *---------------------------------------------------------------
       0020-INCLUSAO.

           DISPLAY    SC-TELA-CADASTRO.
           ACCEPT     SC-TELA-CADASTRO.
           initialize  wk-msg.
           PERFORM    0025-CONSISTE-GRAVA-TELA.
      *---------------------------------------------------------------
       0025-CONSISTE-GRAVA-TELA.

           IF        wk-codigo      EQUAL        ZEROS
            OR       wk-codigo      EQUAL        SPACES
               MOVE  'Informar o codigo do cliente'
                                    to           wk-msg
      *     ELSE
      *        MOVE  wk-chave       to           arqcliente-chave.
      *        READ  ARQCLIENTE
      *        IF    FS-ARQCLIENTE  EQUAL        ZEROS
      *         MOVE "Codigo de cliente ja cadastrado"
      *                             TO           wk-msg
      *        END-IF.
               perform 0020-INCLUSAO
           END-IF.

           IF        wk-cnpj        EQUAL        zeros
               MOVE  'Informar o cnpj'
                                    to           wk-msg
               perform 0020-INCLUSAO
           ELSE
               PERFORM              0017-consiste-cnpj
           END-IF.

           IF        wk-raz-soc     EQUAL        SPACES
               MOVE  'Informar a reazao social'
                                    to           wk-msg
               perform 0020-INCLUSAO
           END-IF.

           IF        wk-lat         EQUAL        ZEROS
            OR       wk-lat         EQUAL        SPACES
               MOVE  'Informar a latitude'
                                    to           wk-msg
               perform 0020-INCLUSAO
           END-IF.

           IF        wk-lon         EQUAL        ZEROS
            OR       wk-lon         EQUAL        SPACES
               MOVE  'Informar a longitude'
                                    to           wk-msg
               perform 0020-INCLUSAO
           END-IF.

      *    MOVE      WK-CLIENTE     TO          ARQCLIENTE-CLIENTE.
      *    WRITE     ARQCLIENTE-CLIENTE.

           INITIALIZE WK-OPCAO.
      *-----------------------------------------------------------------
           0017-consiste-cnpj.

      *    move      wk-cnpj        to           arqcliente-cnpj
      *    read      arqcliente
      *     if       fs-arqcliente  equal        zeros
      *      MOVE    'CNPJ ja cadastradao'
      *                              to          wk-msg
      *      PERFORM                 0020-INCLUSAO
      *     END-IF.
      *---------------------------------------------------------------
       0030-ALTERACAO.

           INITIALIZE SC-TELA-GENERICA.
           DISPLAY    SC-TELA-GENERICA.
           ACCEPT     SC-TELA-GENERICA.

           initialize  wk-msg.
           PERFORM    1000-CONSISTE-REGISTRO.
      *     IF        fl-ok          equal       's'
            PERFORM   0036-MOVER-DADOS.
            PERFORM   0037-GRAVAR-ALTERACAO.
      *     END-IF.
      *---------------------------------------------------------------
       0036-MOVER-DADOS.

           INITIALIZE SC-TELA-CADASTRO.
           DISPLAY    SC-TELA-CADASTRO.
           ACCEPT     SC-TELA-CADASTRO.
      *    MOVE       WK-CLIENTE
      *                              TO          ARQCIENTE-CLIENTE.

      *---------------------------------------------------------------
       0037-GRAVAR-ALTERACAO.

      *     move      wk-chave       to          arqcliente-chave.
      *     start     arqcliente key is ==       arqcliente-chave.
      *     if        fs-arqcliente  equal       zeros
      *         WRITE ARQCLIENTE-CLIENTE.
      *     else
      *         MOVE  'Registro foi excluido'
      *                              to           wk-msg
      *         PERFORM              0030-ALTERACAO
      *     END-IF.
      *---------------------------------------------------------------
       0040-EXCLUSAO.
      *---------------------------------------------------------------
           INITIALIZE                SC-TELA-GENERICA
                                     WK-MSG.
           DISPLAY    SC-TELA-GENERICA.
           ACCEPT     SC-TELA-GENERICA.
           PERFORM    1000-CONSISTE-REGISTRO.
      *    if         fl-ok          equal        's'
           PERFORM    0047-EXCLUIR.
      *    END-IF.
           INITIALIZE WK-OPCAO.
      *---------------------------------------------------------------
       0047-EXCLUIR.
      *     DELETE arqcliente-cliente RECORD
      *      INVALID KEY DISPLAY 'codigo invalido'
      *      NOT INVALID KEY DISPLAY 'Registro deletado'
      *     END-DELETE.
      *---------------------------------------------------------------
       1000-CONSISTE-REGISTRO.

      *     move      wk-codigo      to           arqcliente-codigo.
      *     start     arqcliente key IS
      *                              EQUAL        arqcliente-chave.
      *     if        fs-arqcliente  equal        zeros
      *         MOVE  'S'            TO           FL-OK
      *     else
      *         MOVE  'Registro inexistente'
      *                              to           wk-msg
      *         PERFORM              0030-ALTERACAO
      *     END-IF.




       9999-fim-programa.
                 GOBACK.
      *    close arqcliente.
           exit program.

       end program cadastros.

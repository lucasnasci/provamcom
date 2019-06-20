       program-id. cadastrovendedor as "cadastrovendedor".

       environment division.
       configuration section.
       special-names.
           decimal-point is comma.

       input-output section.
       file-control.

      * copy arqvendedorselect.cpy.

       data division.

           file section.

      *     copy arqvendedorfd.cpy.

           WORKING-STORAGE SECTION.
           01 wk-workarea.
              05 wid-arq-cliente        pic x(070) value spaces.
              05 wk-STOP                pic 9(001) value zeros.
              05 wk-opcao               pic 9(001) value zeros.
              05 fl-ok                  pic x(001) value spaces.
              05 wk-msg                 pic X(050) value spaces.
           01  wk-vendedor.
            03  wk-chave.
             05 wk-codigo               pic  9(007) value zeros.
             05 wk-cpf                  pic  9(011) value zeros.
             05 wk-nome                 pic  X(040) value zeros.
            03 wk-lat                   pic  9(011) value zeros.
            03 wk-lon                   pic  9(011) value zeros.


      *        copy arqvendedorfs.cpy.

           SCREEN SECTION.
           01  SC-TELA-ARQUIVO.
               05  blank screen.
               05  line  1   col  05 VALUE
                         "Informe o caminho do arquivo".
               05  line  1   col  40   using wid-arq-cliente.
           01  SC-TELA-INICIAL.
               05  blank screen.
               05  line  1   col  05 VALUE
                         "CADASTRO DE VENDEDOR".
               05  line  3   col 05 value
                         "1 Para inclusao".
               05  line  4   col 05 value
                         "2 Para alteracao".
               05  line  5   col 05 value
                         "3 Para exclusao".
               05  line  6   col 05 value
                         "9 Para encerrar".
               05  line  6   col  30   using wk-opcao.
               05  line  10  col  43   using wk-msg.
      *------------------------------------------------------------------------

            01  SC-TELA-CADASTRO.
               05  blank screen.
               05  line  1   col  05 VALUE
                         "CADASTRO DE VENDEDOR".
               05  line  3   col 05 value
                         "Informe o codigo do vendedor".
               05  line  3   col  43   using wk-codigo.

               05  line  4   col 05 value
                         "Informe o cnpj do vendedor".
               05  line  4   col  43   using wk-cpf.

               05  line  5   col 05 value
                         "Informe a razao social".
               05  line  5   col  43   using wk-nome.

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
                         "CONSISTIR  VENDEDOR".
               05  line  3   col 05 value
                         "Informe o codigo do vendedor".
               05  line  3   col  43   using wk-codigo.

               05  line  10   col  43  using wk-msg.

       procedure division.



       perform       0000-controle.

       PERFORM       0010-GET-SC-TELA-INICIAL.

       perform       9999-fim-programa.

       0000-controle.
       INITIALIZE    wk-vendedor
                     wk-workarea.
           DISPLAY   SC-TELA-ARQUIVO.
           ACCEPT    SC-TELA-ARQUIVO.

      *     open i-o wid-arq-cliente.

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


      *----------------------------------------------------------------


      *---------------------------------------------------------------
       0010-GET-SC-TELA-INICIAL.
            INITIALIZE    wk-vendedor
                          wk-workarea
                          SC-TELA-INICIAL
                          SC-TELA-CADASTRO
                          SC-TELA-GENERICA.
           DISPLAY     SC-TELA-INICIAL.
           ACCEPT      SC-TELA-INICIAL.

           IF          WK-OPCAO      EQUAL      '1'
             INITIALIZE wk-vendedor
                       wk-workarea
             PERFORM   0020-INCLUSAO
           END-IF.
           IF          WK-OPCAO      EQUAL      '2'
             INITIALIZE wk-vendedor
                       wk-workarea
             PERFORM   0030-ALTERACAO
           END-IF.
           IF          WK-OPCAO      EQUAL      '3'
             INITIALIZE wk-vendedor
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
               MOVE  'Informar o codigo do vendedor'
                                    to           wk-msg
      *     ELSE
      *        MOVE  wk-chave       to           arqvendedor-chave.
      *        READ  ARQVENDEDOR
      *        IF    FS-ARQVENDEDOR  EQUAL        ZEROS
      *         MOVE "Codigo de vendedor ja cadastrado"
      *                             TO           wk-msg
      *        END-IF.
               perform 0020-INCLUSAO
           END-IF.

           IF        wk-cpf        EQUAL        zeros
               MOVE  'Informar o cnpj'
                                    to           wk-msg
               perform 0020-INCLUSAO
           ELSE
               PERFORM              0017-consiste-cnpj
           END-IF.

           IF        wk-nome     EQUAL        SPACES
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

      *    MOVE      WK-VENDEDOR     TO          ARQVENDEDOR-VENDEDOR.
      *    WRITE     ARQVENDEDOR-VENDEDOR.

           INITIALIZE WK-OPCAO.
      *-----------------------------------------------------------------
           0017-consiste-cnpj.

      *    move      wk-cnpj        to           arqvendedor-cnpj
      *    read      arqvendedor
      *     if       fs-arqvendedor  equal        zeros
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
      *---------------------------------------------------------------
       0036-MOVER-DADOS.

           INITIALIZE SC-TELA-CADASTRO.
           DISPLAY    SC-TELA-CADASTRO.
           ACCEPT     SC-TELA-CADASTRO.
      *    MOVE       WK-VENDEDOR
      *                              TO          ARQCIENTE-VENDEDOR.

      *---------------------------------------------------------------
       0037-GRAVAR-ALTERACAO.

      *     move      wk-chave       to          arqvendedor-chave.
      *     start     arqvendedor key is ==       arqvendedor-chave.
      *     if        fs-arqvendedor  equal       zeros
      *         WRITE ARQVENDEDOR-VENDEDOR.
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
      *     DELETE arqvendedor-vendedor RECORD
      *      INVALID KEY DISPLAY 'codigo invalido'
      *      NOT INVALID KEY DISPLAY 'Registro deletado'
      *     END-DELETE.
      *---------------------------------------------------------------

       1000-CONSISTE-REGISTRO.

      *     move      wk-codigo      to           arqvendedor-codigo.
      *     start     arqvendedor key IS
      *                              EQUAL        arqvendedor-chave.
      *     if        fs-arqvendedor  equal       zeros
      *         MOVE  'S'            TO           FL-OK
      *     else
      *         MOVE  'Registro inexistente'
      *                              to           wk-msg
      *         PERFORM              0030-ALTERACAO
      *     END-IF.




       9999-fim-programa.
                 GOBACK.
      *    close arqvendedor.
           exit program.

       end program cadastrovendedor.

      ******************************************************************
      * Author: Lucas José Nascimento
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
           program-id. menu as "menu".

           environment division.
           configuration section.
           special-names.
               decimal-point is comma.

           input-output section.
           file-control.
      *    copy arqclienteselect.

           DATA DIVISION.
            FILE SECTION.
      *      copy arqclientefd.

            WORKING-STORAGE SECTION.
           01 wk-workarea.
              05 wk-opcao             pic 9(005) value zeros.

      *        copy arqclientefs.

            SCREEN SECTION.
              01  SC-TELA-INICIAL.
               05  blank screen.
               05  line  1   col  05 VALUE
                         "MENU".
               05  line  3   col 05 VALUE
                         "CADASTRO".
               05  line  4   col 05 value
                         "01.01 - Cadastro de Cliente".
               05  line  5   col  05 value
                         "01.02 - Cadastro de Vendedor".
               05  line  7   col  05 value
                         "RELATORIOS".
               05  line  8   col  05 value
                         "02.01 - Relatorio de Clientes".
               05  line  9   col  05 value
                         "03.02 - Relatorio de Vendedores".
               05  line  11  col  05 value
                         "EXECUTAR".
               05  line  12  col  05 value
                         "03.01 - Executar Distribuição de Clientes".
               05  line  13   col  20 value " Informe o Processo: ".
               05  line  13   col  43  pic x(005) using wk-opcao.

           PROCEDURE DIVISION.
            0000-INICIO.

               PERFORM     0010-GET-SC-TELA-INICIAL.


            0010-GET-SC-TELA-INICIAL.

                display    SC-TELA-INICIAL.
                accept     SC-TELA-INICIAL.
                PERFORM    0015-CONSISTE-TELA.

            0015-CONSISTE-TELA.
                EVALUATE   WK-OPCAO
                 WHEN      '01.01'
                  call     "cadastrocliente" using wk-opcao
                 WHEN      '01.02'
                  call     "cadastrovendedor" using wk-opcao
                 WHEN      '02.01'
                  call     "realtoriocliente" using wk-opcao
                 WHEN      '02.02'
                  call     "relatoriovendedor" using wk-opcao
                 WHEN      '03.01'
                  call     "executar" using wk-opcao


            STOP RUN.
           9999-fim-programa.

               EXIT PROGRAM.


                   end program menu.

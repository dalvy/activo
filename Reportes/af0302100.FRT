   �   !                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              Arial                          F  .  winspool  EPSON Stylus CX4700 Series  USB001                                            �EPSON Stylus CX4700 Series       � <��  �
od   �  �                                                                                       	EPSON Stylus CX4700 Series      DLLName32=E_FUICADL.DLL                                                                              ��           �                                                                               �                     X   @                                                                                                                                                                                   TS_URL TSupportURL  PSOLVER                                                                                             4  �   	     �  �  �  8  �  �  @  �   T   T   T   T                   �  8                                   ^                                   � 2  }       
                                                                                                           �DRIVER=winspool
DEVICE=EPSON Stylus CX4700 Series
OUTPUT=USB001
ORIENTATION=0
PAPERSIZE=1
PAPERLENGTH=2794
PAPERWIDTH=2159
COPIES=1
DEFAULTSOURCE=7
COLOR=1
DUPLEX=1
COLLATE=0
         cFinal.cap_act                 !"- " + ALLTRIM(STR(_PAGENO))+" -"                                                              Arial                          "Usuario: "+cusuario                                          Arial                          ceps                                                          Arial                          	cSucursal                                                     Arial                          cversion                                                      Arial                          Arial                          ""BIENES PRINCIPALES / COMPONENTES"                              DATE()                                                        Arial                          TIME()                                                        Arial                          "@I"                           Arial                          "Descripci�n"                  "@I"                           Arial                          "C�digo"                       cFinal.cap_act                                                Arial                          cFinal.des_pri                                                Arial                          "@I"                           Arial                          "Fecha"                        "@I"                           Arial                          "Estado"                       cFinal.fin_pri                                                Arial                          "@E"                           NIIF(edo_pri="1","DEPR",IIF(edo_pri="2","NODE",IIF(edo_pri="3","BAJA","TODE")))                                                  Arial                          "@I"                           Arial                          	"Ingreso"                      cod_act                                                       Arial                          des_act                                                       Arial                          fin_act                                                       Arial                          "@E"                           NIIF(edo_act="1","DEPR",IIF(edo_act="2","NODE",IIF(edo_act="3","BAJA","TODE")))                                                  Arial                          Arial                          "Principal"                    Arial                                                         "Componentes"                  Arial                          Arial                          Arial                          Arial                          Arial                          Arial                          Arial                          dataenvironment                GLeft = 19
Top = 323
Width = 520
Height = 200
Name = "Data0101101"
                         1PROCEDURE Destroy
SELECT cFinal
USE
ENDPROC
PROCEDURE Init
SELECT Cpaf0050.cod_act, Cpaf0050.des_act, Cpaf0050.fin_act, ;
	   Cpaf0050.edo_act, Cpaf0050.cap_act ;
 FROM Cpaf0050 ;
 WHERE !EMPTY(Cpaf0050.cap_act) AND ;
       Cpaf0050.cod_suc = cSucActiva ;
 INTO CURSOR cTmp01
SELECT cTmp01.*, Cpaf0050.des_act AS des_pri, ;
	   Cpaf0050.fin_act AS fin_pri, Cpaf0050.edo_act AS edo_pri ;
 FROM cTmp01, Cpaf0050 ;
 WHERE Cpaf0050.cod_act = cTmp01.cap_act ;
 ORDER BY 1 ;
 INTO CURSOR cFinal

SELECT cTmp01
USE
SELECT cFinal
GO TOP
ENDPROC
                              I���    0  0                        7�   %   �      �     �          �  U    F�  � Q� U  CFINAL� a o� Cpaf0050��  � ���  � ���  � ���  � ���  � ���C�  � �
� �  � � 	���� cTmp01�f o� cTmp01� Cpaf0050� ���  � �Q�	 ��  � �Q�
 ��  � �Q� ���  � � � �������� cFinal� F� � Q� F� � #)� U  CPAF0050 COD_ACT DES_ACT FIN_ACT EDO_ACT CAP_ACT COD_SUC
 CSUCACTIVA CTMP01 DES_PRI FIN_PRI EDO_PRI CFINAL Destroy,     �� InitF     ��1 q A 2 fr A q Q 1                       %         @   &      )   0                  
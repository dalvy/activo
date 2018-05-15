*: Funciones Generales
FUNCTION Eom(dFecha)
********************
* Retorna el ultimo dia segun la fecha
*
If Month(dFecha)=12
   dEFecha = Ctod( "01/01/"+Str(Year(dFecha)+1,4) ) - 1
Else
   dEFecha = Ctod( "01/"+PadL(Month(dFecha)+1,2,"0")+"/"+Str(Year(dFecha),4) ) - 1
EndIf   
RETURN dEFecha


FUNCTION StrZero(nVar,nLen)
cTemp = alltrim(str(nVar,15))
cTemp = padl(cTemp,nLen,"0")
RETURN cTemp


PROCEDURE FntAppQuit
nTmp = messagebox("Esta Seguro de Salir ",4+32)
IF nTmp = 6
   oAppMain.quit
ENDIF

** Determina si es directorio **
FUNCTION Esdir
PARAMETER cdir
lflag = .T.
cdir = ALLT(cdir)
IF SUBSTR(cdir,LEN(cdir),1) # "\"
	cdir = cdir + "\"
ENDIF
ON ERROR lflag = .F.
ruta_actual = SET("DEFAULT")+SYS(2003)
SET DEFA TO &cdir
SET DEFA TO &ruta_actual
RETURN lflag


** Devuelve el nombre del mes **
FUNCTION CAD_MES
  PARAMETER fmes
  cadmes = ""
  DO CASE
     CASE fmes = 1
          cadmes = "Enero"
     CASE fmes = 2
          cadmes = "Febrero"
     CASE fmes = 3
          cadmes = "Marzo"
     CASE fmes = 4
          cadmes = "Abril"
     CASE fmes = 5
          cadmes = "Mayo"
     CASE fmes = 6
          cadmes = "Junio"
     CASE fmes = 7
          cadmes = "Julio"
     CASE fmes = 8
          cadmes = "Agosto"
     CASE fmes = 9
          cadmes = "Setiembre"
     CASE fmes = 10
          cadmes = "Octubre"
     CASE fmes = 11
          cadmes = "Noviembre"
     CASE fmes = 12
          cadmes = "Diciembre"
  ENDCASE        
RETURN cadmes  

** Busca Grupo **
FUNCTION buscaGrupo
PARAMETER cGrupo
lflag = .F.
area_act = "SELECT "+ALIAS()
USE bdActivos!cpaf0010 ORDER TAG cod_grp IN 0 ALIAS grupo AGAIN
SELECT grupo
SEEK cGrupo
IF FOUND()
	lflag = .T.
	cDescGrupo = des_grp
ENDIF
USE
IF LEN(area_act)> LEN("SELECT ")
	&area_act
ENDIF
RETURN lflag


** Busca Sub Grupo **
FUNCTION buscaSubgrupo
PARAMETER cSubgrp
lflag = .F.
area_act = "SELECT "+ALIAS()
USE bdActivos!cpaf0015 ORDER TAG rub_item IN 0 ALIAS subgrupo AGAIN
SELECT subgrupo
SEEK cSubgrp
IF FOUND()
	lflag = .T.
	cDescSubgr = des_sgr
	ENDIF
USE
IF LEN(area_act)> LEN("SELECT ")
	&area_act
ENDIF
RETURN lflag

** Busca activos **
FUNCTION buscaActivo
PARAMETER cActivo, cTip  && cTipo = Nivel (Principal o Dependiente)
lflag = .F.
cDescActi = ""
area_act = "SELECT "+ALIAS()
USE bdActivos!cpaf0050 ORDER TAG cod_act IN 0 ALIAS activos AGAIN
SELECT activos
DO CASE
	CASE cTip = "ALL" && Todos de Sucursal Activa
		SET FILTER TO cod_suc = cSucActiva
	CASE cTip = "PRIN" && De Nivel 1: Principales
		SET FILTER TO cod_suc = cSucActiva AND EMPTY(cap_act)
	CASE cTip = "DEPE" && De Nivel 2 Dependientes
		SET FILTER TO cod_suc = cSucActiva AND !EMPTY(cap_act)
ENDCASE
SEEK cActivo
IF FOUND()
	lflag = .T.
	cDescActi = des_act
ENDIF
USE
IF LEN(area_act)> LEN("SELECT ")
	&area_act
ENDIF
RETURN lflag

** Busca Cuenta Contable **
FUNCTION buscaCtas
PARAMETERS cCuenta, cTip
lflag = .F.
area_act = "SELECT "+ALIAS()
cArchivo = cRutaconta+"Fcon0015"
USE &cArchivo ORDER TAG ctadetalle IN 0 Alias PLANCTAS AGAIN
IF !USED("cpaf0000")
	USE bdActivos!cpaf0000 IN 0
ENDIF
SELECT cpaf0000
DO CASE
	CASE cTip = "ALL"  &&Todos 
		cFiltrotmp = ALLT(cpaf0000.filtrocta)
		cFiltro = "SET FILTER TO ccta = '"+StrTran(cFiltrotmp, ".", "' OR ccta = '")+"'"
	CASE cTip = "TER"  &&Terrenos
		cFiltro = "SET FILTER TO ccta = '"+ALLT(cta_terreno)+"'"
	CASE cTip = "OBR"  &&Obras
		cFiltro = "SET FILTER TO ccta = '"+ALLT(cta_terreno)+"'"
	CASE cTip = "TAC"  &&Terrnos ACM
		cFiltro = "SET FILTER TO ccta = '"+ALLT(cta_terrenoacm)+"'"
	CASE cTip = "REI"  &&R.E.I.
		cFiltro = "SET FILTER TO ccta = '"+ALLT(cta_rei)+"'"
ENDCASE
SELECT cpaf0000
USE
SELECT PLANCTAS
&cFiltro
SEEK cCuenta
IF FOUND()
	lflag = .T.
	cDescCta = planctas.desc
ENDIF
USE
IF LEN(area_act)> LEN("SELECT ")
	&area_act
ENDIF
RETURN lflag


** Busca Centro de Costos **
FUNCTION buscaCtos
PARAMETER cCostos
lflag = .F.
area_act = "SELECT "+ALIAS()
cArchivo = cRutaCostos+"cct0004"
USE &cArchivo ORDER TAG cc000401 IN 0 Alias PLANCTOS AGAIN
SELECT PLANCTOS
SET FILTER TO tipcosto != "R"
SEEK cCostos
IF FOUND()
	lflag = .T.
	cDescCtos = planctos.desc
ENDIF
USE
IF LEN(area_act)> LEN("SELECT ")
	&area_act
ENDIF
RETURN lflag

** Busca Localidad Geográfica **

FUNCTION buscaLocGeo
PARAMETER cLocGeo
lflag = .F.
area_act = "SELECT "+ALIAS()
USE bdActivos!cpaf0031 ORDER TAG cod_lge IN 0 ALIAS locgeo AGAIN
SELECT locgeo
SEEK cLocGeo
IF FOUND()
	lflag = .T.
	cDescLocG = des_lge
ENDIF
USE
IF LEN(area_act)> LEN("SELECT ")
	&area_act
ENDIF
RETURN lflag


** Busca Personal **
FUNCTION buscaRRHH
PARAMETER cRRHH
lflag = .F.
cDescRRHH = ""
area_act = "SELECT "+ALIAS()
*cArchivo = cRutaRRHH+"plm"
cArchivo = cRutaRRHH+"RH001000"
USE &cArchivo ORDER TAG pk_trabaj IN 0 ALIAS RRHH AGAIN
SELECT RRHH
SEEK cRRHH
IF FOUND()
	lflag = .T.
	cDescRRHH = alltrim(apepattra) +" "+alltrim(apemattra) +" "+alltrim(nomtrabaj)
ELSE
	cDescRRHH = " "
ENDIF
USE
IF LEN(area_act)> LEN("SELECT ")
	&area_act
ENDIF
RETURN lflag



** Busca Unidad Orggánica **
FUNCTION buscaUORG
PARAMETER cUorg
lflag = .F.
area_act = "SELECT "+ALIAS()
cArchivo = cRutaPPTO+"unidad"
USE &cArchivo ORDER TAG cod_unidad IN 0 ALIAS UORG AGAIN
SELECT UORG
SEEK cUorg
IF FOUND()
	lflag = .T.
	cDescUORG = des_unidad
ENDIF
USE
IF LEN(area_act)> LEN("SELECT ")
	&area_act
ENDIF
RETURN lflag


** Retorna segun seteo el mes y ano de fecha de alta **
FUNCTION RetFAlt
PARAMETERS dFecha, nSwitch
Local nFAmes
DIMENSION nFAmes(2)
nFAmes(1) = Month(dFecha)
nFAmes(2) = Year(dFecha)
If nMimsoMes = 1
   If nSwitch=1
      nFAmes(1) = IIF(Month(dFecha)=1,12,Month(dFecha))
      nFAmes(2) = Year(dFecha) - IIF(Month(dFecha)=1,1,0)
   Else
      nFAmes(1) = Month(dFecha) - 1
   EndIf
EndIf
RETURN nFAmes


** Busca Sucursales **
FUNCTION buscaSucu
PARAMETER cSucu
lflag = .F.
area_act = "SELECT "+ALIAS()
USE bdActivos!cpaf0002 ORDER TAG act_suc IN 0 ALIAS sucursales AGAIN
SELECT sucursales
SEEK cSucu
IF FOUND()
	lflag = .T.
	cDescSucu = sucursales.act_nom
ENDIF
USE
IF LEN(area_act)> LEN("SELECT ")
	&area_act
ENDIF
RETURN lflag


** Busca Origen **
FUNCTION buscaOrigen
PARAMETER cSubgrp
lflag = .F.
area_act = "SELECT "+ALIAS()
USE bdActivos!cpaf0012 ORDER TAG pk_cod IN 0 ALIAS Origen AGAIN
SELECT Origen
SEEK cSubgrp
IF FOUND()
	lflag = .T.
	cDescOrigen = descrip
	ENDIF
USE
IF LEN(area_act)> LEN("SELECT ")
	&area_act
ENDIF
RETURN lflag

** Busca Origen **
FUNCTION buscaClase
PARAMETER cSubgrp
lflag = .F.
area_act = "SELECT "+ALIAS()
USE bdActivos!cpaf0013 ORDER TAG pk_cod IN 0 ALIAS Clase AGAIN
SELECT Clase
SEEK cSubgrp
IF FOUND()
	lflag = .T.
	cDescClase = descrip
	ENDIF
USE
IF LEN(area_act)> LEN("SELECT ")
	&area_act
ENDIF
RETURN lflag

** Busca Servicio **
FUNCTION buscaServicio
PARAMETER cSubgrp
lflag = .F.
area_act = "SELECT "+ALIAS()
USE bdActivos!cpaf0014 ORDER TAG pk_cod IN 0 ALIAS Servicio AGAIN
SELECT Servicio
SEEK cSubgrp
IF FOUND()
	lflag = .T.
	cDescServicio = descrip
	ENDIF
USE
IF LEN(area_act)> LEN("SELECT ")
	&area_act
ENDIF
RETURN lflag

** Busca Regulacion **
FUNCTION buscaRegula
PARAMETER cSubgrp
lflag = .F.
area_act = "SELECT "+ALIAS()
USE bdActivos!cpaf0016 ORDER TAG pk_clave IN 0 ALIAS Regulatoria AGAIN
SELECT Regulatoria
SEEK cSubgrp
IF FOUND()
	lflag = .T.
	cDescRegula = den_cla
	ENDIF
USE
IF LEN(area_act)> LEN("SELECT ")
	&area_act
ENDIF
RETURN lflag


FUNCTION creaTabla
 archPrg = SYS(3)
 DO WHILE ( FILE( archPrg + ".DBF" ) )
     archPrg = SYS(3)
 ENDDO
RETURN archPrg


* Retorna arreglo de sucursales segun nivel y tipo *
FUNCTION RetSucAct(cCodSuc,cNivel,cTipo)
Local nArea, lcierra
nArea = Select()
lcierra = .F.
IF cTipo="P" Or cNivel="L"     && Procesamiento
   gaSucAct[1] = cCodSuc
ELSE                           && Consolidados
   IF !USED("cpaf0002")
   		USE bdActivos!cpaf0002 IN 0
   		lcierra = .T.
   ELSE
   		SELECT cpaf0002
   ENDIF
   SELECT Cpaf0002.act_suc FROM Cpaf0002 ;
      WHERE IIF(cNivel="E",Cpaf0002.act_niv="Z",Left(Cpaf0002.act_suc,2)==Left(cCodSuc,2) And Cpaf0002.act_niv="L") ;
      INTO ARRAY gaSucAct
ENDIF
IF lcierra
	SELECT cpaf0002
	USE
ENDIF
Select(nArea)
RETURN

* Desactiva opciones del menu en funcion a tipo Sucursal P o C *
FUNCTION desMenu
PARAMETER cTipo
IF cTipo = "C"
	STORE .T. TO m2010000000, m2020000000, m2030000000, m2040000000, m2050000000, ;
		         m2060000000, m2070000000, m2080000000, m2090000000, m2100000000, ;
		         m2110000000, m2120000000, m2130000000, m2140000000, m2150000000 
ELSE
	STORE .F. TO m2010000000, m2020000000, m2030000000, m2040000000, m2050000000, ;
		         m2060000000, m2070000000, m2080000000, m2090000000, m2100000000, ;
		         m2110000000, m2120000000, m2130000000, m2140000000, m2150000000 
ENDIF
RETURN

* Verifica periodo *
FUNCTION Seleper
PARAMETERS Wano,Wmes
WAno = StrZero(WAno,4)
WMes = StrZero(WMes,2)
Locate For PER_VER = WAno+WMes
If Found()
   If left(EDO_VER,1)='N'
      RETURN .T.
   Else
     = MESSAGEBOX("Periodo cerrado...!",0+48,"Error...")
   EndIf
Else
    = MESSAGEBOX("Periodo no aperturado ...!",0+48,"Error...")
EndIf
WMes = Val(wMes)
WAno = Val(WAno)
RETURN .F.

Function Sumadepre
Parameter Mes1, Mes2
Valordep = 0
For I = Mes1  To   Mes2
    cTableName = IIF(gnMetDepDef=1,"CPAF0080","CPAF0081")
	cCampo = cTableName  + ".D"+ Padl( Alltrim( STR(I) ),2,"0")+"_DEP" 
    ValorDep =  ValorDep + &cCampo
EndFor
Return ValorDep

Function Acum_dep
Parameter xMes
Local wAcuTotal
wAcuTotal = 0
For X = 0  To  Val(xMes)
    cTableName = IIF(gnMetDepDef=1,"CPAF0080","CPAF0081")
    cCampo    = cTableName + ".D"+Padl(Alltrim(Str(X)),2,"0") +"_DEP"
    WAcuTotal = WAcutotal + &cCampo
Next
Return  WAcuTotal


Function SumField
	Parameter RanInicial, RanFinal
	ValSuma = 0	
	For X = RanInicial to RanFinal
		cCampo ="Cpaf0070.V"+ Padl( Alltrim(Str( X) ) ,2,"0")  +"_Ope"
		ValSuma = ValSuma +&cCampo
	EndFor
Return ValSuma


*:*****************************************************
*: Muestra mensaje de Una Tabla
*:*****************************************************
PROCEDURE msgtable
parameters nCual
cAlAnt = alias()
SELECT 0
SELECT texto,detalle,tipico FROM CpafError WHERE idmensaje = strzero(nCual,10) INTO CURSOR x
IF _TALLY > 0
  ntip = val(x.tipico)
  ctex = x.texto
  cdet = x.detalle
  DO FORM CtrlError with ctex,cdet,ntip
ELSE
    =messagebox("No existen códigos de ayuda")
ENDIF
SELECT CpafError
USE
SELECT x
USE
Select(cAlAnt)


*:*****************************************************
*: Muestra mensaje Enviado
*:*****************************************************
PROCEDURE msgAdvertText
PARAMETERS texto,deta,tip
DO FORM CtrlError with texto,deta,tip


PROCEDURE msginfotext
PARAMETERS texto,deta,tip
lFormResu = .f.
DO FORM CtrlInfo with texto,deta,tip
RETURN lFormResu





PROCEDURE AdmError
*oError = CREATEOBJECT("cstctrlerror")
*oError.ShowError
*oAppMain.numerror = oError.numerror
*RELEASE oError
*RETURN 0
=Aerror(materr)
IF Alen(materr,1) = 0
   RETURN .F.
ENDIF
DO CASE
      CASE materr[1,1] = 1884  && Unicidad de indice
           =msgtable(2)
      CASE materr[1,1] = 1539  && Integridad referencial
           =msgtable(3)
      CASE materr[1,1] = 1585  && Conflicto de Actualización
           =msgtable(4)
      OTHERWISE
           =msgAdvertText(Message(),"",1)
ENDCASE
IF TYPE("OAPPMAIN.NUMERROR") <> "U"
	oAppMain.NumError = materr[1,1]
ENDIF



*:*****************************************************
*: Devuelve una cadena con ceros a la izquierda
*:*****************************************************
PROCEDURE StrZero(nVar,nLen)
cTemp = alltrim(str(nVar,nLen))
cTemp = padl(cTemp,nLen,"0")
RETURN cTemp


function yxx
wait wind str(v01_dep,12,2)
return .t.

FUNCTION RetDateTime(dFecha,cHora)
**********************************
* Retorna en formato DateTime
*
nAnio = Year(dFecha)
nMes = Month(dFecha)
nDia = Day(dFecha)
nHora = Int(Val(Left(cHora,2)))
nMinutos = Int(Val(Subs(cHora,4,2)))
nSegundos = Int(Val(Right(cHora,2)))
dFechaHora = DateTime(nAnio,nMes,nDia,nHora,nMinutos,nSegundos)
RETURN dFechahora


PROCEDURE ErrHandle
LOCAL lnChoice
	#DEFINE ERR_LOC "Error : "
	#DEFINE FILEINUSE_LOC "Un formulario no puede estar abierto simultáneamente en modo de diseño y en ejecución."
	#DEFINE FILEREADONLY_LOC "Uno de los archivos necesarios está marcado como de sólo lectura." + CHR(13) + "Asegúrese de que tiene acceso de lectura y escritura al archivo."

	DO CASE
		CASE ERROR() = 3 && File is in use
			=MESSAGEBOX( ERR_LOC + MESSAGE() + CHR(13) + ;
				FILEINUSE_LOC, 0 + 48)
				
		CASE ERROR() = 1718 && File is read-only
			=MESSAGEBOX( ERR_LOC + MESSAGE() + CHR(13) + ;
				 FILEREADONLY_LOC, 0 + 48)
			RETRY
		CASE ERROR() = 1881 && Trying to load DE of solution.scx when table is already open
			CLOSE DATA ALL
	*		DO FORM solution
		OTHERWISE
			lnChoice = MESSAGEBOX(ERR_LOC + ALLTRIM(STR(ERROR())) + CHR(13) + ;
				MESSAGE(), 48," AVISO ")
			*IF lnChoice = 2 && Cancel
			   cPrograma = Program()
			   Return To &cPrograma
                *ON ERROR &gcOldError
				*CLEAR EVENTS
				*CLOSE ALL
 				*RELEASE ALL
 				*CLEAR ALL
			*ENDIF	
	ENDCASE
ENDPROC

FUNCTION RetFileTmp()
*********************
* Genera Nombres para archivos temporales
*
cNewFileTmp = gcPathTmps+SUBSTR(SYS(2015), 3, 10) 
RETURN cNewFileTmp
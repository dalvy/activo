*: Programa Principal
*: -------------------

*: Fijando Configuración de Entorno
SET PATH TO .\CLASES, .\FORMULARIOS, .\GRAFICOS, .\OLES, .\OTROS, .\DATA, .\REPORTES, .\PRGS, ..\iconos
SET DELETE ON
SET CENTURY ON
SET TALK OFF
SET SAFETY OFF
SET EXCLUSIVE OFF
SET DATE TO BRITISH
SET CENT ON

*: Estableciendo Libreria de Programas
SET PROCEDURE TO sys02

*: Estableciendo Librerias de Clases a Utilizar
SET CLASSLIB TO libclases
SET CLASSLIB TO sysclass ADDITIVE
SET CLASSLIB TO AppClases ADDITIVE

ON ERROR DO AdmError

*!*	if not (Date() > Ctod("01/01/2010") And Date() < Ctod("30/06/2010"))
*!*	   =MessageBox("El Aplicativo no puede ejecutarse por que ha caducado su PERIODO DE EVALUACION"+K_ENTER+;
*!*	               "Gracias por su interés..." ,64,"Advertencia")
*!*	   quit
*!*	EndIf

*: Variables Públicas
PUBLIC cEps, cDivision, cTituloBarra, cUsuario, cVersion, cCodUsuario, cRutaHome, cPassword, cRuc, cMetDep, cMetAut, gcCodUsuario,;
       glCrypto, gcCadChrOneVF6, gcCadChrTwoVF6, glIncluirTrabajadorEnCodBarras, glClasRegul
STORE "" TO cEps, cDivision, cTituloBarra, cUsuario, cVersion, cCodUsuario, cRutaHome, cPerPro

gcOldDir      = FULLPATH(CURDIR())
gcCadChrOneVF6 = "ABCDEFGHIJKLMNOPQRSTUabcdefghijklmnopqrstuvwxyz1234567890/:\$"
gcCadChrTwoVF6 = "¡²³¤€¼½¾‘’¥×¬»«öóíúüþ®éåäáßðø¶´¿çµñ©æ!@#$%^&*()_+£ÉÿØƒÇXDÐÞ§~"
*: Cargando
SELECT * FROM SYS002 INTO CURSOR prmt
cEps         = empresa
cDivision    = division
cTituloBarra = titulobarr
cVersion     = subsistema
cBasedat     = alltrim(Basedat)
if ("GESTOR" $ ruta) Then
	cRutaHome    = alltrim(ruta)
	cDbsys       = alltrim(ruta)+"\data\sysdata"
    cDbbase      = alltrim(ruta)+"\data\"+alltrim(cBasedat)

	glCrypto = .F.
else	
	cRutaHome    = ChrTran(allt(ruta),gcCadChrTwoVF6, gcCadChrOneVF6)
	cDbsys       = cRutaHome+"sysdata"
    cDbbase      = cRutaHome+alltrim(cBasedat)
	glCrypto = .T.
endif

cRucSedacusco = "20136353315"  && Sedacusco (Cusco)
cRucEpsasa = "20143079075"  && Epsasa (Ayacucho)
cRucJaen = "20141814312"  && Eps marañon (Jaen)
cRucEmapacopsa = "20128985841" && Eps Emapacopsa (Pucallpa)
cRucBagua = "20105087978"  && Bagua
cRucEpssumu = "20171727783"  && Epssumu Eps Bagua Grande Epssumu
cRucHuacho = "20158820260"  && Huacho Eps Huacho
cRuc = "20115851919"  && ICA Eps Ilo

glIncluirTrabajadorEnCodBarras = IIF(cRuc = "20115851919",.T.,.F.)
USE
SELECT SYS002
USE

gcPathTmps = gcOldDir  && Sys(5)+CurDir()
SET DEFA TO &cRutaHome

*: Creando Objeto Aplicación
oAppMain = createobject("cstSysApp")

*: Estableciendo Posición del ToolBar
*: 0 = superior   1 = Izquierda   2 = Inferior   3 = Derecha
oAppMain.dock = 0

*: 1 = Propuesto por el sistema en función a Opciones    2 = Personalizado
oAppMain.TipoTool = 2

OPEN DATABASE sysdata

oAppMain.ViewLogoStart()
oAppMain.BuildDesktop()
oAppMain.GetUser()
IF oAppMain.Iniciado
   oAppMain.Loadparam

   cCadenaPath = " SET PATH TO .\CLASES, .\FORMULARIOS, .\GRAFICOS, .\OLES, .\OTROS, .\DATA, .\REPORTES, ..\iconos,"+;
      			 cRutaConta+", "+ cRutaCostos + ", "+ cRutaPpto + ", "+  cRutaRRHH
   &cCadenaPath  

   oAppMain.showMenu()
   = desMenu(cSucTip)
   oAppMain.ShowToolBar()
   _screen.oToolbar.lblbase1.caption = " Periodo: "+cmes+"-"+str(nAnio,4)
   cPerPro = str(nAnio,4)+PADL(nmes,2,"0")
   _screen.oToolbar.lblbase2.caption = "Localidad: "+alltrim(cSucursal) + "-" + cSucActiva
   _screen.caption ="GESTOR FINANCIERO - Subsistema de Activos Fijos - " + cEps
   OPEN DATABASE &cDbbase
   READ EVENTS
ELSE
   oAppMain.quit
ENDIF

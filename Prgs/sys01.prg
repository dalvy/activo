* Programa que Carga Variables Globales
PUBLIC ldir, cRutaConta, cRutaCostos, cRutaPpto, cRutaRRHH, cSucActiva, cSucursal, nMimsoMes,cCta_Terreno,cCtaREI,;
       cCtaObras, nDigConta, gndigitos, cFiltroFin, cSucNiv, cSucTip, gaSucAct, fFec_Proc, nAnio, cMes, nMes, cCostos,;
       cCta_TerrAcm
PUBLIC cfiltrocta, gnMetDep, gnMetDepDef
       
STORE "" TO cRutaConta, cRutaCostos, cRutaPpto, cRutaRRHH, cSucActiva, cSucursal, cCtaObras, ;
		    cFiltroFin, cSucNiv,cSucTip, cCostos,cCta_Terreno,cCtaREI,cfiltrocta,cCta_TerrAcm 
STORE 0 TO nMimsoMes, nDigConta
set date to british

nAnio = YEAR(DATE())
nMes  = MONTH(DATE())
cMes  = CAD_MES(nMes)
fFec_Proc = DATE()
Declare gaSucAct[1]
gaSucAct = ""
gDesde =""
gHasta =""
IF !USED("cpaf0001")
	USE bdActivos!cpaf0001 IN 0
ENDIF
SELECT cpaf0001
GO 1
  cRutaConta  = IIF(!glCrypto, ALLT(var_con), ChrTran(allt(var_con),gcCadChrTwoVF6,gcCadChrOneVF6) )
GO 2
  cRutaCostos = IIF(!glCrypto, ALLT(var_con), ChrTran(allt(var_con),gcCadChrTwoVF6,gcCadChrOneVF6) )
GO 3
  cRutaPpto   = IIF(!glCrypto, ALLT(var_con), ChrTran(allt(var_con),gcCadChrTwoVF6,gcCadChrOneVF6) ) 
GO 4
  cRutaRRHH   = IIF(!glCrypto, ALLT(var_con), ChrTran(allt(var_con),gcCadChrTwoVF6,gcCadChrOneVF6) ) 
USE

IF !USED("cpaf0002")
	USE bdActivos!cpaf0002 IN 0
ENDIF

SELECT cpaf0002
LOCATE FOR act_sts = 1
IF FOUND()
	cSucActiva = act_suc  &&Sucursal Activa
	cSucursal  = act_nom  &&Nombre Sucursal Activa
	cSucNiv    = act_niv  && Nivel Sucursal Activa E, Z, L
	cSucTip    = act_tip  && Tipo Sucursal Activa C, P
	= RetSucAct(cSucActiva,cSucNiv,cSucTip)
ELSE
	=MESSAGEBOX("No existe ninguna sucursal activa. Posteriormente debe activar alguna...",0,"Advertencia...")
ENDIF
USE

IF !USED("cpaf0000")
	USE bdActivos!cpaf0000 IN 0
ENDIF
SELECT cpaf0000
nMismoMes    = altames
cCtaObras    = ALLT(cta_obra)
cCta_Terreno = ALLT(cta_terreno)
cCta_TerrAcm = ALLT(cta_terrenoAcm)
nDigConta    = ndig_contable
gndigitos    = ndig_contable
cCostos      = IIF(costos_ins=1,"S","N")
cCtaREI      = cta_rei
cfiltrocta   = filtrocta
cMetDep = MetDep
cMetAut = MetAut
gnMetDepDef = Tipo_Met   && 1=Historico, 2=Tasacion
glClasRegul = ClasRegul
USE
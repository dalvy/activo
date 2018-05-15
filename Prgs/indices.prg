open data .\data\bdactivos
create cursor indices (tabla C(12), etiqueta C(30), clave C(50) , condicion C(30))

nel = adir(matfil,".\data\*.dbf")

for i=1 to nEl
    sele 0
    use &matfil[i,1] alias tabla
    for j=1 to tagcount()
        select tabla
        m.tabla = matfil[i,1]
        m.etiqueta = tag(j)
        m.clave    = key(j)
        m.condicion= for(j)
        select indices
        append blank
        gather memv
    endfor
    select tabla
    use
endfor


SELECT INDICES
INDEX ON TABLA TO A
copy to c:\ActivoCdx type xls
brow
*REPORT FORM INDICES  preview
USE
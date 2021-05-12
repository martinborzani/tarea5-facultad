{5.- Leer de un archivo de texto sobre tres arreglos los datos de un conjunto de autos, por cada uno:
- Patente
- Año
- Precio
Se pide mediante un menú que permita la repetición de las opciones con diferentes valores,
calcular:
a. Para un año dado, precio mínimo (puede no existir)
b. Para un precio dado cantidad de vehículos por debajo de dicho valor
c. Para un rango de años dado [Año1, Año2] precio promedio de los autos en dicho rango (puede
no existir)}

program tarea5;

const arraymax = 20;

type
  VecStr = array[1..arraymax] of string[6];
  VecWord = array [1..arraymax] of word;
  VecReal = array[1..arraymax] of real;

procedure lectura(var n:byte;var patentes:VecStr;var anios:VecWord;var precio:VecReal);
var
  arch:text;
begin

   assign(arch,'Autos.txt');
  reset(arch);
  n:= 0;

  while not eof (arch) do
  begin
    n:= n + 1;
    readln(arch,patentes[n],anios[n],precio[n]);
  end;


  close(arch);

end;

procedure menu(var opcion:char);
begin

  repeat

    writeln('ingrese la opcion deseada, ingrese F para finalizar');
    writeln('A = Para un ano dado, el precio minimo');
    writeln('B = Para un precio dado cantidad de vehiculos por debajo de dicho valor');
    writeln('C = Para un rango de años dado [Año1, Año2] precio promedio de los autos en dicho rango (puede no existir');
    readln(opcion);
    opcion:= upcase(opcion);

  until (opcion = 'F') or (opcion = 'A') or (opcion = 'B') or (opcion = 'C');

end;

function PrecioMinimo(anio:word ; anios:VecWord ; precio:VecReal ; n:byte):real;
var
  i: byte;
  precioMin:real;
begin

  precioMin:= 999999;

  for i:= 1 to n do
  begin
      if anios[i] = anio then
         begin
              if precioMin > precio[i] then
                 precioMin:= precio[i];
         end

  end;

  if precioMin <> 999999 then
     PrecioMinimo:= precioMin
  else
     precioMinimo:= -1;


end;

function contarAutos(precio_B:real ; Aprecios:VecReal ; n:byte ):byte;
var
  i,contT: byte;

begin

   contT:= 0;
   for i:= 1 to n do
     if Aprecios[i] < precio_B then
        contT:= contT + 1;

  contarAutos:= contT;
end;

function precioPromedio(anio_C1, anio_C2:word ; Aanios:VecWord ; Aprecios:VecReal ; n:byte):real;
var
  i,contT:byte;
  suma:real;
begin

  contT:= 0;
  suma:= 0;
  for i:= 1 to n do
      if (Aanios[i] >= anio_C1) and (Aanios[i] <= anio_C2) then
        begin
            contT:= contT + 1;
            suma:= suma + Aprecios[i];
        end;

  if contT > 0 then
    precioPromedio:= suma / contT
  else
     precioPromedio:= -1;



end;

var

  patentes: VecStr;
  anios: VecWord;
  precios: VecReal;
  opcion: char;
  n:byte;
  PrecioMin,precio_B,precioP:real;
  anio_ingreso,anio_C1,anio_C2:word;

begin

  lectura(n,patentes,anios,precios);
  repeat
        menu(opcion);
        case opcion of
             'A': begin
                    writeln('ingrese año');
                    readln(anio_ingreso);
                    PrecioMin:= PrecioMinimo(anio_ingreso,anios,precios,n);
                    if PrecioMin > 0 then
                       writeln('el precio minimo del año dado es: ', PrecioMin:8:2)
                    else
                       writeln('no existe un auto con el año ingresado');
                  end;
             'B': begin
                    writeln('ingrese el precio');
                    readln(precio_B);
                    writeln('la cantidad de autos con menor precio ', contarAutos(precio_B,precios,n));
                  end;
             'C':begin

                   writeln('ingrese el primer año');
                   readln(anio_C1);
                   repeat

                     writeln('ingrese el 2do año(tiene que ser el mayor)');
                     readln(anio_C2);

                   until (anio_C2 > anio_C1);

                   precioP:= precioPromedio(anio_C1,anio_C2,anios,precios,n);

                   if precioP > 0 then
                      writeln('el promedio de los precios es: ', precioP:8:2)
                   else
                      writeln('no existen autos en ese rango');



                 end;
        end;
  until opcion = 'F' ;
  readln;

end.


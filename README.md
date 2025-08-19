# Libro-de-alquimia-moderna
Esta es la bitácora de la clase del segundo semestre de Electrónica 2025

# 07/08, Primeros pasos
El profesor nos cuenta la situación referente a la dichosa marca de electrónicos conocida como Arduino, en particular que es de fantasía, el ATMEGA328P es la parte importante, luego haremos intercambio con algo que sí sirve para cosas más avanzadas

Historia de la tecnología, las máquinas, los computadores, programación, etc.

# Referentes textuales

# Referentes artísticos
Si bien no son parte de lo que podríamos considerar como la institución artírtica, me influencio mucho de bandas para intentar replicar el sonido que tienen (siendo ese mi interés principal, el sonido), ya sean guitarras o sontetizadores, véase: Brainiac, Roxy Music, Drive Like Jehu, etc.

Esos sonidos agresivos y estridentes luego trato de traducirlos a lo que estamos haciendo en la clase, al menos hasta el semestre pasado. Ahora hemos pasado más a terreno de programación con visuales, donde entra mi interés primario (que solo en esta clase queda de lado), la gráfica. Todo lo que es igual de agresivo, angular, y contrastado es lo que me gusta a nivel visual, por eso el semestre anterior usé ácido para un cirtuito, dejando mucho tiempo ahí una placa
# 14/08, Processing
Me quedé algo atrás cambiando mi código, pero luego en esta misma bitácora haré mi versión de lo que hicimos en clase
int cantidad = 0;


void setup(){
  size (700,600);
  background(50,120,70);
}

void draw(){
   background(50,120,70);
  line (10,200,250,100);
line (30,10,250,500);

textSize(50);
text("saludos terricola", 300,500);
cantidad = cantidad + 1;
println(cantidad);
text("tienes" + cantidad + "pesos", 300,550);

}

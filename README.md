# dg22203-C
Desarrollo de PORTAFOLIO para practica de C con ensamblador y ensamblador puro


## Indicicaciones
Los ejericicios numero 1 y numero 2 deben ejecutarse en 32 bits usando los siguientes comandos:

### Compilar con NASM (ensamblador):
nasm -f elf32 nombrearchivo.asm -o nombrearchivo.o

### Enlazar para crear el ejecutable:

ld -m elf_i386 nombrearchivo.o -o nombrearchivo

### Ejecutar:

./nombrearchivo

EL ejercicio 3 se trabajo coomo 64bits usando los siguientes comandos:

### Compilar con NASM (ensamblador):
nasm -f elf64 nombrearchivo.asm -o nombrearchivo.o

### Enlazar para crear el ejecutable:

ld nombrearchivo.o -o nombrearchivo

### Ejecutar:

./nombrearchivo
# Práctica-2-Lenguajes-de-Programación

Integrantes:

-Sofía Velez Ramirez

-David Alejandro Gutiérrez Leal

# Manual de Uso: Distribución de la Herencia en base al Nivel de Consanguinidad

Este programa en Prolog implementa un sistema para distribuir una herencia de acuerdo al nivel de consanguinidad de los herederos con el fallecido. El código evalúa las relaciones familiares y ajusta los porcentajes de la herencia asignada según sea necesario, asegurando que el total distribuido no supere el 100%.

# Requisitos

-Software necesario: SWI-Prolog.

-Instalación: Descarga SWI-Prolog desde swi-prolog.org.

Sigue las instrucciones de instalación para tu sistema operativo.

# Modo de uso

1.Descargar el arhivo con el codigo y guardarlo como (nombre).pl

2. Abrir prolog > archivo > consult. y selecciona el archivo del codigo.
   
3. Espera unos segundos y ya puedes aplicar los ejemplos de compilacion.

# Modificar el Archivo para Probar Diferentes Casos

Debes reescribir el archivo para probar diferentes escenarios, la modificacion se hace en los apartados de: % Definición de géneros, % Definición del difunto y % Family relations. cualquier modificacion a % Relationship definitions y mas abajo podria resultar en el codigo no funcionando. 

A continuación, tendrás unos ejemplos de relaciones familiares para probar la ejecución del código por tu cuenta:

# Ejemplo 1:
% Definición de géneros 

male(jesus).

male(juanito).

male(armando).

male(pedro).

female(ana).

% Definición del difunto

deceased(jesus).  % jesus es la persona difunta

% Family relations 

parent(jesus, ana). 

parent(jesus, juanito).

brother(jesus, armando).

cousin(jesus, pedro).

# Ejemplo 2:
% Definición de géneros 

male(juan).

male(pedro).

female(ana).

female(maria).

% Definición del difunto

deceased(juan).  % juan es la persona difunta

% Family relations 

parent(juan, ana).

nephew(juan, nacho).

nephew(juan, veronica).

nephew(juan, john).

grandchild(juan, pepo).

grandchild(juan, nestor).

# Ejemplo 3:
% Definición de géneros 

male(zack).

male(cloud).

male(mario).

male(gru).

female(aerith).

female(martha).

% Definición del difunto

deceased(aerith).  % aerith es la persona difunta

% Family relations 

parent(aerith, martha).

brother(zack, aerith).

brother(cloud, aerith).

cousin(aerith, mario).

cousin(aerith, gru).

# ¿Cómo ejecutar el código?

Para ejecutar el programa, utiliza el siguiente comando en el entorno de Prolog:

distributeInheritance(Total, Distribution).

Parámetros:

-Total: Este es el monto total de la herencia que se desea distribuir.

-Distribution: Esta variable devolverá una lista con los herederos, porcentajes y monto que les corresponden de la herencia.

# Ejemplos de ejecución:

distributeInheritance(100000, Distribution).

distributeInheritance(250000, Distribution).

distributeInheritance(150000, Distribution).

# Observacion importante: 

-Simetría en las Relaciones: Es importante tener en cuenta que, en las relaciones familiares definidas en el código, no siempre se respeta la simetría. Por ejemplo, cuando se define un primo, el difunto debe ser mencionado primero en la relación. Esto significa que la relación debe estar escrita como cousin(muerto, Y) en lugar de cousin(Y, muerto). El muerto tiene que ser el primero en aparecer en la relacion.


Ejemplo: En el caso de Zack, si él es el difunto y se quiere establecer que Pedro es su primo, la relación se debe escribir como: cousin(zack, pedro).


Esto asegura que el programa entienda que Zack es el individuo en cuestión que está distribuyendo la herencia.






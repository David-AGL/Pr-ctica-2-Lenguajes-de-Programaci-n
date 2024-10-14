# Práctica-2-Lenguajes-de-Programación

Integrantes: -David Alejandro Gutiérrez Leal
             -Sofía Velez Ramirez

# Manual de Uso: Distribución de la Herencia en base al Nivel de Consanguinidad

Este programa en Prolog implementa un sistema para distribuir una herencia de acuerdo al nivel de consanguinidad de los herederos con el fallecido. El código evalúa las relaciones familiares y ajusta los porcentajes de la herencia asignada según sea necesario, asegurando que el total distribuido no supere el 100%.

# Requisitos
-Software necesario: SWI-Prolog.
-Instalación:
Descarga SWI-Prolog desde swi-prolog.org.
Sigue las instrucciones de instalación para tu sistema operativo.

# Modificar el Archivo para Probar Diferentes Casos
Debes reescribir el archivo para probar diferentes escenarios. a continuación, tendrás unos ejemplos de relaciones familiares para probar la ejecución del código por tu cuenta:

# Escenario 1:
% Definición de géneros 
male(jesus).
male(juanito).
male(armando).
male(pedro).

female(ana).

% Definición del difunto
deceased(jesus).  % jessus es la persona difunta

% Family relations 
parent(jesus, ana). 
parent(jesus, juanito).
brother(jesus, armando).
cousin(jesus, pedro).

# Escenario 2:
% Definición de géneros 
male(zack).
male(cloud).
male(barret).
male(bartholomew).

female(cloe).
female(amanda).
female(megara).

% Definición del difunto
deceased(zack).  % zack es la persona difunta

% Family relations 
parent(zack, cloud). 
parent(barret, nulo).
parent(cloe, nulo).
parent(nulo, zack).
sister(megara, nulo).
brother(bartholomew, nulo).
sister(amanda, nulo).

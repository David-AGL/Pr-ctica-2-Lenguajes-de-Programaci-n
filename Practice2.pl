% Definición de géneros 
male(juan).
male(pedro).

female(ana).
female(maria).

% Definición del difunto
deceased(juan).  % Juan se sacrificó por el bien de la trama :(

% Family relations 
parent(juan, ana).
mother(juan, lola).
cousin(juan, nacho). 
sibling(juan, nestor).
grandchild(juan, pepo). 

% Relationship definitions
father(X, Y) :- parent(X, Y), male(X). 
mother(X, Y) :- parent(X, Y), female(X).
son(X, Y) :- parent(Y, X), male(X).
daughter(X, Y) :- parent(Y, X), female(X).
grandchild(X, Y) :- parent(Y, Z), parent(Z, X).

brother(X,Y) :- father(Z,X), father(Z,Y), male(X), X \= Y.
sister(X,Y) :- mother(Z,X), mother(Z,Y), female(X), X \= Y.   

% Relación de hermanos/hermanas (simétrica)
sibling(X, Y) :- brother(X, Y).
sibling(X, Y) :- brother(Y, X).
sibling(X, Y) :- sister(Y, X).
sibling(X, Y) :- sister(X, Y).

grandfather(X,Y) :- parent(X,Z), parent(Z,Y).
grandmother(X,Y) :- parent(X,Z), parent(Z,Y).

% Tío/a
uncle(X,Y) :- male(X), sibling(X,Z), parent(Z,Y).
aunt(X,Y) :- female(X), sibling(X,Z), parent(Z,Y).
nephew(X, Y) :- parent(Z, X), (brother(Y, Z); sister(Y, Z)). 

% Definición de primos usando sibling
cousin(X,Y) :- parent(P1, X), parent(P2, Y), sibling(P1, P2).


% Niveles de consaguinidad  
levelConsanguinity(X, Y, 1) :- father(X, Y).  
levelConsanguinity(X, Y, 1) :- mother(X, Y).  
levelConsanguinity(X, Y, 1) :- son(X, Y).  
levelConsanguinity(X, Y, 1) :- daughter(X, Y).  
levelConsanguinity(X, Y, 2) :- sibling(X, Y).  
levelConsanguinity(X, Y, 3) :- uncle(X, Y). 
levelConsanguinity(X, Y, 3) :- aunt(X, Y).
levelConsanguinity(X, Y, 3) :- nephew(X, Y). 
levelConsanguinity(X, Y, 3) :- grandfather(X, Y). 
levelConsanguinity(X, Y, 3) :- grandmother(X, Y).  
levelConsanguinity(X, Y, 3) :- cousin(X, Y). 
levelConsanguinity(X, Y, 3) :- grandchild(X, Y).   

% Distribución de la herencia
distributeInheritance(Total, Distribution) :-
    deceased(D),  % Considera al difunto
    findall(X, levelConsanguinity(D, X, 1), FirstLevelHeirs),
    findall(X, levelConsanguinity(D, X, 2), SecondLevelHeirs),
    findall(X, levelConsanguinity(D, X, 3), ThirdLevelHeirs),
    length(FirstLevelHeirs, NumFirstLevel),
    length(SecondLevelHeirs, NumSecondLevel),
    length(ThirdLevelHeirs, NumThirdLevel),

    % Distribuir la herencia de acuerdo al nivel
    distributeInheritanceByLevel(NumFirstLevel, 30, FirstLevelHeirs, FirstLevelDistribution),
    distributeInheritanceByLevel(NumSecondLevel, 20, SecondLevelHeirs, SecondLevelDistribution),
    distributeInheritanceByLevel(NumThirdLevel, 10, ThirdLevelHeirs, ThirdLevelDistribution),

    % Combina todas las distribuciones
    append(FirstLevelDistribution, SecondLevelDistribution, TempDistribution),
    append(TempDistribution, ThirdLevelDistribution, AllDistributions),

    % Calcular el porcentaje total distribuido
    findall(P, member(heir(_, P), AllDistributions), Percentages),
    sumlist(Percentages, TotalPercentageDistributed),

    % Calcular sobrante o exceso
    Remaining is 100 - TotalPercentageDistributed,  % Usar 100 como base

    % Si sobra o falta porcentaje, ajustar entre los herederos
    (Remaining > 0 ->
        length(AllDistributions, NumHeirs),
        ExtraPerHeir is Remaining / NumHeirs,
        addSobrante(AllDistributions, ExtraPerHeir, AdjustedDistribution);
    Remaining < 0 ->
        Percentage_minus is TotalPercentageDistributed - 100,
        length(AllDistributions, NumHeirs),
        MinusPerHeir is Percentage_minus / NumHeirs,
        removeExcess(AllDistributions, MinusPerHeir, AdjustedDistribution);
        AdjustedDistribution = AllDistributions),

    % Calcular los montos finales
    calculateFinalShares(Total, AdjustedDistribution, Distribution).

% Función para asignar los porcentajes a los herederos
distributeInheritanceByLevel(0, _, [], []).  % Caso base: no hay herederos
distributeInheritanceByLevel(_, _, [], []).  % Caso base: lista vacía de herederos
distributeInheritanceByLevel(NumHeirs, Percent, [Heir | Rest], [heir(Heir, Percent) | PercentRest]) :-
    distributeInheritanceByLevel(NumHeirs, Percent, Rest, PercentRest).

% Calcular el monto final de la herencia basado en los porcentajes
calculateFinalShares(_, [], []).  % Caso base: no hay herederos
calculateFinalShares(Total, [heir(Name, Percent) | Rest], [heir(Name, Percent, Share) | FinalRest]) :-
    Share is (Percent / 100) * Total,  % Calcular el monto final
    calculateFinalShares(Total, Rest, FinalRest).

% Función auxiliar para agregar el sobrante a cada heredero
addSobrante([], _, []).
addSobrante([heir(Name, Share) | Rest], Extra, [heir(Name, NewShare) | NewRest]) :-
    NewShare is Share + Extra,
    addSobrante(Rest, Extra, NewRest).

% Función auxiliar para remover el sobrante a cada heredero
removeExcess([], _, []).
removeExcess([heir(Name, Share) | Rest], Excess, [heir(Name, NewShare) | NewRest]) :-
    NewShare is Share - Excess,
    removeExcess(Rest, Excess, NewRest).























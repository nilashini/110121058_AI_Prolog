% Define male individuals.
male(john).
male(speaker).
male(david).

% Define parent relationships.
parent(john, speaker).   % John is the father of the speaker.
parent(speaker, david).  % Speaker is the father of David.

% Define father based on parent and male predicates.
father(X, Y) :- parent(X, Y), male(X).

% Define son based on parent and male predicates.
son(Y, X) :- parent(X, Y), male(Y).

% Define that the speaker has no siblings.
no_siblings(speaker) :-
    \+ (parent(john, Sibling), parent(john, speaker), Sibling \= speaker).

% Solve the riddle: Find who "that man" is.
solve_riddle(Man) :-
    no_siblings(speaker),      % Speaker has no siblings.
    father(speaker, Man).     % "That man" is the speaker's son.

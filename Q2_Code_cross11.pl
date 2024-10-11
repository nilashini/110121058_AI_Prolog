% Predicate to check if the combined weight of passengers on the boat does not exceed the boat's capacity (100 kg).
valid_weight([]).
valid_weight([man]):- 80 =< 100.
valid_weight([woman]):- 80 =< 100.
valid_weight([child1]):- 30 =< 100.
valid_weight([child2]):- 30 =< 100.
valid_weight([man, woman]):- 80 + 80 =< 100.
valid_weight([man, child1]):- 80 + 30 =< 100.
valid_weight([man, child2]):- 80 + 30 =< 100.
valid_weight([woman, child1]):- 80 + 30 =< 100.
valid_weight([woman, child2]):- 80 + 30 =< 100.
valid_weight([child1, child2]):- 30 + 30 =< 100.

% Predicate to move from east to west and vice versa.
opposite(e, w).
opposite(w, e).

% Predicate to define possible moves, where two people can cross the river or one person crosses alone.
move(state(BoatPos, BoatPos, WomanPos, Child1Pos, Child2Pos),
     state(NewBoatPos, NewBoatPos, WomanPos, Child1Pos, Child2Pos), [man]):-
    opposite(BoatPos, NewBoatPos),
    valid_weight([man]).

move(state(BoatPos, ManPos, BoatPos, Child1Pos, Child2Pos),
     state(NewBoatPos, ManPos, NewBoatPos, Child1Pos, Child2Pos), [woman]):-
    opposite(BoatPos, NewBoatPos),
    valid_weight([woman]).

move(state(BoatPos, ManPos, WomanPos, BoatPos, Child2Pos),
     state(NewBoatPos, ManPos, WomanPos, NewBoatPos, Child2Pos), [child1]):-
    opposite(BoatPos, NewBoatPos),
    valid_weight([child1]).

move(state(BoatPos, ManPos, WomanPos, Child1Pos, BoatPos),
     state(NewBoatPos, ManPos, WomanPos, Child1Pos, NewBoatPos), [child2]):-
    opposite(BoatPos, NewBoatPos),
    valid_weight([child2]).

move(state(BoatPos, BoatPos, BoatPos, Child1Pos, Child2Pos),
     state(NewBoatPos, NewBoatPos, NewBoatPos, Child1Pos, Child2Pos), [man, woman]):-
    opposite(BoatPos, NewBoatPos),
    valid_weight([man, woman]).

move(state(BoatPos, BoatPos, WomanPos, BoatPos, Child2Pos),
     state(NewBoatPos, NewBoatPos, WomanPos, NewBoatPos, Child2Pos), [man, child1]):-
    opposite(BoatPos, NewBoatPos),
    valid_weight([man, child1]).

move(state(BoatPos, BoatPos, WomanPos, Child1Pos, BoatPos),
     state(NewBoatPos, NewBoatPos, WomanPos, Child1Pos, NewBoatPos), [man, child2]):-
    opposite(BoatPos, NewBoatPos),
    valid_weight([man, child2]).

move(state(BoatPos, ManPos, BoatPos, BoatPos, Child2Pos),
     state(NewBoatPos, ManPos, NewBoatPos, NewBoatPos, Child2Pos), [woman, child1]):-
    opposite(BoatPos, NewBoatPos),
    valid_weight([woman, child1]).

move(state(BoatPos, ManPos, BoatPos, Child1Pos, BoatPos),
     state(NewBoatPos, ManPos, NewBoatPos, Child1Pos, NewBoatPos), [woman, child2]):-
    opposite(BoatPos, NewBoatPos),
    valid_weight([woman, child2]).

move(state(BoatPos, ManPos, WomanPos, BoatPos, BoatPos),
     state(NewBoatPos, ManPos, WomanPos, NewBoatPos, NewBoatPos), [child1, child2]):-
    opposite(BoatPos, NewBoatPos),
    valid_weight([child1, child2]).

% Predicate to find a solution, where the start state is everyone on the east side and the goal is everyone on the west side.
path(Goal, Goal, Path):- 
    writeln('Solution:'),
    reverse(Path, ReversedPath),
    print_path(ReversedPath).

path(State, Goal, Path):-
    move(State, NextState, Passengers),
    \+ member(NextState, Path),
    path(NextState, Goal, [NextState|Path]).

% Helper predicate to print the solution path.
print_path([]).
print_path([State|Tail]):-
    writeln(State),
    print_path(Tail).

% Start the solution without halt to keep the SWI-Prolog session open.
solve :-
    path(state(e, e, e, e, e), state(w, w, w, w, w), [state(e, e, e, e, e)]).

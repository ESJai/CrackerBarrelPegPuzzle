%KwanHo Yu
%ky0116

%Requires Lambda module
%If not installed, run the following in the compilter (e.g. swi-pl)
%pack_install('http://www.swi-prolog.org/download/pack/lambda-1.0.0.tgz')

:- use_module(library(lambda)).

%Define all possible moves
moves(F,1,T):-
   member([F,T],[[0,3],[3,0]]).
moves(F,2,T):-
   member([F,T],[[0,5],[5,0]]).
moves(F,3,T):-
   member([F,T],[[1,6],[6,1]]).
moves(F,4,T):-
   member([F,T],[[2,7],[7,2], [3,5], [5,3]]).
moves(F,5,T):-
   member([F,T],[[2,9],[9,2]]).
moves(F,6,T):-
   member([F,T],[[3,10],[10,3]]).
moves(F,7,T):-
   member([F,T],[[3,12],[12,3],[4,11],[11,4],[6,8],[8,6]]).
moves(F,8,T):-
   member([F,T],[[4,13],[13,4],[5,12],[12,5],[7,9],[9,7]]).
moves(F,9,T):-
   member([F,T],[[5,14],[14,5]]).
moves(F,11,T):-
   member([F,T],[[10,12],[12,10]]).
moves(F,12,T):-
   member([F,T],[[11,13],[13,11]]).
moves(F,13,T):-
   member([F,T],[[12,14],[14,12]]).
 
 
%visualizes a solution for each first 5 positions
go :- 
	move([0], [1,2,3,4,5,6,7,8,9,10,11,12,13,14], [], Moves0),
	format('=== 0 ===~n'),
	show(Moves0, [0]),
	format('=== 0 ===~n'),nl,
	move([1], [0,2,3,4,5,6,7,8,9,10,11,12,13,14], [], Moves1),
	format('=== 1 ===~n'),
	show(Moves1, [1]),
	format('=== 1 ===~n'),nl,
	move([2], [0,1,3,4,5,6,7,8,9,10,11,12,13,14], [], Moves2),
	format('=== 2 ===~n'),
	show(Moves2, [2]),
	format('=== 2 ===~n'),nl,
	move([3], [0,1,2,4,5,6,7,8,9,10,11,12,13,14], [], Moves3),
	format('=== 3 ===~n'),
	show(Moves3, [3]),
	format('=== 3 ===~n'),nl,
	move([4], [0,1,2,3,5,6,7,8,9,10,11,12,13,14], [], Moves4),
	format('=== 4 ===~n'),
	show(Moves4, [4]),
	format('=== 4 ===~n').

	
%perform a move, if possible
move(_, [_], List, Moves) :-
	reverse(List, Moves).
 
move(Free, Occupied, List, Moves) :-
	select(From, Occupied, TempOccupied1),
	select(Over, TempOccupied1, TempOccupied2),
	select(To, Free, TempFree),
	moves(From,Over,To),
	move([From, Over | TempFree], [To | TempOccupied2], [moves(From,Over,To) | List], Moves).
 
 
%print after each move
%when there is not move left
show([], Free) :-
	numlist(0,14, List),
	maplist(\X^P^(member(X, Free) -> P = '.'; P = 'x'),List,[P0,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14]),
	format('    ~w        ~n', [P0]),
	format('   ~w ~w      ~n', [P1,P2]),
	format('  ~w ~w ~w    ~n', [P3,P4,P5]),
	format(' ~w ~w ~w ~w  ~n', [P6,P7,P8,P9]),
	format('~w ~w ~w ~w ~w~n', [P10,P11,P12,P13,P14]), nl.
 
 
show([moves(From, Over, To) | Tail], Free) :-
	numlist(0,14, List),
	maplist(\X^P^(member(X, Free) -> P = '.'; P = 'x'),List,[P0,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14]),
	format('    ~w        ~n', [P0]),
	format('   ~w ~w      ~n', [P1,P2]),
	format('  ~w ~w ~w    ~n', [P3,P4,P5]),
	format(' ~w ~w ~w ~w  ~n', [P6,P7,P8,P9]),
	format('~w ~w ~w ~w ~w~n', [P10,P11,P12,P13,P14]), nl,
	
	select(To, Free, TempFree),
	show(Tail,  [From, Over | TempFree]).
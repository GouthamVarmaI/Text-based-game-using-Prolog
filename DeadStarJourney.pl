/* The Journey of A Dead Star, by goutham. */

:- dynamic chosen_character/1, character/1, step/1.

% Facts describing scientists and their unique abilities

%Einstein
scientist_ability(einstein, time_dilation, 'Manipulate time, slowing it down or speeding it up.').
scientist_ability(einstein, space_distortion, 'Create distortions in the fabric of space, altering the environment.').

%Hawking
scientist_ability(hawking, quantum_insights, 'Perceive hidden clues or bypass quantum-based challenges.').
scientist_ability(hawking, black_hole_manipulation, 'Manipulate gravitational fields or harness Hawking radiation.').

%Curie
scientist_ability(curie, radiation_detection, 'Detect and analyze radiation sources, uncovering hidden secrets.').
scientist_ability(curie, chemical_expertise, 'Synthesize compounds or concoct solutions to chemical puzzles.').

%Newton
scientist_ability(newton, newtonian_mechanics, 'Grant enhanced physical abilities, such as increased strength or agility.').
scientist_ability(newton, gravity_manipulation, 'Manipulate gravitational forces, creating gravitational wells.').

%Galileo
scientist_ability(galileo, telescopic_vision, 'Grant enhanced vision, allowing to see distant objects or uncover hidden details.').
scientist_ability(galileo, planetary_insights, 'Provide insights into celestial mechanics, guiding in navigating space.').

%Darwin
scientist_ability(darwin, adaptation, 'Grant the ability to adapt to different environments or situations.').
scientist_ability(darwin, ecological_understanding, 'Provide insights into ecological relationships, helping to understand flora and fauna.').


% Predicate to print Character's abilities
skills(Scientist) :-
    write('Abilities for '), write(Scientist), write(':'), nl,
    (   scientist_ability(Scientist, Ability, Description),
        format('~w - ~w~n', [Ability, Description]),
        fail
    ;   true % To succeed after printing all abilities
    ).


% Introduction to the game
intro:-
    nl,
    write('Characters: einstein, hawking, curie, newton, galileo, or darwin.'), nl,
    write('You can switch between characters at any point, but each character can only be used once, so "chose wisely".'), nl,
    write('You only have SEVEN STEPS to save your plant'), nl,
    write('Each character possesses unique abilities that you can use to overcome challenges and save the planet.'), nl,
    nl, nl.

% Welcome message
welcome :-
    nl,
    write('Welcome to the Journey of a Dead Star!'), nl, nl,
    write('In this game, you will embark on an adventure to save your home planet using the unique abilities of characters.'), nl,
    write('Choose your character and start your journey.'), nl,
    nl, nl.


% Instructions
instructions :-
    nl,
    write('Instructions:'), nl,
    write('End every command with a dot {.}'), nl,
    write('To chose a character, type character_name. e.g., {einstein.}'), nl, nl.


% Start
start :-
    welcome,
    intro,
    instructions,
    assert(step(0)), % Initialize the step counter
    challengeoneinstructions.

% Choosing the character
choose(Char) :-
    (   chosen_character(Char) ->
        choose_again(Char)
    ;   assert(chosen_character(Char)),
        assert(character(Char)),
        write('You have chosen '), write(Char), nl,
        skills(Char),
        retractall(character(Char)),
        nl
    ).


% Predicate to handle choosing the character again
choose_again(Scientist) :-
    format('You have already chosen ~w character. Please choose a different one.', [Scientist]), nl,
    write('Which scientist would you like to choose?'), nl,
    read(Char), % Prompt the user to choose a scientist
    choose(Char). % Retry the choose predicate

% Increment the step counter
increment_step :-
    retract(step(Step)),
    NewStep is Step + 1,
    (NewStep > 7 ->
      write('You have reached the maximum number of steps. Game Over.'), nl,
      retract(step(_)),
      fail
    ; assert(step(NewStep))
    ).

%Instructions for the first challenge
challengeoneinstructions :-
    nl,
    write('Watch out Captain!!  You have received a message from your alien buddies about an asteroid marching your way, threatening to disrupt your planet. What do you wanna do? '), nl,
    write('Hint: You may need to explore farther than usual to give you a head start!!!'), nl,
    nl,
    challengeone.


% Challenge predicate that can only be solved when a specific scientist is chosen
challengeone :-
    nl,
    write('Which character would you like to choose?'), nl,
    read(Scientist), % Prompt the user to choose a scientist
    choose(Scientist), % Call the choose predicate to select the scientist
    nl,

    % Check if the chosen scientist is able to solve the challenge
    (   Scientist == galileo ->
        % Prompt the user to select one of Galileo's skills
        write('Which skill of Galileo would you like to use?'), nl,
        write('1. Telescopic Vision'), nl,
        write('2. Planetary Insights'), nl,
        read(Skill), nl,

        % Validate the selected skill
        (   Skill == 1 ->
            % Print the challenge description
            write('Solved!! You found out the coordinates of the asteroid! Galileo\'s Telescopic Vision saved the day!'), nl, nl, nl,
            challengetwoinstructions % Proceed to the next challenge

        ;   Skill == 2 ->
            % If the user selects Planetary insights, inform them that it didn't work
            write('Nope!! Galileo\'s planetary insights did not help! Try again, still got time (hopefully!)...'), nl,
            retractall(chosen_character(Scientist)),
            challengeone % Retry the challenge

        ;   % Handle invalid skill selection
            write('Invalid skill selection!'), nl,
            retractall(chosen_character(Scientist)),
            challengeone
        )
    ;
        % If the chosen scientist is not suitable, inform the player to choose wisely
        write('You need more expertise to solve this puzzle! Choose your scientist wisely.'), nl,
        challengeone % Retry the challenge
    ).



%Instructions for the second challenge
challengetwoinstructions :-
    nl,
    write('Welcome to the second challenge!'), nl,
    write('Good start!  You have encountered an asteroid but it is pacing up!!! Hurry!!!'), nl,
    write('Hint: You may need to slow down the time to give you a head start!!!'), nl,
    nl,
    increment_step,
    challengetwo.


challengetwo :-
    nl,
    write('Which scientist would you like to choose?'), nl,
    read(Scientisttwo), % Prompt the user to choose a scientist
    choose(Scientisttwo), % Call the choose predicate to select the scientist
    nl,

    % Check if the chosen scientist is able to solve the challenge
    (   Scientisttwo == einstein ->
        % Prompt the user to select one of Einstein's skills
        write('Which skill of Einstein would you like to use?'), nl,
        write('1. Time dilation'), nl,
        write('2. Space distortion'), nl,
        read(Skill), nl,

        % Validate the selected skill
        (   Skill == 1 ->
            % Print the challenge description
            write('Solved! Challenge two completed! Einstein\'s skill to time dilation saved the day!!'), nl, nl,
            challengethreeinstructions

        ;   Skill == 2 ->
            % If the user selects space_distortion, inform them that it didn't work
            write('Nope!! Einstein\'s skill to space distortion did not work out!!!'), nl,
            retractall(chosen_character(Scientisttwo)),
            challengetwo % Retry the challenge
        ;
            % Handle invalid skill selection
            write('Invalid skill selection!'), nl,
            retractall(chosen_character(Scientisttwo)),
            challengetwo
        )
    ;
        % If the chosen scientist is not suitable, inform the player to choose wisely
        write('You need more expertise to solve this puzzle! Choose your scientist wisely.'), nl,
        challengetwo % Retry the challenge
    ).


%Instructions for the third challenge
challengethreeinstructions :-
    nl,
    write('Welcome to the third challenge!'), nl,
    write('The asteroid was slowed down! But it is majestic!!'), nl,
    write('Hint: See if someone can help you out to gain strength!!!'), nl,
    nl,
    increment_step,
    challengethree.


challengethree :-

    nl,
    write('Which scientist would you like to choose?'), nl,
    read(Scientistthree), % Prompt the user to choose a scientist
    choose(Scientistthree), % Call the choose predicate to select the scientist
    nl,
    % Check if the chosen scientist is able to solve the challenge
    (   Scientistthree == newton ->
        % Prompt the user to select one of Newton's skills
        write('Which skill of Newton would you like to use?'), nl,
        write('1. Newtonian Mechanics'), nl,
        write('2. Gravity Manipulation'), nl,
        read(Skill), nl,

        % Validate the selected skill
        (   Skill == 1 ->
            % Print the challenge description
            write('Challenge three completed!!! Newton\'s skill to Newtonian Mechanics made you stronger enough!!!'), nl, nl,
            challengefourinstructions

        ;   Skill == 2 ->
            % If the user selects Gravity, inform them that it didn't work
            write('Nope!! Newton\'s skill to Gravity Manipulation did not work!!'), nl,
            retractall(chosen_character(Scientistthree)),
            challengethree % Retry the challenge

        ;   % Handle invalid skill selection
            write('Invalid skill selection!'), nl,
            retractall(chosen_character(Scientistthree)),
            fail
        )
    ;   % If the chosen scientist is not suitable, inform the player to choose wisely

    write('You need more expertise to solve this puzzle! Choose your scientist wisely.'), nl,
        challengethree % Retry the challenge
    ).


%Instructions for the fourth challenge
challengefourinstructions :-
    nl,
    write('Welcome to the fourth challenge!'), nl,
    write('The asteroid was slowed down and you are stronger than ever but you may need more clues!!'), nl,
    write('Hint: See if someone can help you out with solving quantum challenges!!'), nl,
    nl,
    increment_step,
    challengefour.


challengefour :-
    nl,
    write('Which scientist would you like to choose?'), nl,
    read(Scientistfour), % Prompt the user to choose a scientist
    choose(Scientistfour), % Call the choose predicate to select the scientist
    nl,

    % Check if the chosen scientist is able to solve the challenge
    (   Scientistfour == hawking ->
        % Prompt the user to select one of Newton's skills
        write('Which skill of Hawking would you like to use?'), nl,
        write('1. Black Hole Manippulation'), nl,
        write('2. Quantum Insights'), nl,
        read(Skill), nl,

        % Validate the selected skill
        (   Skill == 1 ->
            % If the user selects Black Holes, inform them that it didn't work
            write('Nope!! Hawking\'s wisdom on Black Holes did not work out! What a bummer!!'), nl,
            retractall(chosen_character(Scientistfour)),
            challengefour % Retry the challenge

        ;   Skill == 2 ->
            write('Solved!! Hawking\'s skill on Quantum Insights saved the day!'), nl,
            challengefiveinstructions

        ;   % Handle invalid skill selection
            write('Invalid skill selection!'), nl,
            retractall(chosen_character(Scientistfour)),
            fail
        )
    ;   % If the chosen scientist is not suitable, inform the player to choose wisely
        write('You need more expertise to solve this puzzle! Choose your scientist wisely.'), nl,
        challengefour % Retry the challenge
    ).


%Instructions for the fifth challenge
challengefiveinstructions :-
    nl,
    write('Now you know everything about the asteroid thanks to Hawking!'), nl,
    write('Hint: You should know what to do!! Become the destroyer!!'), nl,
    nl,
    challengefive.


challengefive :-
    nl,
    write('Which scientist would you like to choose?'), nl,
    read(Scientistfive), % Prompt the user to choose a scientist
    choose(Scientistfive), % Call the choose predicate to select the scientist
    nl,

    % Check if the chosen scientist is able to solve the challenge
    (   Scientistfive == curie ->
        % Prompt the user to select one of Curie's skills
        write('Which skill of Curie would you like to use?'), nl,
        write('1. Radiation Detection'), nl,
        write('2. Chemical Expertise'), nl,
        read(Skill), nl,

        % Validate the selected skill
        (   Skill == 1 ->
            write('Nope!! Curie\'s skill to deteciing radiation did not work out!'), nl,
            retractall(chosen_character(Scientistfive)),
            challengefive % Retry the challenge

        ;   Skill == 2 ->
            write('Hurray! Game over!! You saved your planet! Congratulations!!!'), nl

        ;   % Handle invalid skill selection
            write('Invalid skill selection!'), nl,
            retractall(chosen_character(Scientistfive)),
            fail
        )
    ;   % If the chosen scientist is not suitable, inform the player to choose wisely
        write('You need more expertise to solve this puzzle! Choose your scientist wisely.'), nl,
        challengefive % Retry the challenge
    ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Scripted text and phrases for ** GENERIC ** intents (sorted on intent name)		%%%
%%% Text is only provided for those intents that the agent will generate (use). 	%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Intent: appreciation receipt
text(appreciationReceipt, "You're welcome.").

% Intent: context mismatch
text(contextMismatch, "Not sure what that means in this context.").

% Intent: negative welfare receipt
text(negativeWelfareReceipt, "I'm sorry to hear that.").

% Intent: sequence closer
text(sequenceCloser, "Thank you.").

text(greeting, Text) :-
	agentName(Name),
	format(string(Text), "Yo I'm ~w", [Name]).

text(greeting, "What's up Chat?!").

text(recipeInquiry, "What would you like to cook?").

text(recipeChoiceReceipt, Text) :-
	currentRecipe(Recipe),
	recipeName(Recipe, Name),
	format(string(Text), "~w is an amazing choice!", [Name]).
	
text(recipeChoiceReceipt, Text) :-
	currentRecipe(Recipe),
	format(string(Text), "~w is an amazing choice!", [Recipe]).
	
text(lastTopicCheck, "Can I do anything else?").

text(farewell, "Cya later alligator").

text(wellWish, "I hope you have an absolutely amazing day you wonderful human being").

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Scripted text and phrases for ** DOMAIN SPECIFIC ** intents (sorted on intent name)	%%%
%%% Text is only provided for those intents that the agent will generate (use). 	%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Intent: grant recipe quantity
% This intent is used for answering the user intent: requestRecipeQuantity.
% Instruction:
%	Use the predicates currentRecipe/1, mostRecentIngredient/1, and ingredient/3 to construct a
%	string that provides the answer.

% Intent: ingredients check
% Instruction
%	For the current recipe, combine an ingredients check question with a (nicely formatted) list 
%	of all ingredients with the amount needed for that recipe. Add useful helper predicate
%	definitions to the cooking.pl file. Hint 1: You can add "<br />" for adding new lines (on 
%	the chat webpage). Hint 2: Use the atomics_to_string/3 built-in predicate for combining the 
%	ingredients.

% Intent: recipe choice receipt
% Instruction:
% 	Collects recipe name provided by user from session history using the given currentRecipe/1 
% 	predicate and checks that the recipe is available in the agent's recipe database using the
% 	given recipes/1 predicate.
	
% Intent: recipe confirm
text(recipeConfirm, Text) :-
	currentRecipe(Recipe), recipeName(Recipe, Name), 
	string_concat("I will now guide you through the process of making ", Name, Text).
		
% Intent: recipe step
% This intent is used as part of a repeated subpattern and therefore uses the stepCounter/1
% predicate to fetch the right step.
text(recipeStep, Txt) :- currentRecipe(Recipe), stepCounter(Cnt), step(Recipe, Cnt, Txt).
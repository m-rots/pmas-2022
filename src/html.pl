/*
The html/2 predicate shows different HTML elements
based on the current Intent and available beliefs.
*/

% When the greeting intent is received, we don't want to just show text.
% No no no, Handsome Squidward wants you to see his handsomeness through a gif instead.
html(greeting, Html) :-
	agentName(AgentName),
	format(string(Greeting), "Sup, I'm ~w, your handsome chef", [AgentName]),
	image("/images/squidward.gif", 500, 500, Image),
	textWithGif(Greeting, Image, Html).
	
html(recipeStep, Html) :-
	currentRecipe(Recipe), stepCounter(Step), totalSteps(Total), step(Recipe, Step, Instruction),
	format(string(Html), '<div class="recipe-step"><h3>Step ~w/~w</h3><p>~w</p></div>', [Step, Total, Instruction]).

% When there is no specific page for this Intent,
% then we simply show a page containing the TTS content.
html(Intent, Html) :-
	text(Intent, Text),
	textOnly(Text, Html).

/*
HTML Elements and such
*/
textOnly(Text, Html) :- format(string(Html), '<div class="text-only">~w</div>', [Text]).

textWithGif(Text, ImageHtml, Html) :-
	format(string(Html), '<div class="text-gif">~w<p>~w</p></div>', [ImageHtml, Text]).

image(Src, Html) :- format(string(Html), '<img src="~w" />', [Src]).

image(Src, Width, Height, Html) :- format(string(Html), '<img src="~w" width=~w height=~w />', [Src, Width, Height]).
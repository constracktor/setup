# Vim Cheatsheet

Cheatsheet containing the most important vim commands

u			undo
U			undo Line
ctrl r			redo


## Movement
    k
<-h   l->  		cursor
    j
0			move to START of line
$			move to END of line
e			move to END of word

ctrl + g		get position
gg			move to START of file
G			move to END of file
$LINE + G		move to $LINE

ctrl + i		move forward
ctrl + o		move backward

cursor on bracket + %	move to matching bracket


## Visual mode
v 			enter visual mode
d			delete selected text
y			copy selected text


## Delete
x			delete AT cursor
dw			delete word
d$			delete to END of line
dd			delete ENTIRE line


## Insert
i			insert BEFORE cursor
a			insert AFTER cursor
A			insert AT end of line
o 			insert BELOW line
O			insert ABOVE line

ce			deletes word + insert mode
c$			deletes line + insert mode


## Copy/Paste
yw			copy word
y$			copy line
p			paste AFTER cursor
P			paste BEFORE cursor


## Search/replace
/$NAME			forward search file
?$NAME			backward search file
n			move to next found
N			move to previous found
\c			ignore case of letters

r 			replace AT cursor
R			replace starting FROM cursor
:%s/$OLD/$NEW/g		replace all
/gc 			ask for replace


## File Commands
:q!			trash changes quit
:wq			write changes quit
:w $FILE 		save changes in $FILE
:r $FILE or $COMMAND	read into current file
:!$COMMAND		execute external command
:$COMMAND tab		command completion


## Setting options
:set $OPTION		turn ON option
:set no$OPTION		turn OFF option
ic 	'ignorecase'	ignore upper/lower case when searching
is 	'incsearch'	show partial matches for a search phrase
hls 	'hlsearch'	highlight all matching phrases


## tbd.
enter			open link
K			documentation
:Lazy			Package manager

---
author: Marc Chantreux
header-includes: \input{prelude.latex}
---
# disclaimer

* je débute, je n'ai pas lu le manuel, j'ai
    * lu des articles
    * lu des makefiles
* je suis déjà très content (20h effect?)

# Exemple: construire son site web avec pandoc et zsh

~~~{.zsh}
jade.js  template.jade  # gives template.html
lsc      behave.ls      # gives behave.js
stylus   look.us        # gives look.css
dot -Tsvg -o deps.svg deps.dot

chapters=( chap{01..04}.md )

pandoc=(
    pandoc --template template.html
    -t markdown -f beamer )

for c ($chapters)
    $pandoc -o $c:r.html $c

cat intro.md $chapters |
    $pandoc > $all.html
~~~

# problème

le site est reconstruit intégralement à chaque execution.
quelles sont les commandes à lancer pour reconstruire tout ou partie des
fichiers. $\implies$ graph de dépendances.

\begin{flushleft}
\only<2>{\includegraphics[width=1\textwidth]{deps.pdf}}
\end{flushleft}

# phony rules

\begin{flushleft}
\includegraphics[width=1\textwidth]{deps_with_phony.pdf}
\end{flushleft}

# Build automation tools

`man mk`

> maintain (make) related files

* make (mk, pmake, ...)
* ses "successeurs" (cmake, scons, rake, daiku, grunt, ant, gradle, ...)
* [liste sur wikipedia](https://en.wikipedia.org/wiki/List_of_build_automation_software)
* sous linux: [GNU make](https://www.gnu.org/software/make/manual/)

# pourquoi GNU make?

* à mon avis encore très utilisé
    * `autotools`
        * `m4`, `m4sh`, `make`
        * utilisé par de nombreux projets OSS
    * paquets debian:
        * archives `ar`
        * `control` est un `Makefile`
* résoud la majorité des problèmes simplement


# makefile

décrire le graph de dépendances sous la forme de règles

## Cible (target)
état à atteindre

* fichier à construire
* phony: "fichier virtuel"

## Dépendance (dependency)
fichier nécessaire à la construction ou l'utilisation de la cible

## Commandes (command)
commandes externes (`/bin/sh` par defaut) à executer pour construire la cible

# la commande make

* s'assure que les cibles passées en argument (la première du makefile par défaut)
  sont *à jour*.
* *être à jour* c'est être plus récent que toutes ses dépendances
* *contruire* une cible, c'est executer les commandes qui permettent de la mettre à jour
* la construction s'arrête si
      * une dépendance ne peut être construite
      * une commande ne s'est pas executée correctement (`$?`)

# syntaxe

~~~{.make}
# comments

targets: dependencies; modifiers commands

targets: dependencies
    modifiers commands

targets: dependencies \
other-dependencies
    a-very-long command with \
    a lot of arguments
~~~

# remarques sur la syntaxe

* Attention: les commandes sont indentées avec une tabulation
* Tip: utilisez la coloration syntaxique de vim
* les `\` protègent tous les caractères, fin de ligne y compris
* les `$` du shell doivent être doublées dans les commandes

# hello world, makefile

~~~{.make}
# $$USER instead of $USER
# $$HOME instead of $HOME
# shell command variables needs two
# ...

hello.txt:
        false
        echo greetings, $$USER
        touch hello.txt
~~~

# hello world, make produit

~~~{.txt}
false
makefile:2: recipe for target 'hello.txt' failed
make: *** [all] Error 1
~~~

# modifiers de commande

* `@` annule l'echo
* `-` la commande est validée même en cas d'échec

~~~{.make}
hello.txt:
        @- false
        @ echo greetings, $$USER
        touch hello.txt
~~~

# Exercice

* retranscrire la règle suivante ou une règle analogue
* ajoutez et supprimez des modifiers et assurez-vous d'en avoir compris le
  fonctionnement
* lancez make jusqu'à ce qu'il vous indique que tout est à jour.

# plusieur règles

~~~{.make}
hello.txt:
        @- false
        @ echo greetings, $$USER
        touch hello.txt

hello2.txt:
        @- false
        @ echo greetings, $$USER
        touch hello.txt
~~~

QUESTION: que fait la commande `make` ?

# réponse ...

~~~{.zsh}
make            # construit hello.txt
make hello.txt  # construit hello.txt
make hello2.txt # construit hello2.txt
~~~

# factoriser

~~~{.make}
hello.txt hello2.txt:
	@- false
	@ echo greetings, $$USER
	touch $@
~~~

* target par default: hello.txt
* `$@` est une [variable automatique](https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html)

# variables automatiques

* y'en a plein!
* celles à connaitre sont
    * `$@` (la cible)
    * `$<` (la première dépendance). facile à retenir: pensez au redirecteur d'entrée (`<`)

# usage des variables automatiques

~~~{.make}

behave.js:      behave.ls       ; lsc $<
components.js:  components.ls   ; lsc $<
bus.js:         bus.ls          ; lsc $<

index.html: index.md template.html
    pandoc \
    -t html+pipe_tables+grid_tables+multiline_tables+escaped_line_breaks \
    --toc -B menu --template -o $@ $<
~~~

# pattern matching

~~~{.make}
behave.js:      behave.ls       ; lsc $<
components.js:  components.ls   ; lsc $<
bus.js:         bus.ls          ; lsc $<
~~~

peut s'écrire

~~~{.make}
%.js: %.ls ; lsc $<
~~~

# stem

[pattern match](https://www.gnu.org/software/make/manual/html_node/Pattern-Match.html#Pattern-Match)

* une règle peut trouver une cible avec
  * un prefixe (fixe et optionnel)
  * un "stem" (`%`)
  * un suffixe (fixe et optionnel)
* le stem trouvé est disponible
  * par `%` dans les dépendances
  * par la variable `$*` dans la construction

# Exercice

soit cible `funk-%-funky` dans votre `makefile`. vous écrirez le reste de la
règle telle que

    make funk-to-funky

soit une copie de `ashes-to-ashes` que vous aurez préalablement créé. au
passage, vous affichez le stem sur sur la stdout.

# variables

## affectation

depuis le makefile ou en paramètre de `make`

|||
|-:|:-|
| affectation        | `=`  |
| bind               | `:=` |
| valeur par defaut  | `?=` |

## interpolation

~~~{.make}
$(nom-de-variable)
~~~

# variables (exemple)

~~~{.make}
template= template.beamer.latex
chapters = \
    index.md \
    touch.md
components= $(chapters) $(template) prelude.latex \
    deps.pdf deps_with_phony.pdf

mk-slides = pandoc \
    -f markdown -t beamer+escaped_line_breaks \
    --template $(template)

slides.pdf slides.latex: $(components)
	cat $(chapters) | $(mk-slides) -o $@
	@echo DONE
~~~

# affectation de variables

depuis la ligne de commandes


# conditions

# make dans vim

~~~{.viml}
set make
set makeprg=make %:r.html
make
~~~

# make dans vim + tmux

## vim `~/.zshenv`

~~~{.zsh}
promise/tmux/tailf/open () {
    tmux split-window -d  -p 20 \
        'tail -f ${PROMOUT:=/tmp/promise.mix}' }
promise/new () {
    : ${1:=zsh}
    "$@" &>> ${PROMOUT:=/tmp/promise.mix} & }
~~~

## vim `~/.tmux.conf`

~~~
bind-key P run-shell "zsh -c promise/tmux/tailf/open"
~~~

## dans vim

~~~
:set makeprg=promise/new\ make
~~~

# Questions? 

merci ...


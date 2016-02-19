---
author: Marc Chantreux
urls:
    - http://unistra.github.io/workshop/livescript/slides.pdf
title: livescript
header-includes: \input{prelude.latex}
---

# Faster

* markdown
* stylus
* jade
* livescript

# Future?

* elm, clojurescript?
* sxml, scss?
* d3
* tentative de Meta-Templating (rototo)

# Livescript ?

* ne corrige pas tous les problèmes de javascript
* propose une meilleure syntaxe pour l'état de l'art

# readable numbers

* `_` comme séparateur
* lettres finales comme indice

# alors ?

    100000000     + 2    =
    100_000_000   + 2    =
    100_000_000km + 2km  =
    100_000_000km + 2ft  =

# voilà

    100000000     + 2    = [throw Krasucki Exception]
    100_000_000   + 2    = 100_000_002
    100_000_000km + 2km  = 100_000_002
    100_000_000km + 2ft  = 100_000_002 [NASA clue]

# NASA Fix

    JS: 100_000_000km + kmFromFt(2)
    LS: 100_000_000km + (km-from-ft 2) =  ...

    JS     : rectArea(2, 4) + rectArea(5, 8)
    LS     : (rect-area 2, 4) + (rect-area 5, 8)
    Haskell: (rect-area 2 4) + (rect-area 5 8)
    Haskell: (+) (rect-area 2 4) (rect-area 5 8)

# définition de fonctions

    JS     : kmFromFt = function (x) { return(x / 3280.8) }
    λ      : kmFromFt = λx  . x / 3280.8
    LS     : kmFromFt = (x) . x / 3280.8
    Haskell: kmFromFt =        (/ 3280.8)

# définition de fonctions


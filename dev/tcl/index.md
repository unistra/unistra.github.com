---
layout: page
title: TCL
---
{% include JB/setup %}

# Pourquoi pas (ou plus) tcl ? 

* pas de gestion de package ? 
    * [Debian Tcl Policy](http://pkg-tcltk.alioth.debian.org/tcltk-policy.html/) est debian centric. suffisant pour unistra ?
    * ActiveSate a un systeme de paquets. y'a un port standard ?
* pas d'emitter [TAP](http://testanything.org)
* pas de méchanisme de closure
    * même si il existe un [détournement avec alias](http://wiki.tcl.tk/3330),
      Tcl n'a pas de vraie closure. Du coup rien qui ressemble à des
      générateurs? j'ai trouvé un exemple d'[implémentation de
      filtres](http://wiki.hping.org/133) mais rien de "on-demand".


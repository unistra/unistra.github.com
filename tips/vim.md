---
layout: page
---
{% include JB/setup %}


# saine completion

ajoutez dans votre .vimrc:

    set wim=longest,list

pour obtenir un affichage des propositions de completion

quand vous etes dans un

# editer l'history dans un buffer

quand vous éditez une commande, tappez <c-f> pour vous retrouver dans un
buffer contenant l'historique des commandes. placez-vous sur n'importe
quelle commande, éditez-la, tappez <cr> et elle sera executée.

# set paste

ca merde quand vous copiez depuis le clipboard avec la souris? c'est parceque
tout est interpreté comme une saisie au clavier: du coup les macros sont
déclenchées.

la soluc? 

    :set paste
    # faire la copie
    :set nopaste

## mieux ? 

toutes les options booléennes de vim (celles qui peuvent être précédées par no)
ont un operateur '!' (toggle). on peut donc écrire

    :set paste!
    # faire la copie
    :set paste!

## la macro ? 

    nnoremap ,p :paste!<cr>

# remplir son buffer grace au monde

! permet de piper du contenu à votre shell. ainsi 

    :!ls  " affiche le résultat de ls
    :r!ls " copie le résultat de ls dans votre fichier 
    :,$!sort " trie toutes les lignes jusqu'à la fin du fichier avec sort

# TODO: va mourrir, toi et ton IDE! 

* navigation dans les fenetres, les buffers
* utilisation de vim comme filtre et navigation dans les répertoires, fichiers
* vimdiff
* omnicompletion
* eclim ? 

# q utilise les buffers nommés

c'est bon à savoir parceque ca permet d'editer la macro en faisant un 'let @a'
ou, dans un buffer, ou '"ay' et '"ap'



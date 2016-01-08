% Trucs et astuces vim

# configuration

    set wim=longest,list    # completion décente
    set hlsearch incsearch  # highlight ce qui a été trouvé et ce qu'on trouve
    set paste!              # pour éviter que la souris casse tout


# Best of normal

    ZZ # enregistrer et quitter
    ZQ # quitter sans enregistrer
    *  # chercher la prochaine occurence du mot sur lequel on est
    ctrl-x-f # completer avec le nom d'un fichier

# Best of command

    <range>v//   # comme grep -v
    <range>g//   # comme grep
    <range>s///  # comme sed
    <range>y a   # copie dans "a
    <range>d     # supprime

# editer l'historique des commandes et recherches

parceque vous voulez toute la puissance de vi quand vous éditez vos commandes

    q:  # éditer l'historique des commandes
    q:  # éditer l'historique des recherches

si vous êtes déjà en mode commande (ou recherche), tappez ctrl-f.

# toggle

    nnoremap ,!p :set paste!<cr>
    nnoremap ,!n :set nu!<cr>

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

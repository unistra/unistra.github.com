---
layout: page
---
{% include JB/setup %}

# alias qui vont bien

tappez

    echo alias g=git >> ~/.zshenv
    git config --global alias.s=status -s
    git config --global alias.ci=commit
    git config --global alias.co=checkout
    git config --global alias.br=branch
    git config --global alias.aa=add -A
    git config -l # vérifions que tout est bien en place
    git config -e # éditons

apres avoir sourcé votre /.zshenv, vous pouvez maintenant tapper

    g s

plutot que status -s

dans votre ~/.ssh/config, ajoutez

    Host gh
    Hostname github.com
    User git

vous pouvez maintenant tapper

    g clone gh:eiro/p5-perlude


installer fugitive.vim pour utiliser git directement depuis vim

# git et svn

il est possible de maintenir un depot git qui puisse faire un rebase avec une
série de patches venus d'un serveur SVN. c'est ce que je fais avec [sympa](http://sympa.org).

    git svn clone https://subversion.renater.fr/sympa/branches/sympa-6.1-branch sympa
    cd sympa
    git remote add origin git@github.com:eiro/sympa.git
    git push -u origin master

et de temps en temps

    git svn fetch
    git svn rebase

du coup mes devs sont dans une branche devel que je sync depuis master. POINT!
il serait pe plus simple de maintenir le git dans une branche 'mainstream'. pas
cherché.

# des infos git dans le prompt zsh

precmd est une commande qui est lancée par zsh avant chaque affichage de
prompt. par defaut elle ne fait rien mais il est possible de la surcharger.

    shush2 () { "$@" 2> /dev/null }
    git_whatsup () {
        local up="$(shush2 git log -1 --format='%d')"
        [[ -n $up ]] && print "$up + $( shush2 git status -s |wc -l) modifs"
    }
    precmd () { export PS1="[%T] %n@%M%b:%~ |$(git_whatsup )"$'\n'"> " }

# pour montrer qu'on roxe

Depuis git 1.7.9 on peut signer ses commits (la classe nan ?)

    ~# gpg --list-keys
    ...
    pub   2048R/86CBFE18 1970-01-01
    uid   t0mab

Une fois qu'on a identifié la clé qui va bien on configure git aux petits oignons

    ~# git config --global user.signingkey 86CBFE18

Ensuite on peut signer ses commits à l'aide de l'option -S de git

    ~# git commit -S

Ensuite pour verifier l'origine des commits :

    ~# git log --show-signature

    commit 06bc0d1801dc21f8fa0a4842124705b6105206d1
    gpg: Signature faite le mar. 12 févr. 2013 17:13:23 CET avec la clé RSA ID 86CBFE18
    gpg: Bonne signature de « Trauma Bagai <nospam@somewhere.fr> »
    Author: Trauma Bagai <nospam@somewhere.fr>
    Date:   Tue Feb 12 17:12:39 2013 +0100

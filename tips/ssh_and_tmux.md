% trucs et astuces ssh+tmux

# configurer votre client ssh (~/.ssh/config)

vous pouvez configurer le comportement par defaut de votre client ssh et créer
des aliases dans ~/.ssh/config. les directives s'appliquent à tous les hosts
dont le motif de la ligne host est correct. Voilà qq bonnes recettes

## les aliases

    Host gh
    Hostname github.com
    User git

    Host foo
    Hostname foo.example.com
    User adm

    Host bar
    Hostname bar.example.com
    User adm

vous pouvez maintenant tapper

* 'ssh foo' et non 'ssh adm@foo.example.com'
* 'scp .zshenv foo:' et non 'ssh adm@foo.example.com'

ça marche avec à peu prêt toutes les commandes (rsync, git, …), ainsi vous
pouvez saisir

git clone gh:unistra/unista.github.com

pour cloner le dépot de ce site (si vous en avez les droits)

## forward  systèmatique de votre agent

    Host *
    ForwardAgent yes

Votre agent sera maintenant systématiquement retransmis. Ainsi la commande qui
suit ne vous demandera pas votre mot de passe sur bar.

    ssh foo ssh bar ls

## ssh proxy command

vous pouvez utiliser une commande qui sera éxécutée par un mandataire pour se connecter à une autre machine

soit:

* vous disposez d'un compte 'jo' sur foo
* foo protégée par du firewalling
* vous avez accès à bar, machine pour laquelle la règle de firewalling ne s'applique pas
* nc (netcat) est installée sur bar

vous vous connectez à foo en transférant tout le traffic de bar via nc

    Host foo
    Hostname foo.example.com
    User jo
    ProxyCommand ssh bar nc %h %p

vous tappez maintenant

* `ssh foo ls` et non `ssh bar ssh foo ls`

vous pouvez aussi utiliser les outils traditionnels (scp, git, rsync, …) de manière transparente.

# créer un pseudoterminal

des commandes comme tmux, vim et autres nécessitent des que les tty soient correctement initialisées pour fonctionner. vous pouvez lancer ces commandes directement en forcant la création des tty:

    ssh -t vim /etc/foo

# vimdiff entre 2 machines

il est possible d'éditer un fichier directement avec vim grace au protocole 'scp:', il est tout aussi simple de faire un diff entre deux machines:

    vim scp://foo/.zshenv
    vimdiff scp://foo/.zshenv .zshenv

encore un petit alias qui va bien:

    rediff () {
	    local f=$1
	    shift
	    vimdiff scp://$^@/$f $f
    }

et maintenant: 'rediff .zshrc foo bar' ouvre un vimdiff avec les .zshrc de localhost, foo et bar

# t, l'alias pour aller plus vite

surtout sur les serveurs, il est de bon ton d'utiliser des sessions nommées.

* pour créer une session nommée foo:  tmux new -s foo
* pour s'attacher à une sesion nommée foo: tmux att -t foo
* pour voir la liste des sessions: tmux ls

la plupart des commandes tmux lancées se résument à ces 3 usages. t est un alias qui simplifie tout çà:

* 't' liste les sessions existantes
* 't foo' s'attache foo si elle existe, la crée si besoin

	t () {
	    (( $+1 )) || {
		tmux ls | sed 's/:.*//'
		return
	    }
	    tmux att -t $1 ||
		tmux new -s $1
	}

# inviter un collègue sur sa session tmux

Afin d'inviter des collègues a travailler à distance sur son tmux,

ajoutez les clefs de vos collègues dans vos '~/.ssh/authorized_keys'
en préfixant les lignes par une commande qui sera forcée lors de la connexion.

    command="tmux att -t hack" ssh-dss AAAB3NzaC1kc3MAAA... jean@u

jean ne peut maintenant se connecter à votre machine (et avec votre identitée) que si une session "hack" y existe. renommez votre session de travail "hack" et invitez-le.

    tmux rename-session hack

# daily tmux

## en vrac

* `%` et `"` permettent de split et vsplit la fenetre courante.
* les fleches permettent de naviguer d'un pane a l'autre.
* `z`: passer le pane courant en pleine fenetre.
* `w`: selection par menu de la fenetre courante
* `s`: selection par menu de la session courante

    tmux list-keys -t table # par exemple vi-copy

## déplacer des panes dans une autre session

lorsque ta session deborde et que tu déplacerais bien qq fenetres dans 
une nouvelle session (appellons-la awesome)

    :new -ds awesome # pour créer une session depuis la session
    :movew aw        # pour bouger la fenetre courante 
                     # dans la session dont le nom commence par "aw"


---
layout: page
---
{% include JB/setup %}

# configurer votre client ssh (~/.ssh/config)

vous pouvez configurer le comportement par defaut de votre client ssh et créer
des aliases dans ~/.ssh/config. les directives s'appliquent à tous les hosts
dont le motif de la ligne host est correct. Voilà qq bonnes recettes

## les aliases

<code><pre>

host gh
hostname github.com
user git

host foo
hostname foo.example.com
user adm

host bar
hostname bar.example.com
user adm
</pre></code>

vous pouvez maintenant tapper 

* 'ssh foo' et non 'ssh adm@foo.example.com'
* 'scp .zshenv foo:' et non 'ssh adm@foo.example.com'

ça marche avec à peu prêt toutes les commandes (rsync, git, …), ainsi vous
pouvez saisir 

git clone gh:unistra/unista.github.com

pour cloner le dépot de ce site (si vous en avez les droits)

## forward  systèmatique de votre agent

<code><pre>
host *
ForwardAgent yes
</pre></code>

Votre agent sera maintenant systématiquement retransmis. Ainsi la commande qui
suit ne vous demandera pas votre mot de passe sur bar.

<code><pre>
ssh foo ssh bar ls
</pre></code>

## ssh proxy command

vous pouvez utiliser une commande qui sera éxécutée par un mandataire pour se connecter à une autre machine

soit:

* vous disposez d'un compte 'jo' sur foo
* foo protégée par du firewalling
* vous avez accès à bar, machine pour laquelle la règle de firewalling ne s'applique pas
* nc (netcat) est installée sur bar

vous vous connectez à foo en transférant tout le traffic de bar via nc

<code><pre>
host foo
hostname foo.example.com
user jo
ProxyCommand ssh bar nc %h %p
</pre></code>

vous tappez maintenant

* 'ssh foo ls' et non 'ssh bar ssh foo ls'

vous pouvez aussi utiliser les outils traditionnels (scp, git, rsync, …) de manière transparente.

# créer un pseudoterminal

des commandes comme tmux, vim et autres nécessitent des que les tty soient correctement initialisées pour fonctionner. vous pouvez lancer ces commandes directement en forcant la création des tty:

<code><pre>
ssh -t vim /etc/foo
</pre></code>

# vimdiff entre 2 machines

il est possible d'éditer un fichier directement avec vim grace au protocole 'scp:', il est tout aussi simple de faire un diff entre deux machines:

<code><pre>
vim scp://foo/.zshenv
vimdiff scp://foo/.zshenv .zshenv
</pre></code>

encore un petit alias qui va bien:

<code><pre>
rediff () {
        local f=$1
        shift
        vimdiff scp://$^@/$f $f
}
</pre></code>

et maintenant: 'rediff .zshrc foo bar' ouvre un vimdiff avec les .zshrc de localhost, foo et bar

# t, l'alias pour aller plus vite

surtout sur les serveurs, il est de bon ton d'utiliser des sessions nommées.

* pour créer une session nommée foo:  tmux new -s foo
* pour s'attacher à une sesion nommée foo: tmux att -t foo
* pour voir la liste des sessions: tmux ls

la plupart des commandes tmux lancées se résument à ces 3 usages. t est un alias qui simplifie tout çà:

* 't' liste les sessions existantes
* 't foo' s'attache foo si elle existe, la crée si besoin

<code><pre>
t () {
    (( $+1 )) || {
        tmux ls | sed 's/:.*//'
        return
    }
    tmux att -t $1 ||
        tmux new -s $1
}
</pre></code>

# inviter un collègue sur sa session tmux

Afin d'inviter des collègues a travailler à distance sur son tmux,

ajoutez les clefs de vos collègues dans vos '~/.ssh/authorized_keys'
en préfixant les lignes par une commande qui sera forcée lors de la connexion.

<code><pre>
command="tmux att -t jean" 
</pre></code>

jean ne peut maintenant se connecter à votre machine (et avec votre identitée) que si une session "jean" y existe. renommez votre session de travail "jean" et invitez-le.

<code><pre>
tmux rename-session jean
</pre></code>


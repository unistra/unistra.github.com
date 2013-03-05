---
layout: post
title: Git commit author depuis le fichier authorized  keys
author: decornod
category : tips/git
tags : [tips, git, ssh]
---
{% include JB/setup %}

Lorsque l'on se connecte à distance (via `ssh`) à plusieurs sur les mêmes machines en propagant l'agent `ssh` (option `-A` par ex), les opérations réalisées dans git utilisent bien la clef de l'agent, mais l'identité utilisée est en général `root <root@host.domain.fr>`…

L'idée ici est de produire au login quelques variables d'environnement pour git à partir du fichier `~/.ssh/authorized_keys`.

## le fichier `~/.ssh/authorized_keys`

Le fichier [`~/.ssh/authorized_keys`][authorized_keys][^1] est en général de la forme :

    ssh-rsa AAAAB3…iPk== /home/user1/.ssh/id_dsa
    ssh-rsa AAAAB5…21S== commentaire
    ssh-rsa AAAAB2…19Q== user2@example.net
    ssh-rsa AAAAC3…51R== John Doe <john.doe@domain.fr>

La forme qui nous intéresse est la dernière (ou l'avant-dernière).

[authorized_keys]: http://www.linuxmanpages.com/man8/sshd.8.php#lbAJ

## les variables d'environnement

Les variables d'environnement utilisées par [`git commit`][git-commit-tree][^2] sont :
* __`GIT_AUTHOR_NAME`__, `GIT_COMMITTER_NAME`,
* `GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_EMAIL` & __`EMAIL`__:.

(celles qui nous intéressent sont en gras)

[git-commit-tree]: https://www.kernel.org/pub/software/scm/git/docs/git-commit-tree.html#_commit_information

## principe

1. La clef permettant l'identification est la _signature_ de la clef obtenue `ssh-add -L` (deuxième champ) ;
2. et comparée à la _signature_ dans le `~/.ssh/authorized_keys` (deuxième champ).
3. Le nom et l'adresse mail sont extraits du _commentaire_ de la clef (à partir du troisième champ).

## le script

{% highlight raw %}
#!/bin/bash

# define GIT Name from ~/.ssh/authorized_keys
declare -x $(awk -v ORS=" " 'BEGIN {
    while ("ssh-add -L" | getline keys)
    {
      split(keys,tmp," ");
      IDHASH[tmp[2]]=1
    }
    close("ssh-add -L") }
  $2 in IDHASH {
    $1=""; $2=""; sub("^ *","",$0);
    NAME=$0; EMAIL=$0;
    sub(" *<(.*)> *$","",NAME);
    sub("^.*<","",EMAIL); sub("> *$","",EMAIL);
    print "GIT_AUTHOR_NAME=\"" NAME "\"";
    print "EMAIL=\"" EMAIL "\"" }' \
 ~/.ssh/authorized_keys )
{% endhighlight %}


[^1]: page de manuel de [sshd(8)][authorized_keys].
[^2]: page de manuel de [git-commit-tree(1)][git-commit-tree].

<!-- vi: set ft=markdown :-->

% administration debian

# Cookbook

## aptitude

### les motifs de selection

ils permettent d'utiliser `~` pour donner un contexte (cf. la 
[liste des motifs basiques](https://www.debian.org/doc/manuals/debian-reference/ch02.en.html#_basic_package_management_operations)).

exemples avec aptitude search

    aptitude search '~i' -F'%p' # liste des paquets installés

autres exemples de motifs

	# quel est votre serveur de messagerie?
	# * il fournit (~Dprovides) un MTA
	# * il est installé (~i)
	~i~Dprovides:mail-transport-agent

	# quels sont les paquages non-installés dont ne nom contient
	# bash ou zsh ?
	!~i ~n (zsh|bash)

	# quels sont les libs perl packagées dans debian
	# le nom
	# * commence par lib
	# * finit par -perl
	'~n ^lib ~n -perl$'


## deborphan

Lea ?

# Questions ouvertes

## marc

pourquoi ce sont les apt-tools qui sont recommendés alors qu'a l'usage,
`aptitude` est plus simple et plus puissant? 


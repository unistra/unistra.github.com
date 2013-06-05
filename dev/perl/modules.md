# Prérequis

    perldoc perldoc 
    perldoc -f require
    perldoc -f use

# Préparer des modules 

## installer les composants de base sous debian 

installer

    aptitude search '~n(local-lib-perl|cpanm)'
    i   cpanminus                       - script to get, unpack, build and install m
    i   liblocal-lib-perl               - module to use a local path for Perl module

interactivement ou dans l'environement du compte de travail:

    eval $( perl -Mlocal::lib )

installer Dist::Zilla via CPAN

    cpanm Dist::Zilla

dzil pour créer et construire un paquet

    dzil new Mon::Module
    cd mon-module
    # hack hack hack (demander a marc si besoin)
    dzil build

## créer un depot

ces instructions se basent sur le fait que:

* j'ai un shell sur www.example.com
* je peux modifier le documentroot de cette machine
* je veux créer un depot dans un répertoire qq (comme le code actuel d'ubuntu)

deplacez vos *deb dans le documentroot de www.example.com puis depuis ce répertoire: 

    dpkg-scanpackages . | gzip -c9 > Packages.gz


## ajouter le depot sur un serveur

# l'extension est importante

cat  << EOF > /etc/apt/sources.list.d/whatever.list

# depot de métro/supervision
deb http://www.example.com/qq ./

EOF


################################################################################
#######                                                                  #######
#######                   LES GRAPHIQUES SOUS R part 1                   #######
#######                  -------------------------------                 #######
#######                 Kevin Cazelles, Nicolas Casajus                  #######
#######                      - 9 decembre 2015 -                         #######
#######                                                                  #######
################################################################################



################################################################################
#####
##### AVANT-PROPOS
#####
##### INTRODUCTION
#####
#####   . Le package 'graphics'
#####   . Mon 'Hello world' plot
#####
##### 1. LES GRAPHES DE BASE
#####    High-level plotting functions
#####
#####   1.1. Diagramme de dispersion
#####   1.2. Boite a moustache
#####   1.3. Diagramme en batons
#####   1.4. Histogramme
#####   1.5. Diagramme sectoriel
#####   1.6. Fonction image()
#####   1.7. Fonction trigo
#####
##### 2. EDITION D'UN GRAPHE
#####    Low-level plotting functions
#####
#####   2.1.  Empty plot
#####   2.2.  Ajout de points
#####   2.3.  Ajout de lignes
#####   2.4.  Ajout de polygones
#####   2.5.  Ajout d'une fleche
#####   2.6.  Ajout de symboles
#####   2.7.  Ajout d'un titre
#####   2.8.  Ajout de texte
#####   2.9.  Ajout d'une legende
#####   2.10. Ajout d'axes et de box
#####   2.11. Ajout d'une image
#####
#####
##### 3. PARAMETRES GRAPHIQUES
#####
##### 4. PERIPHERIQUES GRAPHIQUES ET EXPORTATION
#####
##### 5. PARTITIONNEMENT D'UNE FENETRE
#####
##### EXERCICES
#####
################################################################################



################################################################################
#####
##### AVANT-PROPOS
#####

# Ce qui suit n'est pas une introduction a R. C'est simplement une breve
# introduction aux graphiques sous R avec des suggestions de bonnes pratiques
# qui sont seulement le reflet de l'experience de la pratique de R des auteurs.
#
# Pour l'utilisateur totalement debutant, nous recommendons la lecture des deux
# documents suivants (ressources en francais) :
#
#   - L'introduction a R redigee par Emmanuel Paradis
#     (les pages 1 a 35 sont suffisantes pour la suite)
browseURL("http://cran.r-project.org/doc/contrib/Paradis-rdebuts_fr.pdf")

#   - L'introduction a R sur le site internet "OpenClassRoom"
#     (les 11 points qui y sont developpes sont pertinents)
browseURL("http://fr.openclassrooms.com/informatique/cours/effectuez-vos-etudes-statistiques-avec-r/introduction-a-r")

# 	- Pour une review sur les packages, nous avons ecrit un truc a ce sujet:
browseURL("http://kevincazelles.fr/rgraphics/2015/12/04/r-and-graphics.html")
#		- Qui renvoit entre autres a une review de package disponible sur le CRAN:
browseURL("https://cran.r-project.org/web/views/Graphics.html")


# La maitrise d'un langage informatique de haut niveau comme R, au sens ou il
# "fait abstraction des caracteristiques techniques du materiel utilise"
# - Wikipedia - repose sur la connaissance d'un certain nombre de fonctions.
# C'est precisemment ces dernieres que nous allons utiliser, chacune disposant
# d'une aide accessible en utilisant le symbole "?". Par ex:
?plot
?plot.default

# A la fin de la description vous avez generalement des exemples.
# Au lieu de les recopier vous pouvez demander a les executer avec la fonction 'example'
example(plot)

# Il se peut aussi que vous ayez des vignettes c'est a dire des exemples plus detailles
# souvent en pdf
vignette(package="graphics")
vignette(package="grid")
vignette("moveline")

# Des demonstrations sont parfois disponibles :
demo(Hershey)

# Une recherche par mot clef est possible avec le "??". Attention, le temps de
# recherche peut-etre plus ou moins long...
??student

# Aussi les packages possedent tous une liste exhaustive des methodes et fonctions qu'ils
# developpent.
library(help = "base")

# NB : "base" est l'un des ensembles de methodes et fonctions fondamentales de R.
# Pour la formation qui suit :
library(help = "graphics")

# est plus judicieux.
# NB : l'ensemble des packages peut-etre visualise avec :
search()

# On peut voir les fonctions sous forme de liste avec la commande suivante :
ls(envir = as.environment("package:graphics"))

# Vous pourrez ainsi rapidement identifier les fonctions traitees en-dessous ou non.

# La fonction "apropos" vous permet de retrouver des fonctions par "pattern". Si
# vous vous rappeler le nom d'une fonction mais pas son orthographe exact, "apropos"
# vous facilitera la recherche.
apropos("read")

# Remarque : on peut utiliser des expressions regulieres pour une recherche plus
# performante.

# Recherchons toutes les fonctions qui commencent par 'read' :
apropos("^read")

# Maintenant, recherchons toutes les fonctions qui se terminent par 'file' :
apropos("file$")

# Et celles qui commencent par 'read' et se terminent par 'file' :
apropos("^read+.+file$")

# Et si vous ne trouvez toujours pas, Google est votre meilleur ami :
browseURL("https://www.google.ca/#q=import%20data%20R")




################################################################################
#####
##### INTRODUCTION
#####

###                                                                          ###
###                                                [.] Le package 'graphics' ###
###                                                                          ###

# Le package 'graphics' fait partie des packages de base, c.-a.d. installe par
# defaut avec R. De plus, ce package se charge, par defaut, automatiquement.

# La philosophie des graphiques avec le package 'graphics' est simple et
# puissante : n'importe quel graphique peut-etre cree sans avoir recours a des
# packages complementaires (e.g. ggplot2, lattice, etc...). Cependant, cela a un
# coût : on peut tout faire, certes, mais avec un certain nombre de lignes,
# parfois important, nous le concedons volontiers...

# Mais, selon nous, il est important de commencer par le commencement, et de
# maîtriser les differents elements qui composent un graphique. Une fois cette
# maîtrise acquise, vous pourrez laisser libre cours a votre imagination et a
# votre inspiration pour ameliorer le rendu visuel de vos graphiques.

# Regardons rapidement les fonctions disponibles dans ce package, dont la plupart
# seront abordees ici.
library(help = "graphics")
# Une facon un peu plus sophistiquee d'obtenir la liste des fonctions d'un package :
ls(envir=as.environment("package:graphics"))



###                                                                          ###
###                                               [.] Mon 'Hello world' plot ###
###                                                                          ###

# Puisqu'un dessin vaut mieux qu'un long discours, realisons notre premier graphique :
plot(1)

# Que s'est-il passe ?
# Une fenetre graphique, aussi appelee peripherique graphique (ou 'device' en
# anglais) s'est d'abord ouverte. Puis, elle a ete recuperee les valeurs par
# defaut des parametres graphiques de R. Enfin, dans la zone de plot, elle a
# affiche l'objet que nous voulions representer (ici, la valeur 1).

# Nous developperons plus loin la notion de peripherique graphique. Mais, glissons
# rapidement quelques mots sur les parametres graphiques. Leurs valeurs par defaut
# sont stockees dans la liste 'par', accessible comme suit :
par()
# Remarque : si aucune fenetre n'est ouverte, une fenetre vide est ouverte.

# Ainsi, en recuperant ces valeurs, R a automatiquement determine les axes, la
# police, les couleurs, les marges, le symbole, etc. Toutes ces informations sont
# modifiables, et heureusement, car le rendu laisse un peu a desirer... Nous
# verrons plus loin comment modifier certains de ces parametres.

# Pour effecer le graphique courant en ligne de commande:
dev.off()

# Pour effecer tous les graphiques:
graphics.off()





################################################################################
#####
##### 1. LES GRAPHES DE BASE
#####

# Regardons tout d'abord quelques fonctions permettant de realiser des graphiques
# souvent utilises en science. Dans R, on realise de tels figures avec des 'High-level
# plotting functions', c.-a.d. que leur appel (execution) ouvrira automatiquement
# une nouvelle fenetre graphique. On les opposera aux 'Low-level functions' qui
# elles, permettront d'ajouter des elements a un graphique pre-existant. C'est
# l'objet du chapitre suivant.



###                                                                          ###
###                               1.1. Diagramme de dispersion (scatterplot) ###
###                                                                          ###

# Il s'agit d'un graphe classique permettant de representer deux variables
# continues l'une en fonction de l'autre dans un nuage de points.
# Nous allons reutiliser la fonction plot.
# Pour utiliser les fonctions nous utiliserons un des jeux de donnees installes
# par defaut avec R
data()
# Nous choississons le jeu de donnees historique "iris"
?iris

# Utilisons la longeur des sepales que l'on ordonne:
order1 <- order(iris$Sepal.Length)
(var1 <- iris$Sepal.Length[order1])
# Remarque : Les parentheses permettent d'afficher le resultat dans la console
# bien que nous ayons assigne le resultat a une variable.

# Utilisons la largeur des sepales comme seconde variable (on conserve l'ordre)
# etabli ci-dessus:
(var2 <- iris$Sepal.Width[order1])

# Faisons le scatterplot
plot(x = var1, y = var2)

# Nous aurions aussi pu ecrire
plot(var2 ~ var1)

# Anticipons legerement sur les chapitres suivants et interesserons nous a
# l'argument 'type' de la fonction plot. Ce dernier nous permet de representer
# de changer l'aspect du graphique.

# Afin de bien comprendre les differences, partitionnons la fenetre graphique en
# neuf regions (trois lignes et trois colonnes) chacune destinee a recevoir un
# plot. Nous allons donc modifier le parametre graphique 'mfrow' de la fonction
# par().
par(mfrow = c(3, 3))

# Representons les graphs 1 a 1.
plot(var1, var2, type = "p", main = "Type = p") # Par defaut
plot(var1, var2, type = "l", main = "Type = l")
plot(var1, var2, type = "b", main = "Type = b")
plot(var1, var2, type = "o", main = "Type = o")
plot(var1, var2, type = "c", main = "Type = c")
plot(var1, var2, type = "h", main = "Type = h")
plot(var1, var2, type = "s", main = "Type = s")
plot(var1, var2, type = "S", main = "Type = S")
plot(var1, var2, type = "n", main = "Type = n")

# Remarque 1 : l'argument 'main' permet de rajouter un titre au graph.


###                                                                          ###
###                                                   1.2. Boite a moustache ###
###                                                                          ###

# La boite a moustaches est une representation graphique tres utile en
# statistiques, puisqu'elle permet de resumer les caracteristiques de position
# (mediane, 1er et 3eme quartiles, minimum et maximum) d'une variable
# quantitative.
# Sous R, la fonction utilisee sera "boxplot".
par(mfrow = c(2, 3))
boxplot(var1)
boxplot(var2)

# Nous pouvons aussi comparer la distribution de deux (ou plusieurs) variables
# en meme temps.
boxplot(var1, var2, col=c(0,"grey75"))

# Remarque : l'argument 'col' permet d'ajouter de la couleur a chaque boxplot.
# Nous y reviendrons plus tard, mais cet argument s'applique a plusieurs
# fonctions, comme plot().

# Cette fonction s'applique sur des vecteurs, mais aussi sur des dataframes.
boxplot(iris[,-5], col=c(0,"grey25","grey50","grey75"))

# Remarque : il y a une correspondance pratique pour gagner du temps :
# 0=blanc; 1=noir ; 2=rouge ; 3=vert ; 4=bleu ; 5=bleu clair ; 6=violet ; 7=jaune ; 8=gris.
# regardez aussi 'colors()'; pour plus de détail voir plus bas.

# Rien ne change, si ce n'est le nom de chaque boite.
# D'autres arguments sont modifiables. Nous vous laissons vous referer a l'aide
# de cette fonction (?boxplot). Par ex. l'argument 'horizontal' permet de tracer
# les boites a l'horizontale.
boxplot(iris[,-5], col=c(0,"grey25","grey50","grey75"), horizontal=TRUE)



###                                                                          ###
###                                                 1.3. Diagramme en bâtons ###
###                                                                          ###

# Ce type de representation est utile pour visualiser des donnees discretes ou
# categoriques. Chaque modalite de la variable categorique (ou discrete) sera
# representee par une barre dont la longueur sera proportionnelle a son effectif
# (relatif ou absolu) parmi l'ensemble des modalites.
# Sous R, c'est la fonction barplot().

# Creons tout d'abord un vecteur contenant six modalites.
nomcol <- c("Vert", "Jaune", "Rouge", "Blanc", "Bleu", "Noir")

# Maintenant, nous allons tirer aleatoirement 1000 fois (avec remise) dans ce
# vecteur.
echn <- sample(x = nomcol, size = 1000, replace = TRUE)

# Comptons maintenant combien de fois se retrouve chaque modalite.
(var3 <- table(echn))

# Representons cette variable sous forme d'un barplot.
par(mfrow = c(2, 2))
barplot(var3)

# De la meme maniere, nous pouvons representer les valeurs relatives.
# Transformons cette variable en frequences.
barplot(var3/sum(var3))

# Et a l'horizontale avec des couleurs differentes
barplot(var3, horiz = T)

# Et avec des barres hachurees
barplot(var3, density = c(20, 20, 20, 20, 40, 60), angle = c(0, 45, 90, 135), col=c(1,1,1,2))

# Remarque : l'argument 'density' represente le nombre de hachures par pouce et
# l'argument 'angle' donne leur orientation.



###                                                                          ###
###                                                         1.4. Histogramme ###
###                                                                          ###

# L'histogramme permet de visualiser la repartition des valeurs d'une variable
# continue en categorisant ses valeurs. Il est tres utile pour connaître la loi
# de distribution que suivent les valeurs (loi normale, loi de Poisson, etc.).
# Sous R, ce graph se fera a l'aide de la fonction "hist()".

# Tracons la distribution de ces valeurs
par(mfrow = c(2, 2))
hist(var1)

# Modifions les classes avec
hist(var1, breaks = seq(from = 4, to = 8,by = 0.25))

# Ajoutons de la couleur
hist(var1, col = "red", lty=2)

# Et hachurons
hist(var1, density = 20, angle = 45)



###                                                                          ###
###                                                 1.5. Diagramme sectoriel ###
###                                                                          ###

# Une alternative au diagramme en bâtons est le diagramme sectoriel (camembert).
# Regardons ce que ca donne avec le nombre d'individus par espece.

spp <- iris[ , 5]
spp <- table(spp)

# Camembert
pie(spp)


# Modifions les couleurs
pie(spp, col = c("white", "gray", "black"))

# Taper '?pie' pour connaître l'ensemble des arguments de cette fonction.

# En bonus, un bel arc-en-ciel
ncol <- 250
pie(rep(1, ncol), col = rainbow(250), border = NA, labels = "")

# En plus, un arc-en-ciel rotatif... (attention, pas si vous etes sous Rstudio...)
### run
for (i in 1 : ncol){
	if (i > 1){
		pie(rep(1, ncol), col = rainbow(ncol)[c(i:ncol, 1:(i-1))], border = NA, labels = "")
	}else
		pie(rep(1, ncol), col = rainbow(ncol), border = NA, labels = "")
}
### end run



###                                                                          ###
###                                                    1.6. Fonction image() ###
###                                                                          ###

B <- matrix(1:100, ncol = 10)
image(B, col = rainbow(100))

## Je reprends un exemple que vous pouvez trouver dans l'aide.
## 'volcano' est un jeu de donnees deja pret :

x <- 10*(1:nrow(volcano))
y <- 10*(1:ncol(volcano))

image(x, y, volcano, col = terrain.colors(100), axes = FALSE)
contour(x, y, volcano, levels = seq(90, 200, by = 5), add = TRUE, col = "#441100")

##

example(image)



###                                                                          ###
###                                           1.7. Fonction trigonometriques ###
###                                                                          ###

## Les fonctions trigo dans toute leur splendeur !
## Cette partie sert simplement a vous rappeler qu'un soupcon de maths (qui datent
## souvent de notre adolescence permet souvent de faire des figures pas pire).

par(mfrow = c(1, 2))

##

val <- seq(-2*pi, 2*pi, 0.001)
coef <- 10*seq(2, -2, -0.01)
x <- coef*cos(val)
y <- coef*sin(val)
plot(x, y, asp = 1, type = "l", axes=FALSE, col=6, xlab="", ylab="")

##

val <- seq(-5*pi, 5*pi, 0.0001)
coef <- 10^seq(0, -1.5, along.with = val)
x <- coef*cos(val)
y <- coef*sin(val)
plot(x, y, asp = 1, type = "l", lwd=5, col=8, axes=FALSE, xlab="", ylab="")
lines(x, y, asp = 1, type = "l", lwd=1, col=4, axes=FALSE, xlab="", ylab="")





################################################################################
#####
##### 2. EDITION D'UN GRAPHE
#####

# Regardons maintenant comment editer un graphique. En d'autres termes, nous allons
# ajouter des elements a un graphique existant, elements qui peuvent des points, des lignes,
# des symboles, du texte ou encore une legende. L'appel aux fonctions precedentes
# avait pour consequence d'ouvrir un nouveau peripherique graphique. Ici, nous
# allons utiliser des 'Low-level plotting functions', qui n'ouvriront pas de
# nouveau peripherique graphique mais utiliseront celui qui est deja ouvert
# (actif) pour l’editer.
# Condition requise :  un peripherique graphique doit etre prealablement ouvert
# avec d'utiliser de telles fonctions.



###                                                                          ###
###                                                          2.1. Empty plot ###
###                                                                          ###

# La philosophie des auteurs en termes de graphiques sous R est simple :
# ajouter les elements un a un, en commencant par ouvrir une fenetre graphique
# avec des dimensions (axes et marges) de leur choix mais sans que rien ne
# s'affiche a l’ecran. Regardons donc comment creer un graph vide?

# Commencons par le commencement :
par(mfrow=c(1,1))
plot(var1, var2)

# Ici, les axes sont determines automatiquement par R en fonction de la gamme
# de valeurs de nos deux variables.
# Modifions l’etendue des axes avec les arguments 'xlim' et 'ylim'.
plot(var1, var2, xlim = c(4, 8), ylim = c(1.5, 5))

# Maintenant, nous ne voulons pas afficher les points. Nous pouvons utiliser
# l'argument 'type' de la fonction plot
plot(var1, var2, xlim = c(4, 8), ylim = c(1.5, 5), type = "n")

# Utiliser xlim et ylim permet de choisisr l'etendu des axes a la main.
# Si on se satisfait du choix par defaut de R, on peut simplement ecrire:
plot(var1, var2, type = "n")

# Supprimons les axes avec les arguments 'xaxt' et 'yaxt' et 'axes'
par(mfrow=c(2,3))
plot(var1, var2)
plot(var1, var2, type = "n", xaxt = "n")
plot(var1, var2, type = "n", xaxt = "n", yaxt = "n")
plot(var1, var2, type = "n", xaxt = "n", yaxt = "n", bty="n")
# Supprimons tous les axes, même la boite:
plot(var1, var2, type = "n", axes=FALSE)
# Finalement, supprimons les etiquettes des axes, seul element restant.
plot(var1, var2, type = "n", axes=FALSE, ann=FALSE)

# Et voila ! Un graph vide avec des dimensions specifiees.
# Notre ami Kevin a eu la tres bonne idee de creer une fonction pour cela.
plot0 <- function(x = c(-10,10), y = c(-10,10), type = "n", ...){
    plot(x, y, type=type, axes=FALSE, ann=FALSE, ...)
}
# Remarque : avec "..." nous permettons a l'utilisateur d'ajouter des arguments de la fonctions plot.
#            Dans notre exemple, les arguments non-explicite dans la liste des arguments de plot0
#            peuvent etre ajoutes.


# Ainsi, si nous souhaitons ouvrir un graph vide,
par(mfrow=c(1,1))
plot0()
##
plot0(var1, var2)



###                                                                          ###
###                                                     2.2. Ajout de points ###
###                                                                          ###

# Pour inserer des points sur un graphe, rien de plus simple : il suffit
# d'utiliser la fonction 'points'. Celle-ci possede un tres grand nombre
# d'arguments en commun avec la fonction 'plot'.

# Utilisons la longeur des petales

var4 <- iris$Petal.Length[order1]

# Tracons tout d'abord var2 en fonction de var1
plot0(var1, var2)
points(var1, var2, col = "red")

# Modifions la representation des points avec l'argument 'pch'.
plot0(range(var1), range(var2,var4))
points(var1, var2, pch = 19)
points(var1, var4, pch = 15)

# Modifions la taille des symboles avec l'argument 'cex'.
plot0(range(var1), range(var2,var4))
points(var1, var2, pch = 19, cex=1)
points(var1, var4, pch = 15, cex=1.6)

# Mais, attention a l’etendue des axes du graphe a editer : les points a rajouter
# doivent avoir le meme range de valeurs que ceux-ci. Sinon, il faudra modifier
# l'entendue des axes dans la fonction plot avec 'xlim' et 'ylim'.

# plot(1:25,1:25,pch=LETTERS[1:25])

# Introduisons maintenant une commande interessante sous R : la fonction locator().
# Celle-ci permet de recuperer les coordonnees d'un (ou plusieurs clics) sur un
# graph.

plot(var1, var2, pch = 15, col = "red")
(loc1 <- locator(n = 2))

# Mais, cette fonction permet egalement de rajouter simultanement ces points sur
# le graphe.
loc2 <- locator(n = 3, type = "p", pch=15, col="blue")

# En association avec la fonction 'points'.
points(locator(4), pch = 19, col = "green", cex=2.5)



###                                                                          ###
###                                                     2.3. Ajout de lignes ###
###                                                                          ###

# Plusieurs fonctions permettent de tracer une ligne sous R. Tout depend de
# l'information de depart. Si on dispose des coordonnees des deux points
# extremes, nous pouvons utiliser la fonction 'point'.

plot(var1, var2, pch = 15)
points(x = c(4.5, 8), y = c(2, 4), type = "l")

# Modifions le type de ligne.
plot(var1, var2, pch = 15)
points(x = c(4.5, 8), y = c(2, 4), type = "l", lty = 3, lwd=2)

# La fonction 'lines' s'utilisera de la meme maniere que 'points'.
plot(var1, var2, pch = 15)
lines(x = c(4.5, 8), y = c(2, 4), lty = 23, lwd=2)

# La fonction 'abline' permettra de tracer des lignes horizontales, verticales et
# des droites de regression a partir des coefficients estimes.
plot(var1, var2, pch = 15, type = "b")
abline(h = seq(2,4,0.5), v = 6, col = 4)
abline(a=0, b=.5, col=3)
##
plot(var1, var2, pch = 15, type = "b")
abline(reg = lm(var2 ~ var1), col = "red", lwd=2)
# Rajoutons la droite var2=var1.
lines(x = c(1, 20), y = c(1, 20), lty = 3)

# Enfin, la fonction segment permet de relier deux points entre eux.
plot(var1, var2, pch = 15)
segments(x0 = var1[1], y0 = var2[1], x1 = var1[2], y1 = var2[2])
# Creons deux autres segments
segments(var1[1], var2[1], var1[100], var2[100])
segments(var1[100], var2[100], var1[2], var2[2])

# Tracons une droite en cliquant
locator(n = 2, type = "l", col = "blue", lty = 3)
lines(locator(4), col=2)
loc3 <- locator(4, type="o", col=3)

# Remarque : a la difference de 'points', 'lines' et 'segments', la fonction
# 'abline' n'est pas bornee aux extremites : son trace commencera et se
# terminera aux marges de la region du plot.



###                                                                          ###
###                                                  2.4. Ajout de polygones ###
###                                                                          ###

# Inserer une forme polygonale sur un graphe se fera a l'aide de la fonction
# 'polygon'.
plot(var1, var2, pch = 15)
polygon(x = c(5,5, 7, 7, 8, 8), y = c(2, 3, 4, 4, 4, 3))
##
polygon(x = c(4.5, 6, 8), y = c(2, 4, 4), density = 20, angle = 45)

# Nous retrouvons ici des arguments vu precedemment dans d'autres fonctions.
# Voyons un exemple en couleurs.

# Creons trois nouvelles variables
seqX <- seq(-20, 20, 0.01)
GaussA <- dnorm(seqX, mean = -2, sd = 4)
GaussB <- dnorm(seqX, mean = 4, sd = 4)

# Tracons ces distributions
plot(range(seqX), range(GaussA), type = "n")
polygon(x = seqX, y = GaussA, border = 0, col = "#FF000088")
polygon(x = seqX, y = GaussB, border = 0, col = "#0000FF88")

# Remarque : Ici, nous venons d'attribuer deux couleurs dans un format un peu
# special. Il s'agit du format hexadecimal, apres le diese, les 2 premiers symboles
# refletent la quantite de rouge, les 2 suivants celle de vert, puis 2 autres pour le bleu
# et enfin les 2 derniers symboles representent la transparence.
# Rappel : hexadecimal signifie que la notation d'une quantite se fait a l'aide de
# 16 symboles (en general les chiffres de 0 a 9 et les lettres de A a F),

# Voyons maintenant un cas particulier de polygone : le rectangle. Celui-ci
# s'obtient avec la fonction 'rect'.
plot(var1, var2, pch = 15)
rect(xleft = 4.5, ybottom = 2.5, xright = 7.5, ytop = 4, col = "gray")
points(var1, var2, pch = 15)
rect(xleft = 4.8, ybottom = 2.7, xright = 7.2, ytop = 3.8, density = 20, angle = 45)

# Et en incluant la fonction 'locator', nous pouvons dessiner un polygon a la main.
polygon(locator(5), col = "#0000FF88", border = 0)
# Pour suivre les traits que vous dessinez
polygon(locator(5, type="l", col=4), col = "#0000FF88", border = 0)



###                                                                          ###
###                                                  2.5. Ajout d'une fleche ###
###                                                                          ###

# On peut aussi tracer des fleches avec la fonction 'arrows'. On peut specifier
# si la fleche sera en debut ou en fin de lignes (ou les deux) avec l'argument
# 'code'. Mais aussi la longueur de la fleche et son angle par rapport a la
# droite.
plot(c(0, 2), c(0, 2), type = "n")
arrows(x0 = 0, y0 = 0, x1 = 0, y1 = 2, length = 0.25, angle = 30, code = 1)
arrows(x0 = 2, y0 = 0, x1 = 2, y1 = 2, length = 0.25, angle = 30, code = 2)
arrows(x0 = 0, y0 = 2, x1 = 2, y1 = 0, length = 0.75, angle = 10, code = 3, lwd=2, col=2)



###                                                                          ###
###                                                   2.6. Ajout de symboles ###
###                                                                          ###

## Cette fonction permet simplement de rajouter des cercles, des carrees,
## des rectangles, des etoiles, des thermometres et des boxplots.

# Commencons par un cercle. Avec cette fonction, nous donnons les coordonnees des centres
# ainsi qu'un vecteur de rayons associes a ces centres :
plot(var1,var2)
symbols(x=c(5,4), y=c(4,6), circles=c(1,2))
# Remarque : vous devez specifier un type de symbole.
# Nous avons bien obtenu nos cercles. Cependant, nous avons supprime la figure precedente.
# Nous pouvons empecher cela en utilisant le parametre 'add'. Nus ajoutons egalement
# 1- l'utilisation de 'locator' et 2- la couleurs grâce aux parametres fg (couleur du bord du cercle)
# et bg (remplissage).
plot(var1,var2)
symbols(locator(2), circles=c(1,2), add=TRUE, bg=c("#FF000088","#0000FF88") , fg=2)

# En utilisant le meme principe, nous pouvons faire le carree, le vecteur de rayon
# devient un vecteur de la taille du côte
symbols(locator(2), square=c(1,2), add=TRUE, bg=c("#FF000088","#0000FF88") , fg=2)

# Et de meme, nous pouvons utiliser les autres symboles proposes en regardant bien les
# parametres a specifier pour chacun
plot(var1,var2, type="n")
symbols(locator(3), rectangles=matrix(2*runif(6),3), add=TRUE, bg=4 ,fg=2)
symbols(locator(2), stars=matrix(c(rep(1,7),runif(7)),2,byrow=TRUE), add=TRUE, bg=4 ,fg=2)
symbols(locator(1), thermometers=matrix(c(1,6,0.75),1), add=TRUE, bg="white" ,fg=2)
symbols(locator(1), boxplot=matrix(c(1,6,2,4,0.85),1), add=TRUE, bg=4 ,fg=2)


###                                                                          ###
###                                                    2.7. Ajout d'un titre ###
###                                                                          ###

# Nous avons deja vu precedemment comment definir un titre directement dans la
# fonction 'plot'. Pour rappel.
plot(var1, var2, pch = 15, main = "var2 en fonction de var1")

# Mais, nous pouvons egalement utiliser la fonction 'title' qui aura le meme
# effet.
plot(var1, var2, pch = 15)
title(main = "var2 en fonction de var1")

# Nous pouvons aussi inserer un sous-titre si besoin est.
title(sub = "Scatterplot", col.sub = "red", cex.sub = 0.75)

# Remarque : l'argument 'sub' est aussi disponible dans la fonction plot.
# L'argument 'cex.sub' permet de modifier la taille du sous-titre.
# Nous developperons ce point plus loin dans le chapitre 3.



###                                                                          ###
###                                                      2.8. Ajout de texte ###
###                                                                          ###

# Regardons maintenant comment inserer du texte dans la zone de plot. La fonction
# a utiliser est la fonction 'text' (quand on vous dit que R est un langage
# intuitif...).

# Creons un vecteur de 20 lettres
(nom <- letters[1 : length(var1)])

# Plutôt que de representer des points, affichons ces lettres aux coordonnees
# (var1, var2).
par(mfrow = c(1, 2))
plot(var1, var2, pch = 15)
plot(var1, var2, type = "n")
text(x = var1, y = var2, labels = nom)

# Peut-on ajouter les deux informations sur le meme. A votre avis ?
plot(var1, var2, pch = 15)
text(x = var1, y = var2, labels = nom)

# Probleme majeur : les deux informations se superposent. Heureusement, la
# fonction 'text' est muni d'un argument permettant de position les etiquettes
# par rapport aux coordonnees avec l'argument 'pos'.
# Placons-les a gauche.
plot(var1, var2, pch = 15)
text(x = var1, y = var2, labels = nom, pos = 2)

# Ajoutons du texte en cliquant
text(locator(2), c("txt1", "txt2"), col = "red")

# Maintenant, essayons de cliquer en dehors de la zone de plot (dans les marges).
text(locator(1), "txt3", col = "blue")

# Rien ne s'affiche. C'est normal : la fonction 'text' ne permet d'afficher du texte
# qu'a l’interieur de la region du plot.

# Pour ajouter du texte dans les marges (par ex. pour ajouter le nom d'un axe), on
# preferera la fonction 'mtext' (m pour marge, hein).

# Cette fonction s’ecrit differemment cependant : l'argument 'side' indique dans
# quelle marge doit etre a afficher le texte (1 en bas, 2 gauche, 3 haut, 4 droite).
# L'argument 'line' permet quant a lui de positionner le texte par rapport a l'axe
# en question.

plot(var1, var2, pch = 15)
mtext(side = 1, line = 1, text = "mtext - line = 1")
mtext(side = 1, line = 2, text = "mtext - line = 2")
mtext(side = 1, line = 3, text = "mtext - line = 3")
mtext(side = 1, line = 4, text = "mtext - line = 4")
mtext(side = 1, line = 3, text = "mtext - line = 3", at = 5)

# Vu qu'on ne fournit pas de coordonnees dans cette fonction, la fonction 'locator'
# ne fonctionnera pas.



###                                                                          ###
###                                                 2.9. Ajout d'une legende ###
###                                                                          ###

# La fonction 'legend' presente de nombreux arguments. Nous vous laissons les
# decouvrir par vous-meme. Regardons plutôt quelques exemples d'utilisation.


# Un premier exemple.
var3 <- iris[ , 'Petal.Length']

plot(var1, var2, pch = 15, col = "blue", xlim = c(4, 8), ylim = c(1, 7))
points(var1, var3, pch = 15, col = "red")
legend("topleft", legend = c("var2", "var3"), pch = 15, col = c("blue", 'red'))

# Un second en cliquant.
plot(var1, var2, pch = 15, col = "blue", xlim = c(4, 8), ylim = c(1, 7))
points(var1, var3, pch = 15, col = "red")
legend(locator(1), legend = c("var2", "var3"), pch = 15, col = c("blue", 'red'))

# Et sans mais avec un fond gris.
plot(var1, var2, pch = 15, col = "blue", xlim = c(4, 8), ylim = c(1, 7))
points(var1, var3, pch = 15, col = "red")
legend("bottomright", c("var2", "var3"), pch = 15, col = c("blue", 'red'), bg = "gray", box.col="grey", cex=2)

# Finalement, avec une legende ecrite horizontalement
plot(var1, var2, pch = 15, col = "blue", xlim = c(4, 8), ylim = c(1, 7))
points(var1, var3, pch = 15, col = "red")
legend("top", legend = c("var2", "var3"), pch = 15, col = c("blue", 'red'), horiz = T, bg = "white")


# Plus d'exemples avec :
example(legend)

# Mon point de vue sur cette fonction est le suivant (N.C) : la fonction 'legend'
# n'est pas tres malleable. Disons plutôt qu'elle est non-intuitive a utiliser.
# De plus, certains parametres ne peuvent etre modifies (comme la fonte de
# caracteres). J'ai donc tendance a preferer le combo text-points-rect pour
# creer mes legendes. Bien sur c'est plus long a ecrire, mais le resultat en
# vaut souvent la peine...




###                                                                          ###
###                                             2.10. Ajout d'axes et de box ###
###                                                                          ###

# Pour terminer, regardons comment ajouter des axes a un graphe. Dans un premier
# temps, nous allons faire un plot vide et creer nous meme les axes. Nous
# utiliserons la fonction 'axis'.
plot0(xlim = c(-2, 2), ylim = c(-2, 2), main = "Plot avec axes retravailles")

# Ajoutons l'axe des x
axis(side = 1, at = seq(-2, 2, by = 0.5), labels = seq(-2, 2, by = 0.5), pos = 0)

# L'argument 'side' determine quel axe ajouter (voir l'argument du meme nom dans
# 'mtext'). L'argument 'at' determine les coordonnees de la graduation et 'labels'
# les etiquettes de la graduation. Enfin, 'pos' indique le positionnement de l'axe
# sur l'axe des y.

# Ajoutons l'axe des y
axis(side = 2, at = seq(-2, 2, by = 0.5), labels = seq(-2, 2, by = 0.5), pos = -2, las = 2)

# Par soucis de precision, forcons les etiquettes a avoir une decimale
par(mfrow = c(1, 2))
plot0(xlim = c(-2, 2), ylim = c(-2, 2), main = "Plot retravaille")
axis(side = 1, at = seq(-2, 2, by = 0.5), labels = format(seq(-2, 2, by = 0.5)), pos = -2)
axis(side = 2, at = seq(-2, 2, by = 0.5), labels = format(seq(-2, 2, by = 0.5)), pos = -2, las = 2)

# Nous pouvons aussi ajouter une graduation intermediaire
axis(side = 1, at = seq(-1.75, 1.75, by = 0.5), labels = F, pos = -2, tck = 0.02, lwd = 0, lwd.ticks = 1)
axis(side = 2, at = seq(-1.75, 1.75, by = 0.5), labels = F, pos = -2, tck = -0.01, lwd = -2, lwd.ticks = 1)

# Ajoutons maintenant des noms aux axes
mtext(side = 1, line = 1.5, text = "Axe des x", font = 2)
mtext(side = 2, line = 2.5, text = "Axe des y", font = 2, las = 0)

# Ajoutons des points
ptsx <- sample(seq(-1.9, 1.9, by = 0.01), 100)
ptsy <- sample(seq(-1.9, 1.9, by = 0.01), 100)
points(x = ptsx, y = ptsy, pch = 15)

# Comparons avec le graphe par defaut
plot(ptsx, ptsy, main = "Plot par defaut")


## Ajoutons une box
par(mfrow=c(2,3))
plot0(0,0)
box(col=1, bty="l")
plot0(0,0)
box(col=1, bty="o", col=2)
plot0(0,0)
box(col=1, bty="7", col=3, lwd=2)
plot0(0,0)
box(col=1, bty="u", lwd=4)
plot0(0,0)
box(col=1, bty="c", lwd=4, col=4)
plot0(0,0)
box(col=1, bty="]", lwd=4)

###                                                                          ###
###                                                  2.11. Ajout d'une image ###
###                                                                          ###

## IL peut etre fort interessant de pouvoir mettre une image quelconque sur vos
## graphiques. Sur une carte, cela permet notamment d'inclure des symboles pour y
## figurer certains elements (e.g. parking, parc naturels...)
## Nous pouvons egalement inclure un graphique dans un autre, nous en
## parlerons lors de la deuxieme seance.

## les lignes ci-dessous sont donnees dans l'exemple de la fonction "rasterImage"
plot(c(100, 250), c(300, 450), type = "n", xlab = "", ylab = "")
image <- as.raster(matrix(0:1, ncol = 5, nrow = 3))
rasterImage(image, 150, 325, 250, 400, angle = 15, interpolate = FALSE)

## Pour donner toute sa pertinence a cette fonction, il est necessaire de presenter
## comment il est possible d'ouvrir une image avec R. Vous avez pour cela 2 packages
## "jpeg" et "png". Pour installer ces packages, il suffit d'entrer :

install.packages(c("png","jpeg"), repos="http://cran.univ-lyon1.fr/")

## Pour les charger :
require("jpeg")

## telechargeons une image.
download.file("http://kevincazelles.fr/material/assets/photo1.jpg", "photo1.jpg")

## Il suffit d'utiliser la fonction 'readPNG' et d'utiliser l'argument 'native' avec la
## valeur 'TRUE' pour avoir un objet directement utilisable par 'rasterImage'.
sloc <-readJPEG("./photo1.jpg", native=TRUE)

plot(0:8,0:8, type="n")
for (i in 0:5){
    ptloc <- locator(1)
    rasterImage(sloc,ptloc$x,ptloc$y,ptloc$x+1,ptloc$y+1.4, angle=i*60)
}
## Remarque 1 : si votre image est en jpeg, la fonction est 'readJPEG'
## Remarque 2 : ces deux formats sont suffisants dans de nombreux cas des lors que vous
## maîtriser un outil puissant de conversion entre les formats du type Image Magick
## browseURL("http://www.imagemagick.org/")
## Remarque 3 : une petite adresse pour trouver des images utiles pour vos graphiques
## browseURL("http://www.flaticon.com/most-downloaded/")

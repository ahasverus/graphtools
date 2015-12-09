################################################################################
#######                                                                  #######
#######                      LES GRAPHIQUES SOUS R                       #######
#######                    -------------------------                     #######
#######                 Kevin Cazelles, Nicolas Casajus                  #######
#######                      - 20 Novembre 2014 -                        #######
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
#####   2.9.  sAjout d'une legende
#####   2.10. Ajout d'axes et de box
#####   2.11. Ajout d'une image
#####
##### EXERCICES
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

# Ce qui suit n'est pas une introduction à R. C'est simplement une brève
# introduction aux graphiques sous R avec des suggestions de bonnes pratiques
# qui sont seulement le reflet de l'experience de la pratique de R des auteurs.
#
# Pour l'utilisateur totalement débutant, nous recommendons la lecture des deux
# documents suivants (ressources en français) :
#
#   - L'introduction à R redigée par Emmanuel Paradis
#     (les pages 1 à 35 sont suffisantes pour la suite)
browseURL("http://cran.r-project.org/doc/contrib/Paradis-rdebuts_fr.pdf")

#   - L'introduction à R sur le site internet "OpenClassRoom"
#     (les 11 points qui y sont developpés sont pertinents)
browseURL("http://fr.openclassrooms.com/informatique/cours/effectuez-vos-etudes-statistiques-avec-r/introduction-a-r")

# La maitrise d'un langage informatique de haut niveau comme R, au sens où il
# "fait abstraction des caractéristiques techniques du matériel utilisé"
# - Wikipedia - repose sur la connaissance d'un certain nombre de fonctions.
# C'est précisemment ces dernières que nous allons utiliser, chacune disposant
# d'une aide accessible en utilisant le symbole "?". Par ex:
?plot
?plot.default

# A la fin de la description vous avez généralement des exemples.
# Au lieu de les recopier vous pouvez demander à les exécuter avec la fonction 'example'
example(plot)

# Il se peut aussi que vous ayez des vignettes c'est à dire des exemples plus détaillés
# souvent en pdf
vignette(package="graphics")
vignette(package="grid")
vignette("moveline")

# Des démonstrations sont parfois disponibles :
demo(Hershey)

# Une recherche par mot clef est possible avec le "??". Attention, le temps de
# recherche peut-être plus ou moins long...
??student

# Aussi les packages possèdent tous une liste exhaustive des méthodes et fonctions qu'ils
# développent.
library(help = "base")

# NB : "base" est l'un des ensembles de méthodes et fonctions fondamentales de R.
# Pour la formation qui suit :
library(help = "graphics")

# est plus judicieux.
# NB : l'ensemble des packages peut-être visualisé avec :
search()

# On peut voir les fonctions sous forme de liste avec la commande suivante :
ls(envir = as.environment("package:graphics"))

# Vous pourrez ainsi rapidement identifier les fonctions traitées en-dessous ou non.

# La fonction "apropos" vous permet de retrouver des fonctions par "pattern". Si
# vous vous rappeler le nom d'une fonction mais pas son orthographe exact, "apropos"
# vous facilitera la recherche.
apropos("read")

# Remarque : on peut utiliser des expressions régulières pour une recherche plus
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

# Le package 'graphics' fait partie des packages de base, qui n'a besoin d’être
# ni téléchargé en complément de R, ni chargé a l'ouverture de R.
# Il se charge par défaut automatiquement.

# La philosophie des graphiques avec le package 'graphics' est simple et
# puissante : n'importe quel graphique peut-être créé sans avoir recours a des
# packages complémentaires (e.g. ggplot2, lattice, etc...). Cependant, cela a un
# coût : on peut tout faire, certes, mais avec un certain nombre de lignes,
# parfois important, nous le concédons volontiers...

# Mais, selon nous, il est important de commencer par le commencement, et de
# maîtriser les différents éléments qui composent un graphique. Une fois cette
# maîtrise acquise, vous pourrez laisser libre cours a votre imagination et à
# votre inspiration pour améliorer le rendu visuel de vos graphiques.

# Regardons rapidement les fonctions disponibles dans ce package, dont la plupart
# seront abordées ici.
library(help = "graphics")
# Une façon un peu plus sophistiquée d'obtenir la liste des fonctions d'un package :
ls(envir=as.environment("package:graphics"))



###                                                                          ###
###                                               [.] Mon 'Hello world' plot ###
###                                                                          ###

# Puisqu'un dessin vaut mieux qu'un long discours, réalisons notre premier graphique :
plot(1)

# Que s'est-il passé ?
# Une fenêtre graphique, aussi appelée périphérique graphique (ou 'device' en
# anglais) s'est d'abord ouverte. Puis, elle a été récupérée les valeurs par
# défaut des paramètres graphiques de R. Enfin, dans la zone de plot, elle a
# affiche l'objet que nous voulions représenter (ici, la valeur 1).

# Nous développerons plus loin la notion de périphérique graphique. Mais, glissons
# rapidement quelques mots sur les paramètres graphiques. Leurs valeurs par défaut
# sont stockées dans la liste 'par', accessible comme suit :
par()
# Remarque : si aucune fenêtre n'est ouverte, une fenêtre vide est ouverte.

# Ainsi, en récupérant ces valeurs, R a automatiquement déterminé les axes, la
# police, les couleurs, les marges, le symbole, etc. Toutes ces informations sont
# modifiables, et heureusement, car le rendu laisse un peu à désirer... Nous
# verrons plus loin comment modifier certains de ces paramètres.



################################################################################
#####
##### 1. LES GRAPHES DE BASE
#####

# Regardons tout d'abord quelques fonctions permettant de réaliser des graphiques
# souvent utilisés en science. Dans R, on réalise de tels figures avec des 'High-level
# plotting functions', c.-a.d. que leur appel (exécution) ouvrira automatiquement
# une nouvelle fenêtre graphique. On les opposera aux 'Low-level functions' qui
# elles, permettront d'ajouter des éléments a un graphique pré-existant. C'est
# l'objet du chapitre suivant.



###                                                                          ###
###                               1.1. Diagramme de dispersion (scatterplot) ###
###                                                                          ###

# Il s'agit d'un graphe classique permettant de représenter deux variables
# continues l'une en fonction de l'autre dans un nuage de points.
# Nous allons réutiliser la fonction plot.

# Créons une variable contenant une série de valeurs de 1 à 20
(var1 <- seq(from = 1, to = 20, by = 1))
# Remarque : Les parenthèses permettent d'afficher le résultat dans la console
# bien que nous ayons assigné le résultat à une variable.

# Et une seconde variable avec 20 valeurs tirées aléatoirement selon une
# distribution normale de moyenne 0 et d’écart-type 1.
(var2 <- rnorm(n = 20, mean = 0, sd = 1))

# Faisons le scatterplot
plot(x = var1, y = var2)

# Nous aurions aussi pu écrire
plot(var2 ~ var1)

# Anticipons légèrement sur les chapitres suivants et intéresserons nous à
# l'argument 'type' de la fonction plot. Ce dernier nous permet de représenter de changer
# l'aspect du graphique.

# Afin de bien comprendre les différences, partitionnons la fenêtre graphique en
# neuf régions (trois lignes et trois colonnes) chacune destinée à recevoir un
# plot. Nous allons donc modifier le paramètre graphique 'mfrow' de la fonction
# par().
par(mfrow = c(3, 3))

# Représentons les graphs 1 à 1.
plot(var1, var2, type = "p", main = "Type = p") # Par défaut
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
###                                                   1.2. Boite à moustache ###
###                                                                          ###

# La boite à moustaches est une représentation graphique très utile en
# statistiques, puisqu'elle permet de résumer les caractéristiques de position
# (médiane, 1er et 3ème quartiles, minimum et maximum) d'une variable
# quantitative.
# Sous R, la fonction utilisée sera "boxplot".
par(mfrow = c(2, 3))
boxplot(var1)
boxplot(var2)

# Nous pouvons aussi comparer la distribution de deux (ou plusieurs) variables
# en même temps.
boxplot(var1, var2, col = c("red", "blue"))

# Remarque : l'argument 'col' permet d'ajouter de la couleur à chaque boxplot.
# Nous y reviendrons plus tard, mais cet argument s'applique à plusieurs
# fonctions, comme plot().

# Cette fonction s'applique sur des vecteurs, mais aussi sur des dataframes.
# Regardons cela.
tab1 <- data.frame(var1, var2)
boxplot(tab1, col = c(2, 4))

# Remarque : il y a une correspondance pratique pour gagner du temps :
# 1=noir ; 2=rouge ; 3=vert ; 4=bleu ; 5=bleu clair ; 6=violet ; 7=jaune ; 8=gris.

# Rien ne change, si ce n'est le nom de chaque boite.
# D'autres arguments sont modifiables. Nous vous laissons vous référer a l'aide
# de cette fonction (?boxplot). Par ex. l'argument 'horizontal' permet de tracer
# les boites à l'horizontale.
boxplot(tab1, col = c("red", "blue"), horizontal = T)



###                                                                          ###
###                                                 1.3. Diagramme en bâtons ###
###                                                                          ###

# Ce type de représentation est utile pour visualiser des données discrètes ou
# catégoriques. Chaque modalité de la variable catégorique (ou discrète) sera
# représentée par une barre dont la longueur sera proportionnelle à son effectif
# (relatif ou absolu) parmi l'ensemble des modalités.
# Sous R, c'est la fonction barplot().

# Créons tout d'abord un vecteur contenant six modalites.
nom <- c("Vert", "Jaune", "Rouge", "Blanc", "Bleu", "Noir")

# Maintenant, nous allons tirer aléatoirement 1000 fois (avec remise) dans ce
# vecteur.
echn <- sample(x = nom, size = 1000, replace = T)

# Comptons maintenant combien de fois se retrouve chaque modalité.
(var4 <- table(echn))

# Représentons cette variable sous forme d'un barplot.
par(mfrow = c(2, 2))
barplot(var4)

# De la même manière, nous pouvons représenter les valeurs relatives.
# Transformons cette variable en fréquences.
var5 <- var4/sum(var4)
barplot(var5)

# Et à l'horizontale avec des couleurs différentes
barplot(var4, horiz = T)

# Et avec des barres hachurées
barplot(var4, density = c(20, 20, 20, 20, 40, 60), angle = c(0, 45, 90, 135), col=c(1,1,1,2))

# Remarque : l'argument 'density' représente le nombre de hachures par pouce et
# l'argument 'angle' donne leur orientation.



###                                                                          ###
###                                                         1.4. Histogramme ###
###                                                                          ###

# L'histogramme permet de visualiser la répartition des valeurs d'une variable
# continue en catégorisant ses valeurs. Il est très utile pour connaître la loi
# de distribution que suivent les valeurs (loi normale, loi de Poisson, etc.).
# Sous R, ce graph se fera a l'aide de la fonction "hist()".

# Générons 1000 valeurs aléatoires selon une loi gaussienne (centrée réduite).
(var6 <- rnorm(n = 1000))

# Tracons la distribution de ces valeurs
par(mfrow = c(2, 2))
hist(var6)

# Modifions les classes avec
hist(var6, breaks = seq(from = -4, to = 4,by = 0.25))

# Ajoutons de la couleur
hist(var6, col = "red")

# Et hachurons
hist(var6, density = 20, angle = 45)



###                                                                          ###
###                                                 1.5. Diagramme sectoriel ###
###                                                                          ###

# Une alternative au diagramme en bâtons est le diagramme sectoriel (camembert).
# Regardons ce que ça donne avec les données précédentes (couleurs).

# Diagramme sectoriel
pie(var4)

# Modifions les couleurs
pie(var4, col = c("white", "blue", "yellow", "black", "red", "green"))

# Taper '?pie' pour connaître l'ensemble des arguments de cette fonction.

# En bonus, un bel arc-en-ciel
ncol=250
pie(rep(1, ncol), col = rainbow(250), border = NA, labels = "")

# En plus, un arc-en-ciel rotatif...
### run
for (i in 1 : ncol){
	if (i > 1){
		pie(rep(1, ncol), col = rainbow(ncol)[c(i:ncol, 1:(i-1))], border = NA, labels = "")
	}else
		pie(rep(1, ncol), col = rainbow(ncol), border = NA, labels = "")
}
### end run

# Enfin, sur le dernier diagramme, vous pouvez choisir 4 couleurs pour connaître
# le code associé aux quatre couleurs.
quartz()
par(mfrow=c(2,2))
for (i in (1:4)){
    dev.set(dev.prev())
    xy <- locator(1, type="o", pch=4)
    dev.set(dev.next())
    sz <- sqrt(xy$x^2+xy$y^2)
    theta <- (xy$y<0)*(2*pi-acos(xy$x/sz)) + (xy$y>=0)*acos(xy$x/sz)
    print(theta)
    selcol <- floor(ncol*theta/(2*pi)+1)
    par(mar=c(1,1,1,1))
    image(matrix(1),col=rainbow(ncol)[selcol], axes=FALSE)
    text(0,0,rainbow(ncol)[selcol], cex=2)
}



###                                                                          ###
###                                                    1.6. Fonction image() ###
###                                                                          ###

B <- matrix(1:100, ncol = 10)
image(B, col = rainbow(100), border = "")

## Je reprends un exemple que vous pouvez trouver dans l'aide.
## 'volcano' est un jeu de données déjà prêt :
volcano
data()
x <- 10*(1:nrow(volcano))
y <- 10*(1:ncol(volcano))
image(x, y, volcano, col = terrain.colors(100), axes = FALSE)
contour(x, y, volcano, levels = seq(90, 200, by = 5), add = TRUE, col = "#441100")
##
example(image)

###                                                                          ###
###                                           1.7. Fonction trigonométriques ###
###                                                                          ###

## Les fonctions trigo dans toute leur splendeur !
## Cette partie sert simplement à vous rappeler qu'un soupçon de maths (qui datent
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

# Regardons maintenant comment éditer un graphique. En d'autres termes, nous allons
# ajouter des éléments à un graphique existant, éléments qui peuvent des points, des lignes,
# des symboles, du texte ou encore une légende. L'appel aux fonctions précédentes
# avait pour conséquence d'ouvrir un nouveau périphérique graphique. Ici, nous
# allons utiliser des 'Low-level plotting functions', qui n'ouvriront pas de
# nouveau périphérique graphique mais utiliseront celui qui est déjà ouvert
# (actif) pour l’éditer.
# Condition requise :  un périphérique graphique doit être préalablement ouvert
# avec d'utiliser de telles fonctions.



###                                                                          ###
###                                                          2.1. Empty plot ###
###                                                                          ###

# La philosophie des auteurs en termes de graphiques sous R est simple :
# ajouter les éléments un à un, en commençant par ouvrir une fenêtre graphique
# avec des dimensions (axes et marges) de leur choix mais sans que rien ne
# s'affiche à l’écran. Regardons donc comment créer un graph vide ?

# Commençons par le commencement
plot(var1, var2)

# Ici, les axes sont déterminés automatiquement par R en fonction de la gamme
# de valeurs de nos deux variables.
# Modifions l’étendue des axes avec les arguments 'xlim' et 'ylim'.
plot(var1, var2, xlim = c(-10, 30), ylim = c(-3, 4))

# Maintenant, nous ne voulons pas afficher les points. Nous pouvons utiliser
# l'argument 'type' de la fonction plot
plot(var1, var2, xlim = c(-10, 30), ylim = c(-3, 4), type = "n")

# Simplifions l'écriture vu qu'on fixe les limites des axes.
plot(0, xlim = c(-10, 30), ylim = c(-3, 4), type = "n")

# Supprimons les axes avec les arguments 'xaxt' et 'yaxt'
par(mfrow=c(1,3))
plot(0, xlim = c(-10, 30), ylim = c(-3, 4), type = "n", xaxt = "n")
plot(0, xlim = c(-10, 30), ylim = c(-3, 4), type = "n", yaxt = "n")
plot(0, xlim = c(-10, 30), ylim = c(-3, 4), type = "n", xaxt = "n", yaxt = "n")

# Les axes ont bel et bien été supprimés, il reste cependant une
# boite (box). Celle-ci délimite la zone de plot dans notre périphérique
# graphique. Il ne sera possible d'ajouter des éléments que dans cette zone
# (avec quelques exceptions cependant)

# Pour supprimer cette boite, utilisons l'argument 'bty'.
plot(0, xlim = c(-10, 30), ylim = c(-3, 4), type = "n", xaxt = "n", yaxt = "n", bty = "n")

# L'utilisation des arguments 'xaxt', 'yaxt' et 'bty' pour etre replacee par
# l'argument 'axes' qui aura le meme effet que precedemment s'il est FALSE.
plot(0, xlim = c(-10, 30), ylim = c(-3, 4), type = "n", axes = F)

# Finalement, supprimons l'étiquette des axes, seul element restant.
plot(0, xlim = c(-10, 30), ylim = c(-3, 4), type = "n", axes = F, xlab = "", ylab = "")

# Et voila ! Un graph vide avec des dimensions specifiées.
# Notre ami Kevin a eu la très bonne idée de créer une fonction pour cela.
plot0 <- function(x = c(-10,10), y = c(-10,10), type = "n", ...){
    plot(x, y, type=type, axes = FALSE, xlab ="", ylab = "", ...)
}
# Remarque : avec "..." nous permettons à l'utilisateur d'ajouter des arguments de la fonctions plot.
#            Dans notre exemple, les arguments non-explicité dans la liste des arguments de plot0
#            peuvent être ajoutés.


# Ainsi, si nous souhaitons ouvrir un graph vide,
plot0()
plot0(xlim = c(-10, 30), ylim = c(-3, 4))



###                                                                          ###
###                                                     2.2. Ajout de points ###
###                                                                          ###

# Pour insérer des points sur un graphe, rien de plus simple : il suffit
# d'utiliser la fonction 'points'. Celle-ci possède un très grand nombre
# d'arguments en commun avec la fonction 'plot'.

# Créons trois nouvelles variables quantitatives
var1 <- seq(1, 20)
var2 <- sample(var1, 20, replace = F)
var3 <- sample(var1, 20, replace = F)

# Traçons tout d'abord var2 en fonction de var1
plot(var1, var2)

# Et rajoutons var3 en fonction de var1 avec un couleur différente
points(var1, var3, col = "red")

# Modifions la representation des points avec l'argument 'pch'.
plot(var1, var2, pch = 19)
points(var1, var3, pch = 15)

# Modifions la taille des symboles avec l'argument 'cex'.
plot(var1, var2, cex = 1) # par défaut
points(var1, var3, cex = 2)

# Mais, attention a l’étendue des axes du graphe à éditer : les points a rajouter
# doivent avoir le même range de valeurs que ceux-ci. Sinon, il faudra modifier
# l'entendue des axes dans la fonction plot avec 'xlim' et 'ylim'.

# Introduisons maintenant une commande intéressante sous R : la fonction locator().
# Celle-ci permet de récupérer les coordonnées d'un (ou plusieurs clics) sur un
# graph.

plot(var1, var2, pch = 15, col = "red")
(loc1 <- locator(n = 2))

# Mais, cette fonction permet également de rajouter simultanément ces points sur
# le graphe.
loc2 <- locator(n = 3, type = "p", pch=15, col="blue")

# En association avec la fonction 'points'.
points(locator(4), pch = 19, col = "green", cex=2.5)



###                                                                          ###
###                                                     2.3. Ajout de lignes ###
###                                                                          ###

# Plusieurs fonctions permettent de tracer une ligne sous R. Tout dépend de
# l'information de départ. Si on dispose des coordonnées des deux points
# extrêmes, nous pouvons utiliser la fonction 'point'.

plot(var1, var2, pch = 15)
points(x = c(1, 20), y = c(1, 20), type = "l")

# Modifions le type de ligne.
plot(var1, var2, pch = 15)
points(x = c(1, 20), y = c(1, 20), type = "l", lty = 3)

# La fonction 'lines' s'utilisera de la même manière que 'points'.
plot(var1, var2, pch = 15)
lines(x = c(1, 20), y = c(1, 20))

# La fonction 'abline' permettra de tracer des lignes horizontales, verticales et
# des droites de regression a partir des coefficients estimes.
plot(var1, var2, pch = 15, type = "b")
abline(h = 10, col = "blue")
abline(v = 10, col = "blue")

abline(a=20, b=-1, col = "green", lwd=2)
abline(reg = lm(var2 ~ var1), col = "red", lwd=2)

# Rajoutons la droite var2=var1.
lines(x = c(1, 20), y = c(1, 20), lty = 3)

# Enfin, la fonction segment permet de relier deux points entre eux.
plot(var1, var2, pch = 15)
segments(x0 = var1[1], y0 = var2[1], x1 = var1[2], y1 = var2[2])

# Créons deux autres segments
segments(var1[1], var2[1], var1[20], var2[20])
segments(var1[20], var2[20], var1[2], var2[2])

# Tracons une droite en cliquant
locator(n = 2, type = "l", col = "blue", lty = 3)
lines(locator(4), col=2)
loc3 <- locator(4, type="o", col=3)

# Remarque : à la différence de 'points', 'lines' et 'segments', la fonction
# 'abline' n'est pas bornée aux extrémités : son tracé commencera et se
# terminera aux marges de la région du plot.



###                                                                          ###
###                                                  2.4. Ajout de polygones ###
###                                                                          ###

# Insérer une forme polygonale sur un graphe se fera a l'aide de la fonction
# 'polygon'.
plot(var1, var2, pch = 15)
polygon(x = c(10, 5, 5, 10, 15, 15), y = c(5, 10, 15, 20, 15, 10))
polygon(x = c(10, 5, 15), y = c(5, 15, 15), density = 20, angle = 45)
polygon(x = c(5, 10, 15), y = c(10, 20, 10), density = 20, angle = 135)

# Nous retrouvons ici des arguments vu précédemment dans d'autres fonctions.
# Voyons un exemple en couleurs.

# Créons trois nouvelles variables
seqX <- seq(-20, 20, 0.01)
GaussA <- dnorm(seqX, mean = -2, sd = 4)
GaussB <- dnorm(seqX, mean = 4, sd = 4)

# Tracons ces distributions
plot(range(seqX), range(GaussA), type = "n")
polygon(x = seqX, y = GaussA, border = 0, col = "#FF000088")
polygon(x = seqX, y = GaussB, border = 0, col = "#0000FF88")

# Remarque : Ici, nous venons d'attribuer deux couleurs dans un format un peu
# spécial. Il s'agit du format hexadécimal, après le dièse, les 2 premiers symboles
# reflètent la quantité de rouge, les 2 suivants celle de vert, puis 2 autres pour le bleu
# et enfin les 2 derniers symboles représentent la transparence.
# Rappel : hexadécimal signifie que la notation d'une quantité se fait à l'aide de
# 16 symboles (en général les chiffres de 0 à 9 et les lettres de A à F),

# Voyons maintenant un cas particulier de polygone : le rectangle. Celui-ci
# s'obtient avec la fonction 'rect'.
plot(var1, var2, pch = 15)
rect(xleft = 5, ybottom = 5, xright = 15, ytop = 15, col = "gray")
points(var1, var2, pch = 15)
rect(xleft = 5, ybottom = 5, xright = 15, ytop = 15, density = 20, angle = 45)

# Et en incluant la fonction 'locator', nous pouvons dessiner un polygon à la main.
polygon(locator(5), col = "#0000FF88", border = 0)
# Pour suivre les traits que vous dessinez
polygon(locator(5, type="l", col=4), col = "#0000FF88", border = 0)



###                                                                          ###
###                                                  2.5. Ajout d'une flèche ###
###                                                                          ###

# On peut aussi tracer des flèches avec la fonction 'arrows'. On peut spécifier
# si la flèche sera en début ou en fin de lignes (ou les deux) avec l'argument
# 'code'. Mais aussi la longueur de la flèche et son angle par rapport a la
# droite.
plot(c(0, 2), c(0, 2), type = "n")
arrows(x0 = 0, y0 = 0, x1 = 0, y1 = 2, length = 0.25, angle = 30, code = 1)
arrows(x0 = 2, y0 = 0, x1 = 2, y1 = 2, length = 0.25, angle = 30, code = 2)
arrows(x0 = 0, y0 = 2, x1 = 2, y1 = 0, length = 0.75, angle = 10, code = 3, lwd=2, col=2)



###                                                                          ###
###                                                   2.6. Ajout de symboles ###
###                                                                          ###

## Cette fonction permet simplement de rajouter des cercles, des carrées,
## des rectangles, des étoiles, des thermomètres et des boxplots.

# Commençons par un cercle. Avec cette fonction, nous donnons les coordonnées des centres
# ainsi qu'un vecteur de rayons associés à ces centres :
plot(var1,var2)
symbols(x=c(5,4), y=c(15,12), circles=c(1,2))
# Remarque : vous devez spécifier un type de symbole.
# Nous avons bien obtenu nos cercles. Cependant, nous avons supprimé la figure précédente.
# Nous pouvons empêcher cela en utilisant le paramètre 'add'. Nus ajoutons également
# 1- l'utilisation de 'locator' et 2- la couleurs grâce aux paramètres fg (couleur du bord du cercle)
# et bg (remplissage).
plot(var1,var2)
symbols(locator(2), circles=c(1,2), add=TRUE, bg=c("#FF000088","#0000FF88") , fg=2)

# En utilisant le même principe, nous pouvons faire le carrée, le vecteur de rayon
# devient un vecteur de la taille du côté
symbols(locator(2), square=c(1,2), add=TRUE, bg=c("#FF000088","#0000FF88") , fg=2)

# Et de même, nous pouvons utiliser les autres symboles proposés en regardant bien les
# paramètres à spécifier pour chacun
plot(var1,var2, type="n")
symbols(locator(3), rectangles=matrix(2*runif(6),3), add=TRUE, bg=4 ,fg=2)
symbols(locator(2), stars=matrix(c(rep(1,7),runif(7)),2,byrow=TRUE), add=TRUE, bg=4 ,fg=2)
symbols(locator(1), thermometers=matrix(c(1,6,0.75),1), add=TRUE, bg="white" ,fg=2)
symbols(locator(1), boxplot=matrix(c(1,6,2,4,0.85),1), add=TRUE, bg=4 ,fg=2)


###                                                                          ###
###                                                    2.7. Ajout d'un titre ###
###                                                                          ###

# Nous avons déjà vu précédemment comment définir un titre directement dans la
# fonction 'plot'. Pour rappel.
plot(var1, var2, pch = 15, main = "var2 en fonction de var1")

# Mais, nous pouvons également utiliser la fonction 'title' qui aura le même
# effet.
plot(var1, var2, pch = 15)
title(main = "var2 en fonction de var1")

# Nous pouvons aussi insérer un sous-titre si besoin est.
title(sub = "Scatterplot", col.sub = "red", cex.sub = 0.75)

# Remarque : l'argument 'sub' est aussi disponible dans la fonction plot.
# L'argument 'cex.sub' permet de modifier la taille du sous-titre.
# Nous développerons ce point plus loin dans le chapitre 3.



###                                                                          ###
###                                                      2.8. Ajout de texte ###
###                                                                          ###

# Regardons maintenant comment insérer du texte dans la zone de plot. La fonction
# à utiliser est la fonction 'text' (quand on vous dit que R est un langage
# intuitif...).

# Créons un vecteur de 20 lettres
(nom <- letters[1 : length(var1)])

# Plutôt que de représenter des points, affichons ces lettres aux coordonnées
# (var1, var2).
par(mfrow = c(1, 2))
plot(var1, var2, pch = 15)
plot(var1, var2, type = "n")
text(x = var1, y = var2, labels = nom)

# Peut-on ajouter les deux informations sur le même. A votre avis ?
plot(var1, var2, pch = 15)
text(x = var1, y = var2, labels = nom)

# Problème majeur : les deux informations se superposent. Heureusement, la
# fonction 'text' est muni d'un argument permettant de position les étiquettes
# par rapport aux coordonnées avec l'argument 'pos'.
# Plaçons-les a gauche.
plot(var1, var2, pch = 15)
text(x = var1, y = var2, labels = nom, pos = 2)

# Ajoutons du texte en cliquant
text(locator(2), c("txt1", "txt2"), col = "red")

# Maintenant, essayons de cliquer en dehors de la zone de plot (dans les marges).
text(locator(1), "txt3", col = "blue")

# Rien ne s'affiche. C'est normal : la fonction 'text' ne permet d'afficher du texte
# qu'a l’intérieur de la région du plot.

# Pour ajouter du texte dans les marges (par ex. pour ajouter le nom d'un axe), on
# préférera la fonction 'mtext' (m pour marge, hein).

# Cette fonction s’écrit différemment cependant : l'argument 'side' indique dans
# quelle marge doit être a afficher le texte (1 en bas, 2 gauche, 3 haut, 4 droite).
# L'argument 'line' permet quant a lui de positionner le texte par rapport a l'axe
# en question.

plot(var1, var2, pch = 15)
mtext(side = 1, line = 1, text = "mtext - line = 1")
mtext(side = 1, line = 2, text = "mtext - line = 2")
mtext(side = 1, line = 3, text = "mtext - line = 3")
mtext(side = 1, line = 4, text = "mtext - line = 4")
mtext(side = 1, line = 3, text = "mtext - line = 3", at = 5)

# Vu qu'on ne fournit pas de coordonnées dans cette fonction, la fonction 'locator'
# ne fonctionnera pas.



###                                                                          ###
###                                                 2.9. Ajout d'une légende ###
###                                                                          ###

# La fonction 'legend' présente de nombreux arguments. Nous vous laissons les
# découvrir par vous-même. Regardons plutôt quelques exemples d'utilisation.


# Un premier exemple.
plot(var1, var2, pch = 15, col = "blue")
points(var1, var3, pch = 15, col = "red")
legend("topleft", legend = c("var2", "var3"), pch = 15, col = c("blue", 'red'))

# Un second en cliquant.
plot(var1, var2, pch = 15, col = "blue")
points(var1, var3, pch = 15, col = "red")
legend(locator(1), legend = c("var2", "var3"), pch = 15, col = c("blue", 'red'))

# Avec des lignes au lieu de points et sans cadre
plot(var1, var2, type = "l", col = "blue")
points(var1, var3, type = "l", col = "red")
legend(x = 15, y = 20, legend = c("var2", "var3"), lwd = 2, col = c("blue", 'red'), bty="n")

# Et sans mais avec un fond gris.
plot(var1, var2, pch = 15, col = "blue")
points(var1, var3, pch = 15, col = "red")
legend("bottomright", c("var2", "var3"), pch = 15, col = c("blue", 'red'), bg = "gray", box.col="grey", cex=2)

# Finalement, avec une legende ecrite horizontalement
plot(var1, var2, pch = 15, col = "blue")
points(var1, var3, pch = 15, col = "red")
legend("top", legend = c("var2", "var3"), pch = 15, col = c("blue", 'red'), horiz = T, bg = "white")


# Plus d'exemples avec :
example(legend)

# Mon point de vue sur cette fonction est le suivant (N.C) : la fonction 'legend'
# n'est pas très malléable. Disons plutôt qu'elle est non-intuitive à utiliser.
# De plus, certains paramètres ne peuvent être modifiés (comme la fonte de
# caractères). J'ai donc tendance a préférer le combo text-points-rect pour
# créer mes légendes. Bien sur c'est plus long à écrire, mais le résultat en
# vaut souvent la peine...




###                                                                          ###
###                                             2.10. Ajout d'axes et de box ###
###                                                                          ###

# Pour terminer, regardons comment ajouter des axes à un graphe. Dans un premier
# temps, nous allons faire un plot vide et créer nous même les axes. Nous
# utiliserons la fonction 'axis'.
plot0(xlim = c(-2, 2), ylim = c(-2, 2), main = "Plot avec axes retravaillés")

# Ajoutons l'axe des x
axis(side = 1, at = seq(-2, 2, by = 0.5), labels = seq(-2, 2, by = 0.5), pos = 0)

# L'argument 'side' détermine quel axe ajouter (voir l'argument du même nom dans
# 'mtext'). L'argument 'at' détermine les coordonnées de la graduation et 'labels'
# les étiquettes de la graduation. Enfin, 'pos' indique le positionnement de l'axe
# sur l'axe des y.

# Ajoutons l'axe des y
axis(side = 2, at = seq(-2, 2, by = 0.5), labels = seq(-2, 2, by = 0.5), pos = -2, las = 2)

# Par soucis de précision, forçons les étiquettes à avoir une décimale
par(mfrow = c(1, 2))
plot0(xlim = c(-2, 2), ylim = c(-2, 2), main = "Plot retravaillé")
axis(side = 1, at = seq(-2, 2, by = 0.5), labels = format(seq(-2, 2, by = 0.5)), pos = -2)
axis(side = 2, at = seq(-2, 2, by = 0.5), labels = format(seq(-2, 2, by = 0.5)), pos = -2, las = 2)

# Nous pouvons aussi ajouter une graduation intermédiaire
axis(side = 1, at = seq(-1.75, 1.75, by = 0.5), labels = F, pos = -2, tck = -0.01, lwd = -2, lwd.ticks = 1)
axis(side = 2, at = seq(-1.75, 1.75, by = 0.5), labels = F, pos = -2, tck = -0.01, lwd = -2, lwd.ticks = 1)

# Ajoutons maintenant des noms aux axes
mtext(side = 1, line = 1.5, text = "Axe des x", font = 2)
mtext(side = 2, line = 2.5, text = "Axe des y", font = 2, las = 0)

# Ajoutons des points
ptsx <- sample(seq(-1.9, 1.9, by = 0.01), 100)
ptsy <- sample(seq(-1.9, 1.9, by = 0.01), 100)
points(x = ptsx, y = ptsy, pch = 15)

# Comparons avec le graphe par défaut
plot(ptsx, ptsy, main = "Plot par défaut")



###                                                                          ###
###                                                  2.11. Ajout d'une image ###
###                                                                          ###

## IL peut être fort intéressant de pouvoir mettre une image quelconque sur vos
## graphiques. Sur une carte, cela permet notamment d'inclure des symboles pour y
## figurer certains éléments (e.g. parking, parc naturels...)
## Nous pouvons également inclure un graphique dans un autre, nous en
## parlerons lors de la deuxième séance.

## les lignes ci-dessous sont données dans l'exemple de la fonction "rasterImage"
plot(c(100, 250), c(300, 450), type = "n", xlab = "", ylab = "")
image <- as.raster(matrix(0:1, ncol = 5, nrow = 3))
rasterImage(image, 150, 325, 250, 400, angle = 15, interpolate = FALSE)

## Pour donner toute sa pertinence à cette fonction, il est nécessaire de présenter
## comment il est possible d'ouvrir une image avec R. Vous avez pour cela 2 packages
## "jpeg" et "png". Pour installer ces packages, il suffit d'entrer :
install.packages(c("png","jpeg"), repos="http://cran.univ-lyon1.fr/")
## Pour les charger :
require("png")
require("jpeg")
## téléchargeons une image.
download.file("http://kevincazelles.fr/images/photo1.png", "photo1.png")
## Il suffit d'utiliser la fonction 'readPNG' et d'utiliser l'argument 'native' avec la
## valeur 'TRUE' pour avoir un objet directement utilisable par 'rasterImage'.
sloc <-readPNG("./photo1.png", native=TRUE)
plot(0:8,0:8, type="n")
for (i in 0:5){
    ptloc <- locator(1)
    rasterImage(sloc,ptloc$x,ptloc$y,ptloc$x+1,ptloc$y+1.4, angle=i*60)
}
## Remarque 1 : si votre image est en jpeg, la fonction est 'readJPEG'
## Remarque 2 : ces deux formats sont suffisants dans de nombreux cas dès lors que vous
## maîtriser un outil puissant de conversion entre les formats du type Image Magick
## browseURL("http://www.imagemagick.org/")
## Remarque 3 : une petite adresse pour trouver des images utiles pour vos graphiques
## browseURL("http://www.flaticon.com/most-downloaded/")


################################################################################
#####
##### EXERCICE 1
#####

# Essayer de reproduire la figure suivante aussi fidèlement que possible.
browseURL("http://kevincazelles.fr/images/sincosR.png")


##### EXERCICES BONUS DE LA SÉANCE 1 :

##### Fonction 'losanges'
## Coder une fonction "losanges" dans le style de la fonctions "symbols" -
# => Rappel : browseURL("http://fr.wikipedia.org/wiki/Losange")
# Cette fonction permettra de dessiner un losange autour d'un point A(x,y).
# les paramètres seront :
# 1- les coordonnées de son centre (les coordonnées de A) ;
# 2- les longueurs de ses diagonales (perpendiculaires!), ces deux
# paramètres suffisent pour dessiner un losange autour de A, à vous d'être
# astucieux pour rendre votre fonction facile d'utilisation et riche en
# fonctionnalités (e.g. ajouter de la couleur) sans vous ajoutez du travail
# 3- pour les plus habitués, ajoutez un paramètre de rotation !


#### Fonction 'pchimage'
## De même que vous pouvez utiliser plusieurs symboles grâce au paramètre
## 'pch' des fonctions graphiques 'par', plot' et 'points', il est possible
## de coder une fonction qui utiliserait 'rasterImage' pour prendre n'importe
## quelle image comme symbole. Pour rendre votre fonction très performante,
## nous vous conseillons d'utiliser les packages 'jpeg' et 'png'.



########################### FIN DE LA SÉANCE 1 !!  #############################

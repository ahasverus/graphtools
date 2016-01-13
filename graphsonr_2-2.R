################################################################################
#######                                                                  #######
#######                      LES GRAPHIQUES SOUS R                       #######
#######                    -------------------------                     #######
#######                 Kevin Cazelles, Nicolas Casajus                  #######
#######                       - 13 Janvier 2016 -                        #######
#######                                                                  #######
################################################################################



################################################################################
#####
##### AVANT-PROPOS
#####
##### INTRODUCTION
#####
##### 1. LES GRAPHIQUES DE BASE
#####    High-level plotting functions
#####
##### 2. EDITION D'UN GRAPHIQUE
#####    Low-level plotting functions
#####
##### 3. PARAMETRES GRAPHIQUES
#####
#####   3.1. Fonction par()
#####   3.2. Fonte de caracteres
#####   3.3. Symboles ponctuels
#####   3.4. Types de ligne
#####   3.5. Modifications des axes
#####   3.6. Ajustements des marges
#####   3.7. Les couleurs sous R
#####
##### 4. PERIPHERIQUES GRAPHIQUES ET EXPORTATION
#####
#####   4.1. Types de peripheriques
#####   4.2. Les fonctions dev.x()
#####   4.3. Exporter un graphique
#####
##### 5. PARTITIONNEMENT D'UNE FENETRE
#####
#####   5.1. mfrow et mfcol
#####   5.2. Fonction layout()
#####   5.3. Plot dans un plot
#####
#####
################################################################################



################################################################################
#####
##### 3. PARAMETRES GRAPHIQUES
#####



###                                                                          ###
###                                                      3.1. Fonction par() ###
###                                                                          ###

# Precedemment, nous avons mentionne que lorsque R trace un plot, il va recuperer
# les valeurs des parametres graphiques pour adapter les axes, le background, les
# couleurs, les tailles de caracteres, etc. Celles-ci sont stockees dans l'objet
# 'par' (qui est egalement une fonction).
par()
# Pour accéder à un paramètre en particulier
par()$col
# ou encore
par("col")
# et pour plusieurs paramètres
par("col", "bg")

# Ces parametres possedent des valeurs par defaut afin d’eviter a l'utilisateur
# de devoir les definir a chaque graphe. Bien entendu, ces valeurs peuvent etre
# modifiees : nous l'avons deja fait pour certains parametres (axes, couleurs,
# etc.).

# Ces modifications ont ete apportees directement dans les fonctions 'plot',
# 'points', 'lines', etc. Mais, ces meme modifications peuvent aussi etre
# specifies dans la fonction 'par'.

# Par ex., changeons la couleur du background (transparent par defaut). C'est
# l'argument 'bg' present dans la fonction 'par'.
par(bg = "steelblue")
plot(0)

# Remarque : quand le peripherique graphique est ferme, les valeurs par defaut
# des parametres graphiques sont restaurees.

# Nous pouvons aussi lister plusieurs elements dans 'par' pour les modifier.
par(bg = "steelblue", fg="grey80", lwd=2, mfrow = c(1, 2))
plot(0)
plot(x = c(1, 2), y = c(1, 2), type = "l")

# Remarque : certains parametres ne peuvent etre modifies que via la fonction
# 'par'. C'est le cas notamment de 'mar', 'oma', 'mfcol' et 'mfrow'. Ceux-ci
# permettent de modifier les marges du graphe, et de partitionner la fenetre
# graphique.

# La fonction 'par' comporte 72 parametres graphiques dont la plupart sont
# modifiables. Plus precisement 66 sont modifiables, on peut les obtenir en entrant:
par(no.readonly = TRUE)

# Au cours de ce chapitre, nous allons nous interesser aux plus pertinents
# d'entre eux. Voici la liste des parametres que nous aborderons et de leurs valeurs.
### run
opar <- par()
param <- data.frame()

ess <- c("ann", "bg", "bty", "cex", "col", "family", "fg", "font", "las", "lty",
    "lwd", "mar", "mfcol", "mfrow", "mgp", "oma", "pch", "srt", "tck", "xaxt",
    "yaxt", "xlog", "ylog","xaxs", "yaxs")

for (i in 1 : length(ess)){
    x         <- grep(ess[i], names(opar))
    Parameter <- names(opar)[x]
    Value     <- unlist(as.character(opar[x]))
    tab       <- data.frame(Parameter, Value)
    param     <- rbind(param, tab)
}
param
### end run



###                                                                          ###
###                                                 3.2. Fonte de caracteres ###
###                                                                          ###

# Abordons tout d'abord la notion de fonte de caracteres. En typographie, une
# fonte de caracteres est un ensemble de regles qui va determiner le rendu
# visuel d'un texte. Une fonte de caractere comporte :
#    - une police de caracteres (font family ou typeface),
#    - un style (normal, italique ou oblique),
#    - une graisse (normal ou gras),
#    - un corps (taille de police).

# Par ex., le Helvetica normal 12 points est une fonte de caracteres, mais le
# Helvetica est une police de caracteres.

# De nombreuses classifications existent pour les polices de caracteres. Celle
# que nous presentons ici a l'avantage de se rapprocher des polices disponibles
# dans R.

# Sous R, trois polices principales de caracteres sont disponibles :
#
#    - sans-serif (note 'sans') : regroupe les polices sans empattement (c.-a-d.
#      sans les extensions qui viennent terminer les caracteres) et a chasse
#      proportionnelle (la largeur des caracteres varie en fonction du caractere).
#      Citons le Helvetica, Arial et Verdana comme police sans-serif.
#
#    - serif (note 'serif') : regroupe les polices a empattement et a chasse
#      proportionnelle. C'est le cas du Times (New Roman) et du Garamond.
#
#    - monospace (note 'mono') : possede la caracteristique d'avoir une chasse
#      fixe. Ses polices sont preferees pour l’ecriture de code informatique car
#      elles permettent un alignement vertical des caracteres.
#      Sous Windows, R utilise la police Courier New et sous Mac le Monaco.

# Par defaut, la police 'sans' est utilisee sous R pour afficher l'information
# textuelle sur des graphes. Cette valeur est stockee dans l'argument 'family' de
# 'par'. Regardons les differences entre ces trois polices de caracteres.
par(mfrow = c(2, 2))
plot(0)
plot(0, family = "sans")
plot(0, family = "serif")
plot(0, family = "mono")

# Cet argument controle la police de toutes les informations textuelles du graphe.
# Sous R, le style et la graisse sont regroupes sous le meme argument : 'font'.
# Mais, celui-ci est plus precis que 'family' dans le sens ou il se decline en
# 'font.axis', 'font.lab', 'font.main' et 'font.sub'. Regardons les differents
# styles disponibles.
par(mfrow = c(2, 2))
plot(0, family = "serif", font.lab = 1, font.axis = 1)
plot(0, family = "serif", font.lab = 2, font.axis = 2)
plot(0, family = "serif", font.lab = 3, font.axis = 3)
plot(0, family = "serif", font.lab = 4, font.axis = 4)

# Remarque : dans les fonctions 'text' et 'mtext', seul l'argument 'font' est
# disponible.
text(x = 1, y = 0.5, "Texte en gras-italique", font = 4)
text(x = 1, y = -0.5, "Texte en italique", font = 3)

# Remarque : tous ces parametres auraient pu etre modifies dans le 'par' avant
# de realiser le graphique.

# Le corps de police se modifiera avec les arguments 'cex.axis', 'cex.lab',
# 'cex.main', 'cex.sub'. Attention : l'argument 'cex' modifie la taille des
# symboles ponctuels (sauf dans les fonctions 'text' et 'mtext').
# Regardez dans le 'par' les valeurs par defaut de chacun.
par(mfrow = c(2, 2))
plot(0, family = "serif", cex.lab = .5, cex.axis = .5)
plot(0, family = "serif", cex.lab = 1, cex.axis = 1) # Defaut
plot(0, family = "serif", cex.lab = 1.5, cex.axis = 1.5)
plot(0) # Defaut
text(x = 1, y = 0.5, "Texte minuscule", cex = 0.25)
text(x = 1, y = -0.5, "Texte enorme", cex = 3)

# Deux autres polices de caracteres existent et sont regroupees dans les fontes
# Hershey. Il s'agit des polices 'script' (ou cursive) qui imite l’ecriture
# manuscrite et 'gothic' (ou fantaisie) avant tout decorative. Cet ensemble de
# fontes regroupe des polices permettant d'afficher toute sorte de symboles
# (grecs, musicaux, japonais, pictogrammes, etc.). Le meilleur moyen d'en faire
# le tour est encore d'utiliser la commande suivante.
demo(Hershey)

# Regardons rapidement comment utiliser ces polices et caracteres speciaux.

plot(0, type = "n", xlim = c(1, 4), ylim = c(1, 4), family = "serif")
text(3.5, 2, "\\CL", vfont = c("serif", "plain"), cex = 2)
text(1.5, 2, "\\DI", vfont = c("serif", "plain"), cex = 2, col = "red")
text(1.5, 3, "\\HE", vfont = c("serif", "plain"), cex = 2, col = "red")
text(3.5, 3, "\\SP", vfont = c("serif", "plain"), cex = 2)
text(2.5, 3.5, "Texte dans la police Gothique", vfont = c("gothic english", "plain"))
text(1.5, 3.5, "\\#H2330", vfont = c("serif", "plain"), cex = 2)
text(3.5, 3.5, "\\#H2331", vfont = c("serif", "plain"), cex = 2)
text(2.5, 3, "\\*z", vfont = c("serif", "plain"), cex = 2)
text(2.5, 2, "\\*p", vfont = c("serif", "plain"), cex = 2)
text(2.5, 2.5, "Texte dans la police Script italique", vfont = c("script", "italic"), srt = 45)
text(2.5, 1.5, "Texte dans la police Serif Symbol Bold", vfont = c("serif symbol", "bold"))

# Finalement, pour terminer, regardons comment ajouter des expressions
# mathematiques sur un graph.
plot(0, type = "n", xlim = c(1, 4), ylim = c(1, 4))
text(2.5, 2.5, expression(f(x) == x^2), cex = 2, family = "serif")
text(2.5, 1.5, expression(+infinity~~~~ sum(over(1,hat(alpha[i])),i==1, n)), cex = 2, family = "serif")
text(2.5, 3.5, expression(sqrt(x[i]) > bar(omega)), cex = 2, family = "serif")

# Pour plus de details, reportez-vous a l'aide des fonctions 'plotmath' et
# 'expression'.
# Pour plus de font, voir les packages 'extrafont' et 'showtext'
# Pour ce dernier, un exemple :
browseURL('https://gist.github.com/KevCaz/61c28866e3b16522d3a3')




###                                                                          ###
###                                                  3.3. Symboles ponctuels ###
###                                                                          ###

# Les points possedent trois caracteristiques : un symbole, une taille et une
# couleur. Le type de symbole est defini par l'argument 'pch', sa taille par
# 'cex', et sa couleur par 'col'.

plot(x = 2.5, y = 2.5, xlim = c(1, 4), ylim = c(1, 4), family = "serif") # pch = 1
for (i in seq(.5, 60, by = .5))
    points(2.5, 2.5, cex = i, col = ifelse(i %in% c(1, 10, 35, 60), "red", "black"))

par(mfrow = c(2, 2))
plot(rnorm(50), rnorm(50), pch = 1)
plot(rnorm(50), rnorm(50), pch = "1")
plot(rnorm(50), rnorm(50), pch = 65)
plot(rnorm(50), rnorm(50), pch = "A")

# Attention:
# 1. certains symboles sont caracterises par deux couleurs, le contour
# et le fond. L'argument 'col' controlera la couleur de contour alors que
# l'argument 'bg' definira la couleur de fond. C'est le cas notamment des 'pch'
# 21 a 25.
# 2. Si vous utilisez une chaine de charactere comme pch, seul le premier est
# utilise

plot(0, pch = 22)
plot(0, pch = 22, cex = 3)
plot(0, pch = 22, col="red", cex=3)
plot(0, pch = 22, col = "red", lwd=2, bg = "yellow", cex = 3)

# Voici quelques valeurs possibles pour l'argument 'pch'. Certaines commandes
# seront detaillees plus loin, donc ce n'est pas grave si vous ne comprenez pas
# toutes les lignes de code suivantes. L'essentiel est le contenu du graph.
# Si des warnings apparaissent, c'est normal : certaines valeurs de 'pch' ne sont
# pas implementees.

### run
par(mar = c(3, 3, 3, 3), bg = "gray")
plot(0, xlim = c(1, 10), ylim = c(1, 12), xaxt = "n", yaxt = "n", xlab = "", ylab = "")
title("Quelques valeurs de l'argument 'pch'", family = "mono")
for (i in 1 : 12){
    points(x = 1:10, y = rep(13-i, 10), pch = (((i-1)*10)+1):(i*10), family = "mono")
    text(x = 1:10, y =  rep(13-i, 10), labels = (((i-1)*10)+1):(i*10), pos = 1, cex = 0.5, family = "mono")
}
### end run

# Il est possible d'utiliser la fonction 'text' pour inserer des symboles Hershey.
x <- rnorm(50)
y <- rnorm(50)
plot(x, y, type = "n")
text(x, y, "\\#H2330", vfont = c("serif", "plain"))



###                                                                          ###
###                                                      3.4. Types de ligne ###
###                                                                          ###

# Les lignes, tout comme les bordures de polygones (et les axes), possedent trois
# caracteristiques sur lesquels on peut jouer : le type de ligne ('lty'), son
# epaisseur ('lwd') et sa couleur ('col').

# Voici quelques types de ligne disponibles sous R.

### run
par(mar = c(3, 3, 3, 3), bg = "gray")
plot(0, xlim = c(1, 10), ylim = c(1, 18), xaxt = "n", yaxt = "n", xlab = "", ylab = "")
title("Quelques types de ligne", family = "mono")
for (i in 1 : 6){
    points(x = c(1, 10), y = rep(i, 2), lty = i, type = "l")
    text(x = 1.7, y = i, labels = paste("lty =", i, "& lwd = 1"), pos = 1, cex = 0.5, family = "mono")
    points(x = c(1, 10), y = rep(i+6, 2), lty = i, type = "l", lwd = 2)
    text(x = 1.7, y = i+6, labels = paste("lty =", i, "& lwd = 2"), pos = 1, cex = 0.5, family = "mono")
    points(x = c(1, 10), y = rep(i+12, 2), lty = i, type = "l", lwd = 3)
    text(x = 1.7, y = i+12, labels = paste("lty =", i, "& lwd = 3"), pos = 1, cex = 0.5, family = "mono")
}
### end run

# Exploitons ces differents types de lignes pour creer un bel arriere plan.
plot(0, type = "n", xlim = c(0, 40), ylim = c(0, 40), axes = F, ann = F)
rect(0, 0, 40, 40, col = "gray", border = "transparent")
for (i in seq(10, 30, 10)){
    lines(c(0, 40), c(i, i), col = "white")
    lines(c(i, i), c(0, 40), col = "white")
}
for (i in seq(5, 35, 10)){
    lines(c(0, 40), c(i, i), col = "white", lty = 3)
    lines(c(i, i), c(0, 40), col = "white", lty = 3)
}
rect(0, 0, 40, 40, border = "darkgray", col = "transparent")


###                                                                          ###
###                                              3.5. Modifications des axes ###
###                                                                          ###

# Les axes sont un des elements graphiques possedant probablement le plus de
# parametres modifiables. Et pour cause, c'est un element extremement important
# pour la comprehension de l'information presentee.
# Les arguments 'cex.axis', 'col.axis', 'font.axis' ont deja ete abordes dans les
# sections precedentes. Nous n'y reviendrons pas.

# Si les arguments 'xaxt' et 'yaxt' ont la valeur 'n', les axes ne seront pas
# affiches apres l'appel a des fonctions de haut niveau graphique (e.g. 'plot').
# Cela aura le meme effet qu'utiliser l'argument 'axes' de la fonction 'plot' et
# de le mettre a FALSE. Sauf que dans ce dernier cas, la boite delimitant la
# region du plot ne sera pas affichee non plus.
# Comparons.
par(mfrow = c(2, 2))
plot(0)
plot(0, xaxt = "n", yaxt = "n")
plot(0, axes = FALSE)
# En utilisant l'argument 'ann' (pour annotation), on peut egalement supprimer
# le nom des axes (ainsi que toutes les autres annotations, comme le titre).
plot(0, axes = FALSE, ann = FALSE)

# Un autre argument peut etre interessant. Il s'agit de 'mgp'. Celui possede
# trois valeurs qui vont controler le positionnement du nom des axes, des axes
# eux-meme et de leur valeurs. Ces positions sont relatives a la delimitation
# de la region du plot.
par(mfrow = c(2, 2))
#
plot(0, pch = 15)
par(mgp = c(0, 1, 0))
plot(0, pch = 15)
par(mgp = c(3, 3, 0))
plot(0, pch = 15)
par(mgp = c(3, 1, 3))
plot(0, pch = 15)

# Un ajustement plus serre.
par(mfrow=c(1,2), xaxs="r", yaxs="r", mgp = c(1.5, 0.5, 0), ann=FALSE)
plot(0, pch = 15)
par(xaxs="i", yaxs="i")
plot(0, pch = 15)


# Regardons les derniers arguments au travers d'un exemple en utilisant la
# fonction 'axis'. Nous allons reproduire le graphique vu a la section
# precedente qui trace un plot vide et colorie la region graphique en gris
# et rajoute des lignes de graduation.
# Executons ce code

### run
par(mfrow=c(1,1))
plot(0, type = "n", xlim = c(0, 40), ylim = c(0, 40), axes = F, ann = F)
rect(0, 0, 40, 40, col = "gray", border = "transparent")
for (i in seq(10, 30, 10)){
    lines(c(0, 40), c(i, i), col = "white")
    lines(c(i, i), c(0, 40), col = "white")
}
for (i in seq(5, 35, 10)){
    lines(c(0, 40), c(i, i), col = "white", lty = 3)
    lines(c(i, i), c(0, 40), col = "white", lty = 3)
}
rect(0, 0, 40, 40, border = "darkgray", col = "transparent")
### end run

# Nous allons rajouter les axes principaux avec un pas de 10.
axis(side = 1, at = seq(0, 40, by = 10), labels = seq(0, 40, by = 10),
    col = "darkgray", col.axis = "darkgray", family = "serif", pos = 0)
axis(side = 2, at = seq(0, 40, by = 10), labels = seq(0, 40, by = 10),
    col = "darkgray", col.axis = "darkgray", family = "serif", pos = 0, las = 2)

# Maintenant rajoutons une graduation secondaire plus fine et sans etiquette
axis(side = 1, at = seq(5, 35, by = 5), labels = F, lwd = 0, lwd.ticks = 1,
    col.ticks = "darkgray", tck = -0.01, pos = 0)
axis(side = 2, at = seq(5, 35, by = 5), labels = F, lwd = 0, lwd.ticks = 1,
    col.ticks = "darkgray", tck = -0.01, pos = 0)

# En indiquant 'lwd = 0', on evite de retracer les axes, mais le fait de
# specifier 'lwd.ticks' permettra de tracer quand meme les graduations.
# Quant a l'argument 'tck', il specifie la longueur des traits de graduation.

# Rajoutons les noms des axes
mtext(text = "x-axis", side = 1, line = 1.5, family = "serif", font = 2, col = "darkgray")
mtext(text = "y-axis", side = 2, line = 1.75, family = "serif", font = 2, col = "darkgray", las = 0)

# Et superposons quelques points.
x <- sample(1:39, 50, replace = T)
y <- sample(1:39, 50, replace = T)
points(x, y, col = "#FF000080", pch = 19, cex = 2)


# Est-il possible de rajouter un troisieme axe? Bien sur...
# Nous allons rajouter a ce graph une autre serie de points. Celle-ci sera
# croisee a la variable x ci-dessus, mais possedera une gamme de valeurs plus
# grande que y.
z <- sample(1:359, 50, replace = T)

# Le repere de coordonnees actuel n'est pas adapte pour representer ces valeurs.
# Nous allons donc utiliser l'argument 'new' du 'par' pour ajouter une fonction
# plot a ce graphe existant. Ceci aura pour consequence de modifier le repere
# actuel.
par(new = T)

# Maintenant traçons notre plot :
plot(x, z, col = "#0000FF80", pch = 19, cex = 2, xlim = c(0, 40), ylim = c(0, 400),
    axes = F, ann = F)

# Rajoutons notre second axe des y a droite.
axis(side = 4, at = seq(0, 400, by = 100), labels = seq(0, 400, by = 100),
    col = "blue", col.axis = "blue", family = "serif", pos = 40, las = 2)
axis(side = 4, at = seq(50, 350, by = 100), labels = F, lwd = 0, lwd.ticks = 1,
    col.ticks = "blue", tck = -0.01, pos = 40)



###                                                                          ###
###                                              3.6. Ajustements des marges ###
###                                                                          ###

# Les marges sont egalement une notion importante d'un graphique. Plusieurs
# parametres graphiques permettent de les controler. Nous n'en verrons que deux :
# 'oma' (pour outer margin) et 'mar' (figure margin).
# Regardons a quoi elles correspondent au travers de deux exemples.

# Exemple 1
### run
par(oma = c(2, 2, 2, 2), mar=c( 5.1 4.1 4.1 2.1), bg = "gray")
plot(0, 0, type = "n", xlab = "Axe des x", ylab = "Axe des y", family = "mono")
box("plot", col = "red", lwd = 2)
rect(-1, -1, 1, 1, border = NA, col = "red", density = 20, angle = 45)
box("figure", col = "blue", lwd = 2)
box("outer", col = "green", lwd = 4)
mtext(side = 2, line = 4.75, text = "oma", family = "mono", col = "green", font = 2)
mtext(side = 3, line = 1.5, text = "mar", family = "mono", col = "blue", font = 2)
### end run

# Exemple 2
### run
par(oma = c(2, 2, 2, 2), bg = "gray", mfrow = c(1, 2))
plot(0, 0, type = "n", xlab = "Axe des x", ylab = "Axe des y", family = "mono")
box("plot", col = "red", lwd = 2)
rect(-1, -1, 1, 1, border = NA, col = "red", density = 20, angle = 45)
box("inner", col = "purple", lwd = 4)
box("figure", col = "blue", lwd = 1)
mtext(side = 3, line = 1.75, text = "mar", family = "mono", col = "blue", font = 2)
plot(0, 0, type = "n", xlab = "Axe des x", ylab = "Axe des y", family = "mono")
box("plot", col = "red", lwd = 2)
rect(-1, -1, 1, 1, border = NA, col = "red", density = 20, angle = 45)
box("figure", col = "blue", lwd = 1)
mtext(side = 3, line = 1.75, text = "mar", family = "mono", col = "blue", font = 2)
box("outer", col = "green", lwd = 4)
mtext(side = 3, line = 0.5, text = "oma", family = "mono", col = "green", font = 2, outer = T)
### end run

# Par defaut, 'oma' est egal a:
par()$oma

# Il se definit comme suit : bas, gauche, haut et droit. Tout comme 'mar'.
# Comme on le voit dans l'exemple 2, il peut etre tres interessant a utiliser dans
# le cas d'une fenetre graphique composite : il permettra de definir des marges
# communes a tous les graphes du peripherique.

# Par defaut, 'mar' est egal a:
par()$mar

# Il vient controler la taille de la region du plot (incluant les axes). Son
# ajustement est tres important. Regardons un exemple.
### run
par(mfrow = c(2, 2))
plot(0, pch = 15, main = "'mar' par defaut")
box("figure", col = "blue", lwd = 2)
box("plot", col = "red", lwd = 2)
par(mar = c(6, 6, 6, 6))
plot(0, pch = 15, main = "'mar' = c(6, 6, 6, 6)")
box("figure", col = "blue", lwd = 2)
box("plot", col = "red", lwd = 2)
par(mar = c(2, 2, 2, 2))
plot(0, pch = 15, main = "'mar' = c(2, 2, 2, 2)")
box("figure", col = "blue", lwd = 2)
box("plot", col = "red", lwd = 2)
par(mar = c(0, 0, 0, 0))
plot(0, pch = 15, main = "'mar' = c(0, 0, 0, 0)")
box("figure", col = "blue", lwd = 2)
box("plot", col = "red", lwd = 2)
### end run

# Mais, un bon ajustement peut donner un rendu visuel interessant en grossissant
# au maximum la region du plot.
par(mfrow=c(1,1), mgp = c(1.5, 0.5, 0), mar = c(2.5, 2.5, 0.25, 0.25))
plot(0, pch = 15, xlab = "x-axis", ylab = "y-axis", family = "serif", bty = "n", font.lab = 2)




###                                                                          ###
###                                                 3.7. Les couleurs sous R ###
###                                                                          ###

# Terminons ce chapitre par les couleurs. En informatique, il existe plusieurs
# systemes de representation de couleurs. On peut utiliser des palettes de
# couleurs predefinies, le systeme Rouge Vert Bleu, RVB (ou RGB en anglais) ou
# le systeme hexadecimal. D'autres systemes existent, mais nous ne les verrons
# pas aujourd'hui.

# Commençons par le plus simple : les palettes.
# Voici la palette de base de R.
palette()

# Cette palette, bien que peu garnie, est interessante car elle permet de choisir
# une couleur par son nom, ou par son numero.
par(mfrow = c(1, 2))
plot(1:8, col = palette(), pch = 15)
plot(1:8, col = 1:8, pch = 15)

# La palette 'colors' comporte 657 couleurs nommees differentes dont 100 nuances
# de gris ecrites deux fois 'grey' et 'gray'
par(mfrow = c(1, 2))
plot(1:50, col = colors()[1:50], pch = 15)
plot(1, col = 'steelblue', pch = 15)

# Mais, qu'est-ce qu'une couleur? En informatique, on utilise souvent (mais pas tout le
# temps) la synthese additive des trois couleurs primaires. Dans ce systeme, 100% de
# rouge, de bleu et de vert donnera du blanc. En quantite egale, on obtiendra du gris.
# Les valeurs de chaque couleur s’etalonne de 0 a 1 ou de 0 a 255.
par(mfrow = c(3, 3))
plot(0, pch = 15, cex = 6, col = rgb(red = 0, green = 0, blue = 0), main = "rgb(0, 0, 0)")
plot(0, pch = 15, cex = 6, col = rgb(1, 1, 1), main = "rgb(1, 1, 1)")
plot(0, pch = 15, cex = 6, col = rgb(.8, .8, .8), main = "rgb(0.8, 0.8, 0.8)")
plot(0, pch = 15, cex = 6, col = rgb(1, 0, 0), main = "rgb(1, 0, 0)")
plot(0, pch = 15, cex = 6, col = rgb(0, 1, 0), main = "rgb(0, 1, 0)")
plot(0, pch = 15, cex = 6, col = rgb(0, 0, 1), main = "rgb(0, 0, 1)")
plot(0, pch = 15, cex = 6, col = rgb(1, 1, 0), main = "rgb(1, 1, 0)")
plot(0, pch = 15, cex = 6, col = rgb(0, 1, 1), main = "rgb(0, 1, 1)")
plot(0, pch = 15, cex = 6, col = rgb(1, 0, 1), main = "rgb(1, 0, 1)")

# Si on souhaite utiliser un range de 0 a 255, il faut le preciser.
par(mfrow = c(1, 1))
plot(0, pch = 15, cex = 6, col = rgb(255, 0, 255, maxColorValue = 255), main = "rgb(255, 0, 255)")

# Bien. Et le codage en hexadecimal, c'est quoi?
# Wikipedia nous dit que c'est un 'systeme de numeration positionnel en base 16'. C'est
# assez violent... En gros, c'est une maniere de representer les nombres,
# differemment du systeme decimal que l'on connait tous.
# A la difference du systeme binaire (qui repose sur une base 2 [0 et 1]), le systeme
# hexadecimal utilise 16 symboles : les dix chiffres arabes et les lettres de A a F.
# La correspondance avec le systeme decimal est tres simple :
# Hex <-> Dec
#  0  <->  0
#  1  <->  1
#  2  <->  2
#  3  <->  3
#  4  <->  4
#  5  <->  5
#  6  <->  6
#  7  <->  7
#  8  <->  8
#  9  <->  9
#  A  <->  10
#  B  <->  11
#  C  <->  12
#  D  <->  13
#  E  <->  14
#  F  <->  15

# Pour retranscrire des couleurs, on utilise 6 'chiffres' hexadecimaux : les deux
# premiers pour le rouge, les suivants pour le vert et les deux derniers pour le bleu.
# Le tout precede du signe #

# Voici quelques valeurs :
# Rouge : #FF0000
# Vert :  #00FF00
# Bleu :  #0000FF
# Blanc : #FFFFFF
# Noir :  #000000

# Comment convertir une valeur RGB en hexadecimal. La encore, c'est tres simple : on
# prend la quantite de rouge (exprime entre 0 et 255) et on la divise par 16. On prend
# le modulo (partie entiere de la division) et on le convertit d’apres la correspondance
# ci-dessus. On obtient le premier caractere hexadecimal de la couleur en question. On
# fait de meme avec le reste de la division et on obtient le second symbole. On repete
# l’operation pour les deux autres couleurs RGB et voila!

# Exemple avec la couleur Peru (R = 205, G = 133 et B = 63)
##
# Modulo du rouge
205 %/% 16 # 12 donc C
# Reste du rouge
205 %% 16 # 13 donc D
##
133 %/% 16 # 8 donc 8
133 %% 16 # 5 donc 5
##
63 %/% 16 # 3 donc 3
63 %% 16 # 15 donc F

# Ce qui nous donne : #CD853F
# Comparons
par(mfrow = c(1, 2))
plot(0, pch = 15, cex = 6, col = rgb(red = 205, green = 133, blue = 63, maxColorValue = 255))
plot(0, pch = 15, cex = 6, col = "#CD853F")

# On pourrait faire l’operation inverse en partant de l’hexadecimal pour obtenir le code RGB.
# Heureusement, la fonction 'col2rgb' permet de faire ça rapidement.
col2rgb("#CD853F")

# Pourquoi compliquer les choses en parlant d’hexadecimal? Il se trouve qu'il existe
# sous R d'autres palettes de couleurs, mais contrairement aux autres palettes vu
# precedemment, elles ne retournent pas de nom de couleurs, mais du code hexadecimal.

rainbow(24)
gray(0:9/9)

par(mar = c(0, 0, 0, 0))
image(matrix(1:255, ncol = 1), col = rainbow(255), axes = F)

par(mar = c(0, 0, 0, 0))
image(matrix(c(0:255,255:0), ncol = 1), col = gray(c(0:255,255:0)/255), axes = F)

# Pour terminer, parlons transparence. En RGB, la transparence se gere avec
# l'argument 'alpha' (0 signifiera transparent et max [1 ou 255] opaque).
# En hexadecimal, il suffit de rajouter a la fin deux chiffres indiquant le
# pourcentage d'opacite.
cols <- "#0000FF"
for (i in seq(95, 10, -5))
    cols <- c(cols, paste(cols[1], i, sep = ""))
cols[1] <- paste(cols[1], "99", sep = "")
image(matrix(1:length(cols), ncol = 1), col = cols)


# Deux sites sympa a visiter en cas de besoin ou d'inspiration.
browseURL("http://www.code-couleur.com/")
browseURL("http://www.colorhexa.com")



################################################################################
#####
##### 4. PERIPHERIQUES GRAPHIQUES ET EXPORTATION
#####



###                                                                          ###
###                                               4.1. Types de peripherique ###
###                                                                          ###

# Le type de peripherique depend du systeme d'exploitation : sous Windows, le
# moteur graphique de base est X11, alors que sous les machines Unix, c'est le
# systeme QUARTZ (bien que le moteur X11 puisse etre installe). Sous Mac OSX,
# QUARTZ est appele AQUA.
# Verifions
.Platform

# Quelles sont les caracteristiques de la fenetre graphique par defaut?
x11.options()
quartz.options()

# Regardons comment ouvrir un nouveau peripherique graphique sous Windows.
x11()

# Nous pouvons aussi redimensionner la fenetre a l'ouverture.
x11(width = 12, height = 7)
x11(width = 5, height = 5)

# Regardons comment ouvrir un nouveau peripherique graphique sous Unix.
quartz()

# Redimensionnons.
quartz(width = 12, height = 7)
quartz(width = 5, height = 5)

# Remarque : si vous developpez des fonctions ou des packages qui seront
# distribues et donc potentiellement utilises sur n'importe quel systeme
# d'exploitation, vous pouvez utiliser la commande suivante pour ouvrir un nouveau
# peripherique graphique. Celle-ci s'adapte a n'importe quel OS : Windows et Unix
# (Mac OSX et Linux).
switch(.Platform$OS.type, unix = {quartz()}, windows = {x11()})

# Nous avons vu que l'appel aux 'High-level plotting' fonctions avait pour
# consequence d'ouvrir un nouveau peripherique graphique. C'est vrai si aucun
# peripherique n'est ouvert. Par contre, si un peripherique graphique est deja
# ouvert, son contenu sera remplace par le nouveau plot, mais les parametres
# graphiques specifies pour ce peripherique seront eux conserves.
plot(0)

quartz() # ou x11
par(bg = "red")
plot(0)

# Ne fermez pas la derniere fenetre graphique, et executez la fonction ci-dessous.
plot(rnorm(50), pch = 15)

# D'autres peripheriques existent. Et la encore, ils sont dependant de l'OS utilise.
# Regardons ceux disponibles sur votre machine.
capabilities()

# En plus de ceux-ci, les peripheriques PDF et POSTSCRIPT sont eux disponibles
# sur tous les systemes d'exploitation. Nous verrons quelques uns de ces autres
# peripheriques dans la derniere section de ce chapitre.

# La commande suivante permet de fermer tous les peripheriques ouverts.
graphics.off()



###                                                                          ###
###                                               4.2. Les fonctions dev.x() ###
###                                                                          ###

# Cette famille de fonctions permet de manipuler les peripheriques graphiques.
# Regardons-en quelques unes.
# Pour commencer, ouvrons quelques peripheriques graphiques (sous Windows,
# remplacez 'quartz()' par 'x11()')
quartz(width = 12, height = 7)
quartz()
quartz(width = 4, height = 7)

# Affichons la liste des peripheriques ouverts.
dev.list()

# Regardons lequel de ces peripheriques est actif.
dev.cur()

# Cela signifie que nous ne pourrons ajouter des elements graphiques que dans ce
# peripherique.
# Quel est le peripherique precedent?
dev.prev()

# Admettons que nous souhaitions activer le second peripherique (nomme 3). Nous
# procederons comme suit.
dev.set(3)

# Verifions
dev.cur()

# Quel est le peripherique suivant?
dev.next()

# La commande 'dev.off' permet de fermer le peripherique et affiche le nouveau
# peripherique actif a l’ecran.
dev.off()

# Si on souhaite fermer tous les graphiques, mieux vaut utiliser la commande
# graphics.off() vue precedemment.
graphics.off()



###                                                                          ###
###                                                  4.3. Exporter un graphe ###
###                                                                          ###

# Pour exporter un graphe, c.-a-d. l'enregistrer sur le disque dur, trois
# possibilites existent. La premiere, c'est en cliquant. Vous savez sûrement
# deja comment faire.

# La seconde consiste a copier le contenu d'une fenetre graphique AQUA ou X11
# dans un peripherique de sortie (ex. pdf, png, tiff, etc.).

# Commencons par faire un plot.
x <- rnorm(50)
y <- rnorm(50)
plot(x, y, pch = 15, main = "My plot")
abline(lm(y ~ x))

# La fonction dev.copy() permet de copier le contenu d'un peripherique dans un
# autre.
dev.copy(device = quartz) # x11 pour Windows

# Mais, on peut s'en servir pour exporter dans un autre type de peripherique.
# Ici en pdf.
dev.copy(device = pdf)
dev.off()

# Remarques : pour que l'exportation s'effectue, il faut fermer la connexion au peripherique
# avec la commande dev.off(). Ici, on vient de creer un fichier pdf. Les dimensions de
# ce fichier sont les memes que celle du plot sous R. De plus, le fichier est
# exporte dans le repertoire courant et R choisit un nom par defaut.
# Donnons un nom specifique au fichier et exportons le de nouveau en pdf.

x <- rnorm(50)
y <- rnorm(50)
plot(x, y, pch = 15, main = "My plot")
abline(lm(y ~ x))
dev.copy(device = pdf, "MyPlot.pdf")
dev.off()

# Remarque : les fonctions dev.print() et dev.copy2pdf() permettent de faire
# la meme chose. Cependant, avec la premiere, si aucun nom n'est
# specifie, le peripherique sera envoye a une imprimante. Donc, attention si
# vous l'utilisez.


# Regardons pour terminer la derniere façon d'exporter un graphe sous R :
# l'utilisation des 'File-based devices'. Derriere ce nom complique se
# cachent en fait des peripheriques connus de tous : png, jpeg, pdf, tiff, etc.
# Contrairement a la fonction dev.copy(), avec ce genre de fonctions on ouvre
# le peripherique graphique de sortie (pdf, etc.) avant de faire le plot. Ceci
# presente un certain desavantage : c'est qu'on ne voit pas le resultat s'afficher
# dans R apres l’execution de chaque ligne de code. Ce n'est qu'une fois la
# connexion au peripherique de sortie coupee qu'on pourra voir le resultat en pdf.

# Exportation en PNG.
png("MyPlot2.png")
plot(x, y, pch = 15, main = "My plot 2")
abline(lm(y ~ x))
dev.off()

# Exportation en PDF.
pdf("MyPlot2.pdf")
plot(x, y, pch = 15, main = "My plot 2")
abline(lm(y ~ x))
dev.off()

# Exportation en PDF redimensionne.
pdf("MyPlot2bis.pdf", width = 12, height = 6)
plot(x, y, pch = 15, main = "My plot 2")
abline(lm(y ~ x))
dev.off()

# Si vous redimensionner le peripherique de sortie, il peut etre parfois
# difficile d'ajuster la resolution. Et bien souvent, vous devrez aussi
# jouer dans le par, notamment au niveau des marges.
pdf("MyPlot2ter.pdf", width = 12, height = 6, pointsize = 16)
plot(x, y, pch = 15, main = "My plot 2")
abline(lm(y ~ x))
dev.off()

# A vous de voir quelle approche vous convient le mieux. Bien qu'au final, le
# resultat soit le meme.



################################################################################
#####
##### 5. PARTITIONNEMENT D'UNE FENETRE
#####



###                                                                          ###
###                                                      5.1. mfrow et mfcol ###
###                                                                          ###

# L'objectif de cette derniere section est de produire des graphiques composites.
# Nous avons utilise l'argument 'mfrow' de la fonction par() a de multiple
# reprises. Cet argument permet de partitionner la fenetre graphique en
# differentes regions, chacune destinee a accueillir un plot. Avec 'mfrow', les
# regions sont remplies en ligne tandis qu'avec 'mfcol' l'ordre des regions se
# fait en colonne.


###                                                                          ###
###                                                   5.2. Fonction layout() ###
###                                                                          ###

# Interessons-nous maintenant a la fonction 'layout'. Celle-ci fonctionne sur le
# principe que les arguments 'mfrow' et 'mfcol', mais dispose de plus de souplesse
# dans le partitionnement du peripherique graphique.
# Cette fonction va diviser la fenetre graphique d’apres une matrice. Regardons
# comment elle fonctionne.

(mat <- matrix(1:4, ncol = 2, nrow = 2, byrow = T))
layout(mat)
layout.show(4)

# La fonction layout.show() permet d'afficher le partitionnement graphique et les
# n regions souhaitees. Ici, on affiche les quatre regions creees.
# Remplissons les regions :
layout(mat)
layout.show(4)

for (i in 1 : 4){
    plot(0, xlim = c(-1, 1), ylim = c(-1, 1), type = "n")
    rect(-1, -1, 1, 1, col = palette()[i])
}

# Un premier avantage de cette fonction est que plusieurs regions peuvent etre
# destinees a un meme graphe.
(mat <- matrix(c(1, 1, 2, 3, 4, 4), ncol = 2, byrow = T))
layout(mat)
layout.show(4)

for (i in 1 : 4){
    plot(0, xlim = c(-1, 1), ylim = c(-1, 1), type = "n")
    rect(-1, -1, 1, 1, col = palette()[i])
}

# L'autre gros avantage de cette fonction est que les dimensions de chaque region
# peuvent etre variables.
layout(mat, widths = c(4, 1), heights = c(.5, 4, 1))
layout.show(4)

# Remplissons chaque region.
# Region 1 (titre)
par(mar = c(0, 2, 0.1, 0))
plot(0, type = "n", ann = F, axes = F, xlim = c(-.5, .5), ylim = c(-.15, .15))
text(0, 0, "Titre de la figure", cex = 3, family = "serif", font = 2)

# Region 2 (scatterplot)
par(mar = c(0, 2, 0, 0))
plot(0, xlim = c(-1, 1), ylim = c(-1, 1), type = "n", bty = "n", ylab = "")
rect(-1, -1, 1, 1, col = palette()[2])
rect(-.5, -1, .5, 1, col = "yellow")

# Region 3 (legend)
par(mar = c(0, 0, 0, 0))
plot(0, type = "n", ann = F, axes = F, xlim = c(-1, 1), ylim = c(-1, 1))
rect(-1, -1, 1, 1, col = "darkgray")
text(0, 0.5, "Legende", family = "serif", font = 2, cex = 2)
text(0, 0.15, "Item 2", family = "serif", font = 2, cex = 1, pos = 4)
text(0, 0.25, "Item 2", family = "serif", font = 2, cex = 1, pos = 4)
points(c(-.25, 0), c(0.15, 0.15), type = "l", lwd = 2, col = "red")
points(c(-.25, 0), c(0.25, 0.25), type = "l", lwd = 2, col = "yellow")

# Region 4 (lines)
par(mar = c(2, 2, 2, 0))
x <- rnorm(100)
plot(x, type = "n", bty = "n", ylab = "")
polygon(x, col = "blue")



# Il existe une autre fonction, split.screen(), qui permet de faire des choses
# similaire en utilisant des divisions multiple de la fenetre.
#  Nous vous laissons le soin de l'explorer par vous-meme.

###                                                                          ###
###                                                   5.3. Plot dans un plot ###
###                                                                          ###


par(fig = c(0, 1, 0, 1), bg = "gray", mgp = c(2, 0.5, 0))
plot(rnorm(50), pch = 15)
par(fig = c(0.6, 0.99, 0.6, 0.99), new = T, mgp = c(3, 0.1, 0), tck = -.02)
x <- 1:50
plot(0, xlim = range(x), ylim = range(x), cex.axis = 0.75, bty  ="n", ann = F, type = "n")
rect(range(x)[1], range(x)[1], range(x)[2], range(x)[2], col = "red", border = 0)
points(x, sample(x), pch = 19, col = "blue")


## Note

# Il existe aussi la fonction split.screen() pour partitionner une fenêtre,
# cette dernière étant incompatible avec layout().


######################################################
######################################################
# Les graphiques avec R sont le sujet du livre (et de son doctorat) de
# Paul Murrel, membre actif du R Developpement Core Team. Vous pouvez vous
# procurer gratuitement (legalement?) ce livre :
browseURL("http://www.google.ca/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&ved=0CCIQFjAA&url=http%3A%2F%2Flux.e-reading-lib.org%2Fbookreader.php%2F137370%2FC486x_APPb.pdf&ei=i3BKVN6kGoqlyQSsjIHwBQ&usg=AFQjCNEc4AUwEG8z2PssMNidoAZrbKL9Dg&sig2=UDw-Um4ELtkYQZjtofV0FQ&bvm=bv.77880786,d.aWw")

# Plus de ressources sur les graphiques
browseURL(http://kevincazelles.fr/rgraphics/2015/12/04/r-and-graphics.html)

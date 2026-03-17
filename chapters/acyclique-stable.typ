#import "../templates/prelude.typ": *

== Les configurations stables <sec:stable>

Avant de conclure ce chapitre sur les réseaux à préférences acycliques, je propose de répondre, au moins partiellement et pour les graphes d'acceptabilité Erdős-Rényi, à la deuxième question majeure des systèmes à préférences acycliques : _quelles sont les propriétés de la configuration stable ?_

Pour $b=1$, il est possible d'étudier la distribution des partenaires grâce à une approche (simplifiée) de type _champ moyen_. Pour les préférences globales, on peut prouver l'existence d'une limite fluide avec solution explicite, qui montre en particulier que la distribution de la valeur du partenaire d'un pair est centrée autour de la valeur de ce pair, avec une décroissance exponentielle : c'est l'effet de _stratification_ @gai07stratification. Pour des préférences acycliques aléatoires ou géométriques, la solution de la limite fluide décroît en loi de puissance. Bien que je ne sois pas en mesure de prouver l'approche _champ moyen_, je propose de valider cette approche en la comparant avec la solution exacte (pour les préférences globales) ou à l'aide de simulations.

Enfin, je propose d'étendre les résultats à $b >= 1$. Les équations fluides ne semblent alors plus admettre de solution explicite, mais on observe le même comportement asymptotique que pour $b=1$ (exponentiel pour les préférences globales, en loi de puissance sinon). Une conséquence inattendue est que pour les préférences géométriques, la configuration stable est un petit-monde si les quotas sont suffisants.

La plupart des résultats présentés ici sont rassemblés dans l'article _The Stable Configuration in Acyclic Preference-Based Systems_ @mathieu09stable, dont une version étendue est disponible sous forme de rapport de recherche @mathieu08stable.

=== Notation spécifique

Comme je propose d'étudier en détail la configuration stable dans cette section, quelques notations supplémentaires sont nécessaires, pour décrire en particulier la distribution des partenaires. Si $i$ et $j$ sont acceptables, $r_i (j)$ désigne le rang acceptable de $j$ selon $i$ ($1$ étant le meilleur rang). $r_i$ est le classement acceptable de $i$. Si $i$ a plus de $k$ voisins (acceptables), $r_i^(-1)(k)$ est le $k$ième meilleur voisin acceptable de $i$. De même, pour tout $j != i$, $R_i (j)$ désigne le rang de $j$ dans le graphe complet, sans tenir compte de la notion d'acceptabilité#footnote[Je suppose l'existence d'un prolongement naturel de la matrice des valeurs aux paires non acceptables. Ce prolongement est immédiat pour les préférences globales (la valeur intrinsèque) et géométriques (la distance). Pour les préférences acycliques aléatoires, il s'obtient en attribuant des valeurs aléatoires "fantômes" aux arêtes non-acceptables.]. $R_i$ est le classement _complet_ de $i$. Pour $K<n$, $R_i^(-1)(K)$ est le $K$ième meilleur voisin, acceptable ou non, de $i$.

Dans tout ce qui suit, $D$ désigne la distribution du, ou des, partenaires stables. Afin d'alléger l'écriture, je propose d'utiliser une notation lâche, où le sens de $D$ est spécifié à l'aide d'indices et d'exposants à chaque fois que cela est nécessaire. Ainsi, $D_(R_i)(K)$ indique la probabilité que $i$ ait son pair de rang complet $K$ comme partenaire ; $D_(n,d)(i,j)$ est la probabilité que $i$ et $j$ soient partenaires s'il y a $n$ pairs avec une acceptabilité Erdős-Rényi de degré moyen $d=p(n-1)$ ; si $c <= b(i)$, $D_(r_i,c)(k)$ est la probabilité que le $c$ème meilleur partenaire stable de $i$ ait un rang acceptable $k$…

La distribution cumulative complémentaire (_Complementary Cumulative Distribution Function_, ou CCDF) de $D$ est notée $S$, et les versions normalisées de $D$ et $S$ sont respectivement notées $cal(D)$ et $cal(S)$.

=== Équations acycliques <sec:mean_field>

Pour le cas du couplage simple ($b=1$), je propose une méthode générique pour décrire le rang complet de $C(i)$, s'il existe, dans la configuration stable $C$. La généralisation au $b$-couplage sera faite en @sec:bb_mean.

==== Équation exacte <subsec:generic>

Soit $D_(R_i)(K)$ la probabilité que $R_i (C(i))=K$, c'est-à-dire que le partenaire de $i$, s'il existe, ait le rang complet $K$. La CCDF de $D$ est définie par $S_(R_i)(K) := 1 - sum_(L=1)^(K-1) D_(R_i)(K)$, i.e. la probabilité que $i$ ait un partenaire de rang complet plus grand ou égal à $K$ ($R_i (C(i)) >= K$) ou n'ait pas de partenaire du tout (notation courte pour la disjonction des deux événements : $R_i (C(i)) lt.not K$). En s'inspirant de l'approche utilisée dans @gai07stratification, je propose une équation exacte décrivant $D_(R_i)$ avant de donner une version simplifiée issue d'une approche de type _champ moyen_.

Pour exprimer $D_(R_i)(K)$, on peut observer que pour que $i$ soit stable avec son pair de rang complet $K$, noté $j := R^(-1)_i (K)$, il faut (et il suffit de) vérifier les trois conditions suivantes :
- ${i,j}$ doit être une arête acceptable, ce qui se produit avec probabilité $p$ si $G$ est un graphe Erdős-Rényi $cal(G)(n,p)$ ;
- $i$ ne doit pas avoir de meilleur partenaire stable que $j$ ($R_i (C(i)) lt.not K$) ;
- $j$ ne doit pas avoir de meilleur partenaire stable que $i$ ($R_j (C(j)) lt.not R_j (i)$).

Cela mène à l'équation exacte suivante :

$ D_(R_i)(K) = p S_(R_i)(K) Pr(R_j (C(j)) lt.not R_j (i) | R_i (C(i)) lt.not K) $ <eq:d_exact>

==== Équation approchée <subsec:meanfield>

La principale difficulté de l'@eq:d_exact est la probabilité conditionnelle, délicate à manier à cause des corrélations qui peuvent exister entre $R_j (C(j)) lt.not R_j (i)$ et $R_i (C(i)) lt.not K$. La solution est de tenir ces corrélations pour négligeables :

#approximation[Les événements "$i$ n'est pas avec meilleur que $j$" et "$j$ n'est pas avec meilleur que $i$" sont indépendants.] <ass:meanfield1>

Cette approximation, que j'appelle parfois un peu abusivement "hypothèse de champ moyen", est raisonnable pour $p$ assez petit#footnote[Quelques exemples simples semblent indiquer une erreur en $p^3$, confirmée par les simulations @gai07stratification.]. L'@eq:d_exact peut alors se simplifier en

$ D_(R_i)(K) = p S_(R_i)(K) S_(R_j)(R_j (i)) $ <eq:d_approx0>

Pour aller plus loin, il faut prendre en compte le type de préférences.

=== Préférences globales <sec:nb>

Comme les préférences globales sont caractérisées par un ordre total sur les pairs, on peut se passer de la matrice de valeurs $m$ en étiquetant les pairs de $1$ à $n$, $1$ étant le meilleur. On considère ainsi directement la probabilité $D(i,j)$ que $i$ et $j$ soient partenaires. En remarquant que le rang complet de $j$ pour $i$ est $j$ si $j<i$ et $j-1$ si $j>i$ (un pair ne se classe pas lui-même), on obtient la relation entre $D$ et $D_R$ :

$ D(i,j) = cases(D_(R_i)(j) & "si" j < i\,, 0 & "si" j = i " (non-réflexivité),", D_(R_i)(j-1) & "si" j > i.) $ <eq:dij_dri>

En posant $S(i,j) := 1 - sum_(k=1)^(j-1) D(i,k)$, on obtient la déclinaison de l'@eq:d_approx0 pour les préférences globales :

$ D(i,j) = cases(0 & "si" i = j\,, p S(i,j) S(j,i) & "sinon.") $ <eq:dij_sij>

Cette équation#footnote[Pour la petite histoire, l'@eq:dij_sij a été proposée par Julien Reynier sur une idée originale de Fabien de Montgolfier. Chronologiquement elle est à l'origine de l'@eq:d_approx0 (équation générale), et non l'inverse.], qui se résout numériquement par une double itération, donne une très bonne approximation de la distribution empirique @gai07stratification.

==== Normalisation

Une limite fluide explicite vers laquelle les distributions discrètes convergent est un atout certain pour la description de la configuration stable. Cela permet en effet de donner une description complète, immédiate et globale de la distribution pour tous $n$ et $p$, ce qui n'est pas le cas de l'@eq:dij_sij.

Afin d'obtenir cette limite, il faut pouvoir comparer des distributions pour des valeurs arbitraires de $n$. Il est donc nécessaire de normaliser $D$. Une manière assez simple de le faire consiste à représenter chaque pair $i$ par un rang normalisé $alpha$, avec $0 <= alpha < 1$. Plus précisément, on associe à chaque $i$ le réel $alpha(i) = (i-1)/n$, et réciproquement à chaque réel positif $alpha$ l'entier $i(alpha) = floor(n alpha) + 1$. La version normalisée de $D$, notée $cal(D)$, est alors définie par

$ cal(D)_n (alpha, beta) = n D(floor(n alpha)+1, floor(n beta)+1) $ <eq:normalisa_d>

$cal(D)_n$ est une fonction en escalier (à deux variables), qui prend les valeurs $(n D(i,j))$. Le facteur $n$ permet d'exprimer simplement $D(i,j)$ comme une intégrale de $cal(D)$ :
$ D(i,j) = integral_((j-1)/n)^(j/n) cal(D)_n ((i-1)/n, x) dif x = integral_((i-1)/n)^(i/n) cal(D)_n (x, (j-1)/n) dif x $

La distribution cumulative complémentaire normalisée est définie par

$ cal(S)_n (alpha, beta) = 1 - integral_0^beta cal(D)_n (alpha, x) dif x $ <eq:sab_def>

et la relation entre $S$ et $cal(S)$ est

$ S(i,j) = cal(S)((i-1)/n, (j-1)/n) $ <eq:sij_sab>

==== Convergence des distributions normalisées

Si le degré moyen reste constant, j'ai montré l'existence d'une limite continue des distributions $cal(D)$. La première étape est de régler le problème d'une discontinuité intrinsèque le long de la diagonale principale ($alpha approx beta$), due au fait que $D(i,i)=0$. C'est un problème mineur car cette discontinuité est juste là pour rappeler la non-réflexivité du couplage. Il se résout en introduisant une fonction $cal(D)$ plus "continue", obtenue en prolongeant $cal(D)$ sur la diagonale principale à l'aide de l'@eq:dij_sij :

$ tilde(cal(D))(alpha, beta) = cases(cal(D)(alpha, beta) & "si" floor(n alpha) != floor(n beta)\,, n p (S(floor(n alpha)+1, floor(n alpha)+1))^2 & "sinon.") $

La limite fluide, à degré constant, des fonctions $tilde(cal(D))$ est alors donnée par le théorème qui suit :

#theoreme[
Soit $d>0$ une constante. Si $n -> infinity$, avec $p = d/n$, les fonctions $tilde(cal(D))_(n,d)$ convergent uniformément vers
$ cal(D)_infinity (alpha, beta) = (d e^(d abs(beta - alpha))) / (1 - e^(-d min(alpha, beta)) + e^(d abs(beta - alpha)))^2 $ <eq:f_nb_d>
] <th:f_nb_d>

Ce résultat montre qu'asymptotiquement, la distribution des partenaires ne dépend que du degré moyen de $G$ (supposé Erdős-Rényi). Cela permet de décrire quantitativement l'effet de _stratification_ @gai07stratification : à $alpha$ fixé, la distribution du partenaire stable de $alpha$ décroît exponentiellement en $|beta - alpha|$, avec intensité $d$ ($cal(D)_infinity (alpha, beta) approx d e^(-d|beta - alpha|)$ pour $d|beta - alpha|$ assez grand). Autrement dit, un pair de rang normalisé $alpha$ tend à avoir pour partenaire un pair de même rang, à plus ou moins $1/d$.

#demo[
La preuve du @th:f_nb_d comporte quatre étapes @mathieu08stable :
- montrer que les fonctions $tilde(cal(D))_(n,d)$ sont uniformément Cauchy sur $[0,1]^2$ ;
- utiliser la convergence de Cauchy pour montrer que $cal(S)_N$ et $tilde(cal(D))_N$ admettent des limites $cal(S)_infinity$ et $cal(D)_infinity$ ;
- donner une EDP vérifiée par $cal(S)_infinity$ ;
- résoudre l'EDP#footnote[Pour le lecteur avide d'équations "exotiques", il s'agit de résoudre $partial_beta cal(S)_infinity (alpha, beta) = -d cal(S)_infinity (alpha, beta) cal(S)_infinity (beta, alpha)$, avec la condition initiale $cal(S)_infinity (alpha, 0) = 1$. Bien que d'apparence innocente, la résolution de cette équation non-locale m'a donné pas mal de fil à retordre, alors même que je connaissais par ailleurs sa solution. Je remercie en passant François Baccelli qui m'a aiguillé sur la piste de la dé-non-localisation.], et déduire $cal(D)_infinity$ de la solution.
]

L'existence de cette limite fluide avait été proposée comme conjecture dès @gai07stratification, et prouvée pour le cas $alpha=0$, mais ce n'est que plus tard que la preuve et l'expression complètes ont été trouvées @mathieu08stable.

Le @th:f_nb_d permet d'obtenir trois corollaires immédiats qui complètent la compréhension de la configuration stable.

#corollaire[
En considérant $cal(S)_infinity (alpha, 1)$, la probabilité qu'un pair de rang normalisé $alpha$ soit célibataire dans la configuration stable est $1 / (1 + e^(-d alpha)(e^(-d) - 1))$.
]

#corollaire[
Pour $i != j$ (cas discret), une bonne approximation de $D(i,j)$ est
$ D(i,j) approx (p e^(p abs(j-i))) / (1 - e^(-p min(i,j)) + e^(p abs(j-i)))^2 $ <eq:dij_explicit>
]

#corollaire[
Soit une suite de distributions normalisées $cal(D)_(n,d)$ à degré croissant non borné ($d arrow.r^(n -> infinity) infinity$). On a
$ forall alpha in [0,1[, quad cal(D)_(n,d) (alpha, .) arrow.r^(n -> infinity)^* delta_alpha $
] <coro:weak_dirac>

Ce dernier corollaire généralise un théorème proposé dans @gai07stratification, qui montrait l'existence d'une limite faible de Dirac dans le cas d'une suite de distributions à $p = d/(n-1)$ constant. Il signifie que dès que le degré tend vers l'infini (par exemple en $O(log(n))$), alors asymptotiquement, un pair a pour partenaire un pair de même rang normalisé (pas de déviation), et la probabilité de célibat devient nulle.

==== Validation

Pour valider les résultats précédents, il faut comparer des résultats de simulations à l'@eq:dij_sij (récurrence sous l'approximation d'indépendance), puis à l'@eq:dij_explicit. C'est ce qui a été fait @gai07stratification@mathieu08stable.

Comme indiqué précédemment, on observe pour l'@eq:dij_sij une très bonne précision, de l'ordre de $p^3$.

Pour la limite fluide, mis à part le prolongement continu sur la diagonale principale, la précision est également très bonne, sauf pour des valeurs de $n$ faibles et de $d$ élevées. Ces observations sont consistantes avec la preuve complète du @th:f_nb_d @mathieu08stable, qui montre une convergence en $O(d^2/n dot e^(8d))$. Elles seraient même plutôt en faveur d'une convergence en $O(d^2/n)$, qui est d'après moi la vraie borne, même si cela reste à prouver#footnote[Le facteur $e^(8d)$ vient de l'utilisation du lemme de Grönwall @gronwall, qui amplifie une erreur de quantification incompressible en $O(d^2/n)$. Mais en pratique, l'@eq:dij_sij, qui sert de base à la construction des distributions, est auto-stabilisante (une erreur dans un sens à un moment donné est compensée dans l'autre sens à l'itération suivante), ce que le lemme de Grönwall ne permet pas de prendre en compte.].

==== Résolution exacte

Dans la situation que je viens de proposer ($b=1$, préférences globales, acceptabilité $cal(G)(n,p)$), il est en fait inutile de recourir à l'approximation d'indépendance, car il existe une récurrence qui permet d'obtenir la distribution exacte @mathieu08stable.

J'ai pu obtenir cette récurrence en conditionnant le fait que $i$ et $j$ soient partenaires selon le rang du partenaire du pair $1$ (plus petit que $i$, entre $i$ et $j$, plus grand que $j$ ou pas de partenaire).

Tout comme pour la formule approchée, la formule exacte admet une limite fluide, qui obéit à une certaine EDP. Bien que les deux EDP (exacte et approchée) soient extrêmement différentes#footnote[L'EDP exacte est relativement classique, et se résout par la méthode des _caractéristiques_, alors qu'il a fallu résoudre l'EDP approchée, décrite en note plus haut, de manière moins conventionnelle.], elles donnent la même solution, à savoir @eq:f_nb_d.

Le fait que dans ce cas particulier, la récurrence donnée par l'approximation d'indépendance ait exactement la même limite fluide que la récurrence exacte est un argument de poids (à défaut d'être rigoureux) pour justifier l'utilisation de cette approximation dans les autres cas. Car un inconvénient majeur de la récurrence exacte est que la "ruse" utilisée ne s'applique pas pour les autres préférences, ni pour $b>1$. Si jolie soit cette récurrence, l'hypothèse d'indépendance reste donc incontournable si l'on veut généraliser les résultats.

=== Préférences acycliques et géométriques <section:ra_db>

Je propose maintenant de m'intéresser aux préférences acycliques (aléatoires) et géométriques. Pour ces préférences, on peut remarquer que les pairs sont non différenciés. Sur l'ensemble des réalisations possibles, on peut donc considérer que tous les pairs suivent la même distribution de partenaire : $D_(R_i)(K)$ est indépendant de $i$, et peut donc être noté $D_R (K)$.

Comme pour les préférences globales, il s'agit de trouver la distribution du rang complet en simplifiant l'@eq:d_exact avant de la résoudre. Je donne aussi rapidement la distribution des distances et des éléments de résolution de la distribution du rang relatif.

==== Distribution du rang complet <section:rank>

Pour les préférences géométriques ou aléatoires, l'@ass:meanfield1 n'est pas suffisante, c'est pourquoi je propose une approximation supplémentaire :

#approximation[Le rang complet est symétrique : $R_i (j) = R_j (i)$.] <ass:meanfield2>

Je suppose donc que $R_i (j)$ n'est pas une si mauvaise approximation de $R_j (i)$ pour les préférences considérées. Cela donne une équation très simple pour $D_R (K)$ :

$ D_R (K) = p S_R^2 (K), quad "avec" S_R (K) = 1 - sum_(L=1)^(K-1) D_R (L) $ <eq:d_approx>

$S_R$ peut donc être obtenue par une récurrence simple :

$ S_R (K) = cases(1 & "si" K = 1\,, S_R (K-1) - p S_R^2 (K-1) & "sinon.") $ <eq:s_approx>

Et $D_R$ est directement donnée par $D_R (K) = S_R (K) - S_R (K+1)$.

*Limite fluide.* <subsec:fluid>

Comme pour les préférences globales, $D_R$ peut être normalisée. Pour $0 <= alpha < 1$, on pose $cal(d)_R (alpha) := (n-1) D_R (floor((n-1)alpha)+1)$. Le facteur de normalisation est maintenant $n-1$ car c'est la valeur maximale de $K$ ($n$ était celle de $i$ et $j$ en @sec:nb). $D_R$ s'exprime comme une intégrale de $cal(d)_R$ :
$ D_R (K) = integral_((K-1)/(n-1))^(K/(n-1)) cal(d)_R (x) dif x $
$cal(s)_R$ est alors naturellement définie par :
$ cal(s)_R (alpha) = 1 - integral_0^alpha cal(d)_R (x) dif x $

#theoreme[
Soit $d>0$ une constante. Si $n -> infinity$, avec $p = d/n$, les fonctions $cal(S)_R$ convergent uniformément vers
$ cal(s)_infinity (alpha) = 1 / (d alpha + 1) $ <eq:f_sr_alpha>
En particulier, la probabilité qu'un pair soit célibataire dans la configuration stable est asymptotiquement $cal(s)_R (1) = 1/(d+1)$, et une bonne approximation de $S_R (K)$ est
$ S_R (K) = 1 / (p(K-1) + 1) $ <eq:f_sr_k>
] <th:complete>

#demo[
La preuve est la même que pour le @th:f_nb_d, en plus facile. Il faut d'abord montrer que les $cal(D)_R$ sont uniformément Cauchy (ce qui est plus facile ici car il n'y a qu'une seule variable et pas besoin d'introduire un prolongement sur la diagonale principale). On a alors la convergence uniforme vers une fonction continue $cal(s)_infinity$. On déduit alors de l'@eq:s_approx une équation différentielle ordinaire vérifiée par $cal(s)_infinity$ :
$ -dot(cal(s))_infinity (alpha) = d cal(s)_infinity^2 (alpha) $ <eq:fprime_c_alpha>
avec la condition initiale $cal(s)_infinity (0) = 1$. La solution de @eq:fprime_c_alpha est @eq:f_sr_alpha, ce qui achève la preuve.
]

*Validation.* <subsec:validation_geo>

Compte tenu des approximations faites, il est nécessaire de vérifier sur quelques exemples la précision de l'@eq:f_sr_k. J'ai donc testé sa validité pour quelques valeurs de $n$ et de $p$ @mathieu08stable.

Pour $p=1$, on ne peut pas vraiment dire que l'hypothèse d'indépendance soit vérifiée. Les simulations montrent que les distributions sont affectées par le type particulier de préférences, et la limite fluide n'est pas très précise, en particulier aux limites ($K$ proche de $1$ ou de $n$). On peut entre autres remarquer que la probabilité de célibat $1/n$ donnée par @eq:f_sr_k est clairement sur-estimée si $n$ est pair (puisqu'elle est alors nulle en réalité), mais exacte pour $n$ impair. La limite fluide réussit quand même à donner le comportement en $1/K$ commun à toutes les préférences considérées. De ce point de vue, elle est meilleure que l'équation récursive @eq:s_approx (dont elle dérive pourtant), qui donne $S_R (K) = delta_K^1$ pour $p=1$.

Au fur et à mesure que $p$ diminue, les courbes empiriques et la limite donnée par le @th:complete se rejoignent très vite. Dès $p=1/10$, elles sont presque indistinguables, ce qui valide l'utilisation de la limite fluide comme approximation de la distribution du rang complet.

==== Distribution des distances <subsec:geometric>

Il peut être intéressant de considérer d'autres distributions que celle du rang complet. Par exemple, pour des préférences géométriques, la distribution des distances entre partenaires stables peut être intéressante si les performances d'un couplage sont liées aux distances. Or, cette distribution peut être déduite de celle du rang complet :

#theoreme[
Soit $S_X (x)$ la probabilité qu'un pair n'ait pas de partenaire stable à distance inférieure à $x$ dans le tore unitaire de dimension $t$. Soit $B_t$ le volume d'une boule de rayon $x$ dans ce tore. Sous la limite fluide, on a
$ S_X (x) = 1 / (d B_t (x) + 1) $ <eq:f_c_x>
]

#demo[
Une boule de rayon $x$, centrée sur un pair quelconque, contient à peu près $n B_t (x)$ pairs puisqu'elle occupe une proportion $B_t (x)$ du tore (qui est supposé unitaire). Le pair le plus éloigné à l'intérieur de cette boule devrait donc avoir un rang complet d'à peu près $n B_t (x)$ pour le pair central, tout en étant à une distance d'environ $x$. On obtient ainsi la relation $S_X (x) = S_R (n B_t (x))$, et il ne reste plus qu'à utiliser l'@eq:f_sr_k pour conclure.
]

La fonction $B_t (x)$ dépend de la dimension $t$ et de la norme utilisée. Pour la norme infinie, on a tout simplement $B_t (x) = min((2x)^t, 1)$. L'écriture des autres normes peut être un peu plus compliquée à cause de possibles effets de recouvrement sur les bords. Remarquons que si j'avais choisi $RR^t$ (avec densité homogène) au lieu du tore unitaire, $B_t (x)$ aurait juste été la taille d'une boule de rayon $x$, sans effets de bord.

Comme à l'accoutumée, la précision de l'@eq:f_c_x a été vérifiée empiriquement, et le résultat est qu'elle a quasiment la même zone de validité que l'@eq:f_sr_k @mathieu08stable.

==== Distribution du rang relatif <sec:relative>

Pour les préférences acycliques aléatoires et géométriques, je me suis également intéressé à la distribution du rang relatif, donnée par la fonction $D_r (k)$ et sa distribution cumulée complémentaire $S_r (k) := 1 - sum_(l=1)^(k-1) D_r (k)$.

J'ai donc essayé d'adapter la méthode utilisée pour le rang complet. Les conditions à remplir pour que le partenaire stable de $i$ soit son $k$ième voisin acceptable $j = r_i^(-1)(k)$ sont les suivantes :
- $i$ doit avoir au moins $k$ voisins (si le $k$ième voisin existe, il est acceptable par définition),
- $i$ ne doit pas être avec un pair meilleur que $j$,
- $j$ ne doit pas être avec un pair meilleur que $i$.

En adaptant les approximations d'indépendance et de symétrie au rang relatif, on obtient alors la formule de récurrence suivante @mathieu08stable :

$ D_r (k) = S_r (k) (1 - I_(1-p)(n-k+1, k)) / (k+1) $ <eq:spetit_r_1>

où $I_x$ est la fonction bêta incomplète normalisée.

Hélas, l'@eq:spetit_r_1 est beaucoup moins précise que ne l'est l'@eq:f_sr_k pour le rang complet, en particulier pour $D_r (1)$ @mathieu08stable. La raison en est que les corrélations sont beaucoup plus présentes lorsque c'est le rang acceptable que l'on considère (en particulier si l'on considère le voisinage proche).

À titre d'exercice, je me suis donc demandé s'il était possible d'affiner l'estimation du rang relatif, et j'ai partiellement réussi : pour $D_r (1)$, il est possible d'avoir une meilleure estimation en limite fluide, qui s'obtient en conditionnant $D_r (1)$ sur le rang complet normalisé du premier partenaire acceptable @mathieu08stable. On obtient alors

$ D_r (1) = e dot E_1 (1) approx 0.596 $

où $E_1$ est l'exponentielle intégrale.

Cette valeur est très bonne dans à peu près tous les cas pour les préférences acycliques aléatoires. Pour les préférences géométriques, il est en revanche nécessaire d'être dans de bonnes conditions, c'est-à-dire $p$ petit et $n$ grand @mathieu08stable.

=== Généralisation au $b$-couplage <sec:bb_mean>

Je propose maintenant d'étendre les résultats précédents au problème du $b$-couplage. $b$ est toujours supposé constant sur les pairs pour plus de simplicité. Je ne propose ici que des résultats sur le rang complet, bien qu'il soit a priori possible de réutiliser les techniques vues précédemment pour le rang relatif ou les distances.

==== Équations sous l'hypothèse d'indépendance

Un pair peut maintenant avoir jusqu'à $b$ partenaires. On note donc, pour $1 <= c <= b$, $D_c$ la distribution du rang complet du $c$ième meilleur partenaire stable, et $S_c$ la CCDF correspondante. Tout comme pour le cas $b=1$, il est possible de donner les conditions nécessaires et suffisantes pour que $j = R_i^(-1)(K)$ soit le $c$ième meilleur partenaire stable de $i$ :
- le couple ${i,j}$ doit être acceptable,
- le $(c-1)$ième meilleur partenaire de $i$ (si $c>1$) doit être strictement meilleur que $j$, tandis que le $c$ième (s'il existe) ne doit pas l'être,
- le $b$ième partenaire de $j$, s'il existe, ne doit pas être meilleur que $i$.

En étendant l'hypothèse d'indépendance @ass:meanfield1, on obtient ainsi une formule générique pour le $b$-couplage :

$ D_(R_i, c)(K) = cases(p S_(R_i, 1)(K) S_(R_j, b)(R_j (i)) & "si" c = 1"\, sinon", p (S_(R_i, c)(K) - S_(R_i, c-1)(K)) S_(R_j, b)(R_j (i)) & .) $ <eq:generic_meanfield_multiple>

Pour être utilisable, cette formule doit être adaptée au type de préférences considéré.

Pour les préférences globales, si $D_c (i,j)$ désigne la probabilité que le $c$ième partenaire stable de $i$ soit $j$#footnote[Je me permets de souligner au passage que $D_c$ n'est plus symétrique, alors que c'était le cas pour $b=1$.], on obtient le système récursif suivant, qui se résout par une triple itération sur $i$, $j$ et $c$ @gai07stratification :

$ D_c (i,j) = cases(0 & "si" i = j"\, sinon", p S_1 (i,j) S_b (j,i) & "si" c = 1\,, p (S_c (i,j) - S_(c-1)(i,j)) S_b (j,i) & "si" c > 1.) $ <eq:nodebase_meanfield_multiple>

De même, pour les préférences acycliques aléatoires et géométriques, on obtient le système suivant à partir de l'@ass:meanfield2 (symétrie du rang complet) @mathieu08stable :

$ D_(R,c)(K) = cases(p S_(R,1)(K) S_(R,b)(K) & "si" c = 1\,, p (S_(R,c)(K) - S_(R,c-1)(K)) S_(R,b)(K) & "si" c > 1.) $ <eq:drc_meanfield>

En utilisant $S_(R,c)(1) = 1$ et $D_(R,c)(K) = S_(R,c)(K) - S_(R,c)(K+1)$, le système @eq:drc_meanfield se résout facilement par une double itération sur $K$ et $c$.

Les simulations montrent que les deux systèmes coïncident très bien avec les distributions empiriques tant que $n$ et $p$ vérifient les conditions usuelles @mathieu08stable. Le comportement est qualitativement très similaire à celui du couplage simple : décroissance exponentielle pour les préférences globales (mais à cause de la multiplicité des partenaires, des décalages apparaissent entre les pics de densité des $D_c$ et la valeur du pair d'origine), distribution en aile lourde pour les préférences géométriques et acycliques aléatoires.

Pour $b>1$, des limites fluides existent aussi. Hélas, contrairement au couplage simple, je n'ai pas réussi à trouver de solutions explicites pour les décrire (et le temps passant, je doute de plus en plus que de telles solutions existent). Il est néanmoins possible de donner les EDP vérifiées par ces limites.

Pour les préférences globales, les limites fluides vérifient

$ partial_y cal(S)_c (alpha, beta) = cases(-d cal(S)_1 (alpha, beta) cal(S)_b (beta, alpha) & "si" c = 1"\, sinon", -d (cal(S)_c (alpha, beta) - cal(S)_(c-1)(alpha, beta)) cal(S)_b (beta, alpha) & .) $ <eq:bbfluid>

avec les conditions initiales $cal(S)_c (alpha, 0) = 1$.

De même, en préférences acycliques et géométriques, les limites $cal(s)_(R,c)$ vérifient

$ dot(cal(s))_(R,c) = cases(-d cal(s)_(R,1) cal(s)_(R,b) & "si" c = 1\,, -d (cal(s)_(R,c) - cal(s)_(R,c-1)) cal(s)_(R,b) & "si" c > 1.) $ <eq:bfluid>

avec les conditions initiales $cal(s)_(R,c)(0) = 1$.

Même si ces équations ne peuvent pas être résolues complètement, la limite fluide a quand même plusieurs intérêts.

Tout d'abord, l'existence même d'une limite permet de la calculer numériquement avec précision et d'utiliser le résultat pour de multiples valeurs de $n$ et de $d$. Prenons par exemple le cas des préférences globales (le même raisonnement pouvant être fait pour les préférences acycliques et géométriques). On suppose $b$ fixé. Soit $d_(max)$ le degré moyen maximal des distributions que l'on veut évaluer, et $N$ une taille fixée d'échantillonnage de la limite fluide (plus $N$ est grand, plus l'évaluation sera précise). On peut alors poser $p = d_(max)/(N-1)$ et calculer les $D_(N,p,c)$ (une fois pour toutes) en utilisant @eq:nodebase_meanfield_multiple. Pour un degré $d <= d_(max)$, on pose $N' = d/p$ ($N'$ n'est pas nécessairement entier). En s'inspirant de la normalisation @eq:normalisa_d, on obtient l'approximation suivante pour $|alpha - beta| >= 1/N'$ :

$ cal(D)_(d,c) (alpha, beta) approx N' D_(N,p,c) (floor(N' alpha)+1, floor(N' beta)+1) $

On peut alors en retour utiliser cette estimation de la limite fluide pour des distributions discrètes. Ainsi, pour tout entier $n$ et pour tout $d <= d_(max)$, alors on a, pour $|i-j| >= n/N'$ (ce qui revient à $i != j$ si $n <= N'$)

$ D_(n,d,c)(i,j) approx (N'/n) D_(N,p,c) (floor((N'/n)(i-1))+1, floor((N'/n)(j-1))+1) $

Un autre intérêt des limites fluides est que les EDP qu'elles vérifient nous renseignent sur leur comportement. On peut par exemple s'en servir pour montrer que $cal(s)_(R,1) <= cal(s)_R <= cal(s)_(R,b)$ (et l'équivalent en préférences globales) et comprendre ainsi pourquoi le comportement en $b$-couplage reste similaire à celui du couplage simple.

=== Quelques applications <sec:applications>

Ayant mis beaucoup d'efforts dans la simple étude des distributions, je dois reconnaître n'avoir pas encore consacré énormément de temps aux propriétés évoluées des configurations stables, c'est-à-dire à celles susceptibles d'aider à comprendre les systèmes existants et à en développer de nouveaux. En voici néanmoins deux : la stratification des préférences globales et la "petit-mondisation" des préférences géométriques.

==== Stratification <subsec:appli_bittorrent>

Comme nous venons de le voir, en préférences globales, les partenaires stables d'un pair $i$ donné ont, en moyenne, le même rang que $i$. C'est la stratification, qui garantit une certaine équité dans la configuration stable @gai07stratification : en terme de rang, ce que donne un pair devrait être à peu près égal à ce qu'il reçoit. Il faut aussi se rappeler que les $cal(D)_c (alpha, .)$ ont une décroissance exponentielle avec déviation en $1/d$, $d$ étant le degré moyen du graphe d'acceptabilité. On s'aperçoit alors qu'il faut résoudre le compromis suivant :
- si $d$ est trop petit la déviation est élevée. En particulier, si les entrées de la matrice des valeurs (par exemple les bandes passantes d'un système à la _BitTorrent_) suivent une distribution non-uniforme, il peut y avoir une très grande différence entre l'espérance du gain et ce que l'on donne. Ce problème a été mis en évidence dans @gai07stratification pour expliquer des failles potentielles de la technique de Tit-for-Tat employée par BitTorrent ;
- un grand $d$ permet à l'opposé de renforcer l'équité. Mais en pratique, augmenter la taille du graphe d'acceptabilité a un coût pour les pairs : temps de convergence, place mémoire, maintenance du graphe… Un grand $d$ raccourcit aussi la déviation (jusqu'au Dirac dans la limite fluide), et donc augmente le diamètre de la configuration stable, ce qui peut être problématique si l'on veut propager de l'information à travers les arêtes stables.

Pour le quota $b$, qui représente le degré maximal dans la configuration stable, un compromis similaire existe : un grand $b$ peut améliorer l'équité et diminuer le diamètre, mais va être coûteux en ressources.

Cela suggère que pour la plupart des systèmes à préférences globales (i.e. basés sur le partage de la bande passante, de la capacité de stockage ou de calcul, de l'uptime…), il devrait exister un couple $(d,b)$ (ou plus généralement un couplage entre un graphe d'acceptabilité et un vecteur de quotas) optimal pour la configuration stable, dont la valeur exacte dépendrait de l'importance donnée à des paramètres comme le diamètre, l'équité, le temps de convergence ou le coût de maintenance.

==== Petit-mondisation <subsec:diaclust>

Un petit monde est un graphe creux (degré moyen en $O(log(n))$ voire en $O(1)$) avec un plus court chemin moyen (_average shortest path length_ ou ASPL) en $O(log(n))$ et un coefficient de clustering élevé (il existe beaucoup plus de cycles courts que pour un graphe aléatoire de même taille). Par exemple, Kleinberg a montré il y a quelques années qu'une grille de dimension $n$ pouvait être transformée en petit-monde à condition d'ajouter des arêtes longues suivant une distribution en $Omega(1/x^n)$ @kleinberg00small.

Regardons maintenant ce qui se passe pour une configuration stable, avec un $b$ en $O(log(n))$ pour que la configuration soit "creuse". S'il s'agit de préférences globales, le clustering est bien là comme conséquence de la stratification, mais le diamètre a tendance à croître linéairement @gai07acyclic. De même, pour les préférences acycliques aléatoires, le petit diamètre est vérifié mais il n'y a pas de grand clustering (la configuration stable se comporte comme un $b$-graphe aléatoire incomplet). Par contre, pour les préférences géométriques, la distribution en aile lourde permet d'avoir les deux propriétés : d'un côté, la plupart des partenaires stables ont un petit rang complet ; ils sont donc "géographiquement" proches ce qui donne le clustering ; de l'autre, il existe des liens longs qui rendent le diamètre petit. Les préférences géométriques sont donc propices à la génération de configurations en petit-monde, et c'est effectivement ce qui se produit @gai07acyclic. Cela ouvre un certain nombre de perspectives sur l'utilisation de la configuration stable, à commencer par un générateur de petits-mondes facile à utiliser.

Ce qui est étonnant dans cette petit-mondisation en préférences géométriques, c'est qu'elle est uniquement créée par la manière dont les pairs se classent les uns les autres : les distances réelles sont utilisées pour construire ces classements, mais les valeurs en elles-mêmes ne jouent aucun rôle direct dans le système à préférences en général et dans sa configuration stable en particulier. Ceci amène à penser que des caractéristiques topologiques d'un système peuvent donc être contenues dans un ensemble de préférences.

Comme exemple de caractéristiques, je me suis amusé à calculer numériquement les paramètres de petit-monde des préférences sur les tores pour quelques dimensions, le résultat étant que le diamètre et le clustering tendent à baisser quand la dimension augmente @mathieu08stable. J'ai ensuite regardé ce que donnaient les latences Meridian, et les paramètres obtenus se sont révélés proches de ceux du tore de dimension $3$. J'aime particulièrement ce résultat inattendu, car il semble suggérer qu'il existe une dimension d'Internet _au sens des préférences_, qui vaut à peu près $3$. Je peux ainsi rajouter ma pierre au mur des efforts fournis un peu partout pour estimer une dimension d'Internet (voir par exemple @abrahao08internet).

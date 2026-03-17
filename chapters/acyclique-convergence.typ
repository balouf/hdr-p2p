#import "../templates/prelude.typ": *

== Caractérisation de l'auto-stabilisation <sec:self>

_Quelle est la vitesse de convergence ?_ Cette section va tenter de répondre à cette question, d'un point de vue théorique (@subsec:self_worst et @subsec:self_expected) et pratique.

=== Bornes supérieures <subsec:self_worst>

Je propose d'abord de donner des bornes supérieures, au sens de la théorie de l'auto-stabilisation. L'initiative considérée dans toute cette section est _meilleur partenaire_. Pour $b=1$, les bornes sont exactes, linéaires en rounds, et quasi-exactes, exponentielles en initiatives. Je donne ensuite des bornes plus faibles pour $b>1$.

==== Convergence (rounds) <sec:round>

Pour $b=1$, le temps maximal de convergence, exprimé en rounds, est donné par le théorème suivant.

#theoreme([@mathieu07upper])[
  Partant de n'importe quelle configuration, une suite adversariale converge en au plus $floor(n/2)$ rounds. Cette borne est atteinte par une suite round-robin.
] <thm:round>

#demo[
  Le @lemma:hot garantit la stabilisation d'au moins une arête bouillante par round. Comme il y a au plus $floor(n/2)$ arêtes à stabiliser, la borne vient tout de suite. Pour l'atteindre, on peut utiliser des préférences globales, un graphe d'acceptabilité complet, la configuration de départ $C_emptyset$, et une suite round-robin utilisant le motif _du pire au meilleur_.
]

==== Convergence (initiatives) <sec:step>

Si l'on veut maintenant mesurer la convergence en nombre d'initiatives actives, la borne dépend des contraintes de la suite : round-robin ou totalement adversariale.

*Suite Round-Robin*

La borne pour les suites round-robin est donnée par le théorème suivant.

#theoreme([@mathieu07upper])[
  Partant de n'importe quelle configuration, une suite round-robin converge en au plus $sum_(k=0)^(floor(n/2)-1) n-(2k+1) approx n^2/4$ initiatives actives. Cette borne est exacte.
] <thm:robin>

#demo[
  Comme pour le @thm:round, on utilise le fait qu'au moins une arête bouillante est stabilisée par round. De plus, un pair stable n'est par définition plus jamais actif ; le comptage précis des initiatives possibles donne alors $sum_(k=0)^(floor(n/2)-1) n-(2k+1) approx n^2/4$. Le système utilisé pour le @thm:round atteint la borne, prouvant qu'elle est exacte.
]

*Suite adversariale*

La convergence pour une suite adversariale est décrite par le théorème suivant.

#theoreme([@mathieu07upper])[
  Partant de n'importe quelle configuration, une suite adversariale converge en au plus $2^(n-1) - 1$ initiatives actives. Réciproquement, il existe une suite qui converge en $Theta(lambda^n)$ initiatives actives, avec $lambda approx 1.6826$, ce qui montre que la borne exacte des suites adversariales se situe entre ces deux valeurs.
] <thm:upperbound>

#demo[
  Comme beaucoup d'autres preuves, la borne $2^(n-1) - 1$ est issue du @lemma:hot. L'astuce est de considérer une arête bouillante et de regarder le moment où elle se stabilise. Avant cet instant, les pairs adjacents ne peuvent prendre l'initiative : on est par hypothèse en _meilleur partenaire_, donc ils se stabiliseraient. Après, ils sont inactifs. On en déduit une récursion sur le nombre de pairs autorisés à prendre une initiative, à partir de laquelle la borne est déduite.

  La borne $Theta(lambda^n)$ est quant à elle obtenue pour les préférences globales, en acceptabilité complète, à partir d'une suite _le pire d'abord_ : à chaque instant, l'initiative est prise par le plus mauvais pair actif (celui avec la plus grande étiquette). Une étude complète du comportement de cette suite d'initiatives donne la borne inférieure.
]

#remarque[
  Dans tous les résultats que je viens d'énoncer, les bornes sont atteintes à partir de préférences globales. De ce point de vue, on peut donc considérer que les préférences globales sont les "pires" possibles pour la convergence, comme la suite va le confirmer. D'une manière plus générale, les préférences globales ont souvent un comportement atypique au sein des préférences acycliques.
]

==== Généralisation au $b$-couplage

Pour $b>1$, une adaptation du @thm:round nous donne immédiatement une borne de $floor(n b/2)$ rounds (au moins une arête est stabilisée par round). Mais il est facile de voir que c'est juste une borne supérieure. Par exemple, en prenant $b=n-1$ (c'est le cas limite de l'absence de quotas : tout le monde peut simultanément collaborer avec tout le monde), chaque pair est sûr d'être stabilisé après avoir pris $n-1$ initiatives, ce qui donne une borne de $n-1$ rounds beaucoup plus petite que $floor(n(n-1)/2)$.

L'explication derrière l'imprécision de la borne est que lorsque $b>1$, une configuration non-stable possède des arêtes chaudes en plus des arêtes bouillantes. Ces arêtes simplement chaudes sont plus dures à dénombrer (toutes les configurations transitoires n'en ont pas), ce qui rend le calcul des bornes plus difficile. On peut quand même donner des bornes plus précises que $floor(n b/2)$ pour les préférences globales (qui, rappelons-le, sont intuitivement les pires préférences possibles).

#theoreme([@mathieu08self])[
  Pour les préférences globales, le temps de convergence est borné par $b/(b+1) n$ rounds si l'acceptabilité est complète, et par $n$ sinon.
] <th:g_b>

Les simulations (cf @sec:setup) indiquent que la borne $b/(b+1) n$ reflète assez bien le comportement réel des préférences globales : les premiers quotas sont ceux qui coûtent le plus cher en terme de convergence. L'acceptabilité complète semble de plus être le pire cas possible, ce qui fait que $n$ est clairement une estimation supérieure (sans parler de $floor(n b/2)$).

#demo[
  Si l'acceptabilité est complète, la configuration stable est faite de cliques de taille $b+1$ (@gai07stratification) ; $b$ rounds stabilisent une clique, d'où le résultat. Dans le cas général (acceptabilité inconnue), on peut juste affirmer que $b$ rounds stabilisent $b$ pairs, d'où la borne $n$.
]

=== Temps moyens de convergence <subsec:self_expected>

Intéressons-nous maintenant à la convergence moyenne pour des suites round-robin et Poisson non adversariales. Les résultats présentés ici sont valables pour $b=1$, en initiative _meilleur partenaire_. Il s'agit de bornes supérieures sur le temps moyen de convergence de certaines classes de systèmes à préférences, temps moyen mesuré en initiatives ($1 "u.t." = n "initiatives"$).

==== Borne générique

Sous les hypothèses considérées ($b=1$ et initiative _meilleur partenaire_), la borne suivante est valable pour tout système acyclique :

#theoreme([@mathieu08self])[
  Le temps moyen de convergence est borné par $n/4$ pour une suite Poisson, et par $(n+1)/6$ pour une suite round-robin.
] <thm:selfconv_generic>

#demo[
  Comme souvent, le théorème repose sur le @lemma:hot, à savoir l'existence d'au moins deux pairs bouillants dans toute configuration non-stable. On en déduit un temps moyen entre deux initiatives "bouillantes" de $1/2$ pour une suite Poissonnienne et $1/3(1+1/n)$ pour une suite round-robin. En multipliant par $n/2$ (nombre maximal d'arêtes de la configuration stable), on obtient le résultat.
]

#remarque[
  Pour des préférences globales avec acceptabilité complète, toute configuration instable admet exactement deux pairs bouillants (les deux meilleurs pairs non stabilisés). Ceci suggère que les bornes du @thm:selfconv_generic doivent être assez précises pour ces systèmes, ce qui est confirmé par les simulations @mathieu08self. On retrouve le fait que les préférences globales sont "les pires préférences acycliques possibles".
]

#remarque[
  La borne exacte $(n+1)/6$ pour les suites round-robin n'est pas contradictoire avec l'exactitude de la borne $floor(n/2)$ du @thm:round : l'une est une borne en moyenne sur l'ensemble des suites round-robin, l'autre une borne dans le pire cas.
]

==== Préférences globales

Pour les préférences globales, avec un graphe d'acceptabilité Erdős-Rényi $cal(G)(n,p)$, il existe des bornes plus fines :

#theoreme([@mathieu08self])[
  En préférences globales, si $G=cal(G)(n,p)$, le degré moyen étant $d=p(n-1)$, le temps moyen de convergence est en $O(d+log(n))$ pour une suite Poissonnienne et en $O(d)$ pour une suite round-robin.
] <thm:selfconv_node-based>

#demo[
  Le coeur de la preuve consiste à _compter_ les pairs bouillants dans les configurations non-stables. Par des techniques combinatoires, on montre qu'il y en a de l'ordre de $n/d$. On en déduit ensuite un temps moyen entre deux initiatives "bouillantes" de l'ordre de $d/n$, ce qui donne le comportement commun en $O(d)$. Enfin, il faut porter une attention particulière à la finalisation du processus de convergence, lorsque la quasi-totalité des arêtes sont déjà stabilisées. Dans cette _fin de partie_, les noeuds non-stables sont quasiment tous bouillants. Une suite round-robin va alors achever la stabilisation en $O(1)$ ($1$ unité de temps stabilise tous les noeuds bouillants du moment), tandis qu'une suite Poissonnienne va avoir besoin de $O(log(n))$ u.t. (problème de boules et d'urnes).
]

==== Préférences acycliques

Pour des préférences acycliques (aléatoires), on a un résultat similaire :

#theoreme([@mathieu08self])[
  Pour des préférences acycliques aléatoires, si $G=cal(G)(n,p)$, le degré moyen étant $d=p(n-1)$, le temps moyen de convergence est en $O(log(d)+log(n))$ pour une suite Poissonnienne et en $O(log(d))$ pour une suite round-robin.
] <thm:selfconv_randomacyclic>

#demo[
  Un calcul peut montrer que pour des préférences acycliques aléatoires, environ la moitié des pairs non stables sont bouillants. Cela permet de montrer que la fin de partie est atteinte au bout de $O(log(d))$ unités de temps. Si la suite est Poisson, il faut alors rajouter $O(log(n))$ u.t. supplémentaires.
]

#remarque[
  Comme $d<n$, certains voudront que je simplifie la borne $O(log(d)+log(n))$ en $O(log(n))$, et ils auront raison. Cependant, je reste sur ma notation, parce qu'en bon physicien du pays de Pagnol, j'estime que _le grand O du $log(d)$ compte plus que le grand O du $log(n)$_ (cf @infl:density).
]

==== Autres préférences acycliques

Pour d'autres types de préférences acycliques, la clé pour estimer le temps de convergence moyen est d'arriver à estimer le nombre de pairs bouillants. Pour des préférences réelles comme celles issues de Meridian, c'est un exercice difficile. De même pour les préférences géométriques, où il existe de fortes corrélations entre les préférences de pairs proches. Notons que pour ce dernier cas, ne pas tenir compte de ces corrélations permet de se ramener au cas des préférences acycliques aléatoires, et cela marche assez bien en pratique (cette technique sera d'ailleurs abondamment utilisée dans la section suivante).

Dans _self-stabilization in preference-based systems_ @mathieu08self, je propose de regarder la distribution de la "valeur" des pairs pour déterminer si la convergence d'un système est plus proche de celle des préférences globales ou de celle des préférences acycliques. Si certains pairs sont bien classés par beaucoup de leurs voisins (ce sont donc des "bons" pairs), la convergence devrait ressembler à celle des préférences globales ($O(d)$ ou $O(d+log(n))$). Par contre, si aucun bon pair ne se dégage (les pairs ont à peu près tous la même valeur), la convergence devrait être de type acyclique aléatoire ($O(log(d))$ ou $O(log(d)+log(n))$).

Je suggère d'utiliser cette règle empirique (tout réseau à préférences acycliques a un comportement entre celui des préférences acycliques aléatoires et celui des préférences globales, le curseur étant positionné par la distribution des valeurs) pour tous les types de préférences acycliques, par exemple pour des combinaisons linéaires de préférences. Et aussi pour des graphes d'acceptabilité et des quotas quelconques. Hélas, je n'ai pas de preuve théorique à apporter. Heureusement, pour tout ce que je ne peux pas prouver, il y a les simulations.

=== Simulations <sec:setup>

Au-delà des résultats purement théoriques, je propose les simulations pour compléter la compréhension de la convergence des préférences acycliques. C'est une approche que j'affectionne tout particulièrement quand un système qui dépend de quelques paramètres ne peut pas être analysé entièrement : faire varier les paramètres un par un afin de se forger une intuition sur l'influence de chacun de ces paramètres. Tous les résultats présentés ici viennent de l'article _self-stabilization in preference-based systems_ @mathieu08self, dans lequel j'invite le lecteur soucieux des détails techniques à se plonger.

==== Initiative _meilleur partenaire_ <infl:density>

Pour commencer, regardons la convergence sous l'initiative _meilleur partenaire_, qui a été abondamment étudiée au début de cette section. Des quotas supérieurs à $1$ seront utilisés pour voir comment les résultats vus pour $b=1$ s'appliquent pour $b >= 1$.

*Taille du voisinage acceptable* 

Afin de comprendre l'influence du nombre de voisins, on fixe $n$ et l'on fait varier $d=p(n-1)$ ($G$ est toujours supposé Erdős-Rényi). On observe deux principaux comportements :
- Pour les préférences globales, le temps de convergence croît de manière linéaire ; la suite round-robin est plus rapide que la suite Poissonnienne sauf lorsque $d$ est proche de $n$ ;
- pour les autres préférences étudiées, le temps de convergence croît d'une manière qui semble logarithmique ; la suite round-robin est toujours plus rapide que la suite Poissonnienne ; les deux préférences les plus rapides (acycliques aléatoires et géométriques) sont quasi-impossibles à différencier.

*Taille du système* <infl:nodes>

Considérons maintenant des systèmes où l'on fait varier $n$, à $d$ constant. Les résultats sont les suivants :
- Le temps de convergence augmente avec $n$ pour les suites Poissonniennes. C'est l'effet _fin de partie_ en $O(log(n))$ ;
- pour les suites round-robin, le temps de convergence augmente sensiblement moins. Il y a même une légère décroissance au niveau des préférences globales pour $n$ proche de $d$ ;
- excepté pour le cas ci-dessus (préférences globales, $n$ proche de $d$), les séquences Poissonniennes sont plus longues que les séquences round-robin ;
- comme pour l'expérience précédente, les préférences acycliques et géométriques convergent le plus vite, suivies des préférences Meridian et enfin, relativement loin, des préférences globales.

La principale leçon à retenir de ces simulations reste que à $d$ fixé, $n$ a relativement peu d'effet sur le temps de convergence. "Le grand $O$ du $d$ est plus important que le grand $O$ du $n$".

*Quotas de collaborations*

Comme pour les autres paramètres, le rôle des quotas dans le temps de convergence dépend du type de préférences :
- Pour les préférences globales, le temps de convergence croît d'abord vite puis lentement (les premiers quotas coûtent le plus cher) ; les suites Poissonniennes sont légèrement plus rapides ;
- pour les autres préférences, on note une croissance linéaire ou quasi-linéaire, les suites round-robin étant légèrement plus rapides.

*Récapitulatif*

En résumé, les préférences globales se distinguent par un temps de convergence linéaire par rapport au degré moyen, ce qui fait de $d$ le principal paramètre à considérer pour la convergence. Les quotas $b$ ont une influence plus faible, surtout une fois les premières valeurs passées (plus il y a de connexions, moins une nouvelle connexion prend de temps).

Pour les autres préférences, où il n'y a pas vraiment de "bons" pairs, c'est quasiment l'inverse : la convergence est proportionnelle aux quotas (chaque connexion coûte le même prix en temps que la précédente), mais seulement logarithmique par rapport à la taille du voisinage.

==== Initiatives aléatoires et hybrides <sec:initiative>

La plupart des travaux que j'ai effectués jusqu'à présent portent sur l'initiative _meilleur partenaire_, car c'est une initiative déterministe, ce qui simplifie son étude. Pour conclure cette discussion sur la convergence, j'aimerais évoquer un peu l'initiative _aléatoire_, qui sera je pense un sujet très intéressant à étudier pour de futurs travaux.

Une initiative _aléatoire_ est beaucoup moins coûteuse en messages de contrôle qu'une initiative _meilleur partenaire_, car il est inutile de connaître les rangs et partenaires de ses voisins pour la pratiquer. En contre-partie, elle augmente le temps de convergence : alors qu'un pair bouillant stabilise nécessairement une arête en prenant une initiative _meilleur partenaire_, ce n'est plus le cas en initiative aléatoire.

Cependant, il n'y a pas que le temps requis pour une convergence complète qui compte. Le temps nécessaire pour atteindre _d'assez bonnes_ configurations (pour un certain sens) est au moins aussi important.

Par exemple, il est possible de mesurer une satisfaction des pairs dans une configuration donnée (cf @mathieu08self pour une description détaillée) et d'observer comment cette satisfaction évolue au cours du processus de convergence. Pour des préférences non-globales (géométriques, aléatoires ou Meridian) et des mêmes conditions initiales, l'initiative _meilleur partenaire_ produit à chaque instant une satisfaction meilleure que l'initiative aléatoire. En revanche, la situation est beaucoup moins tranchée si les préférences sont globales : d'un côté, l'initiative aléatoire n'a besoin que de quelques u.t. pour créer une forte satisfaction, mais elle peine ensuite à atteindre la satisfaction stable ; de l'autre, l'initiative _meilleur partenaire_ a une croissance initiale beaucoup plus faible et ne dépasse que tardivement la satisfaction de l'initiative aléatoire, mais elle converge ensuite rapidement.

L'intérêt de cet exemple est de montrer qu'en plus d'être moins coûteuse, il y a des cas (les préférences globales en l'occurrence) où l'initiative aléatoire peut s'avérer plus efficace : avoir une convergence initiale très forte, même si la convergence finale est lente, peut être très avantageux pour un système soumis à forte agitation (et où il est donc illusoire d'essayer d'atteindre une convergence complète). Je me permets au passage de remarquer que le protocole BitTorrent, qui peut de manière très grossière être assimilé à un système à préférences globales soumis à agitation, utilise l'initiative aléatoire, plus connue ici sous le nom d'_optimistic unchoking_.

Je propose l'interprétation suivante (toujours tirée de @mathieu08self) pour expliquer cette différence dans les convergences, pour les préférences globales : en initiative _meilleur partenaire_, tout le monde essaie les "bons" pairs. En particulier, les mauvais pairs vont continuellement essayer les meilleurs pairs non-stabilisés. Ces derniers se stabilisent très vite (ils sont chauds), ce qui casse leurs mauvaises connexions. Le résultat est une sorte de front de convergence (ou front de saturation) qui évolue temporellement des meilleurs aux pires pairs, les pairs étant stabilisés après le passage du front, mais n'ayant peu ou pas de connexions avant. En particulier, un mauvais pair n'arrive pas à conserver ses partenaires avant la convergence complète du système. À l'inverse, l'initiative aléatoire ne crée pas de front de saturation, mais une sorte de convergence uniforme de la satisfaction : les mauvais pairs peuvent choisir de mauvais partenaires, ce qui fait que leur connexions intermédiaires durent plus longtemps.

Les avantages des initiatives _aléatoire_ et _meilleur partenaire_ peuvent se combiner dans des initiatives hybrides. Je propose par exemple une initiative où chaque pair fonctionne en initiative aléatoire en dessous d'un certain nombre de partenaires, et bascule en _meilleur partenaire_ au-delà. Les bons pairs convergent quasiment aussi vite qu'en _meilleur partenaire_, suivant un front de saturation, mais les pairs situés devant le front ont quand même une bonne satisfaction due à la composante aléatoire qui se déclenche dès qu'il n'y a pas assez de partenaires. Au final, l'initiative hybride se comporte bien quelles que soient les préférences acycliques (pas seulement pour les préférences globales donc), aussi bien en convergence initiale que complète, ce qui en fait un choix intéressant, en particulier pour des systèmes acycliques où la nature exacte des préférences est inconnue ou variable.

#import "../templates/prelude.typ": *

== Les bases <sec:bases>

L'objet de cette section est de présenter le domaine des réseaux à préférences, dans ses grandes lignes, damé et balisé après trois années de tâtonnements : les notations et définitions, telles qu'elles se sont stabilisées au fil du temps (@subsec:notation) ; le grand théorème des préférences acycliques, qui malgré sa simplicité est la colonne vertébrale du modèle (@subsec:main_therorem) ; et enfin, la zoologie des préférences acycliques, qui permet de voir comment relier le modèle à des situations réelles (@subsec:classes).

=== Notations et définitions <subsec:notation>

Comme indiqué dans l'introduction, les réseaux à préférences sont issus de la théorie des $b$-couplages @fleiner05generalization @diamantoudi04random, et les notations s'en ressentent, même si un sous-vocabulaire spécifique a été introduit au fil des travaux @lebedev07using @gai07stratification @gai07acyclic @mathieu07upper @mathieu08self. En ce qui concerne la version française en particulier, le vocabulaire souvent imagé doit beaucoup à l'article de vulgarisation _Mariages Stables_ de Dominique Dumont @dumont99mariages.

Ainsi, une instance de réseau à préférences est constituée d'un ensemble de pairs, d'un graphe d'acceptabilité, de préférences et de quotas. Une configuration est un ensemble d'interactions, dont la dynamique est décrite par des initiatives de pairs.

==== Réseau à préférences <subsubsec:pbs_def>

Le réseau à préférences lui-même est donc constitué d'un ensemble $P$ de $n$ pairs (ou nœuds) et d'un graphe $G=(P,E)$. Les préférences sont indiquées par une matrice de valeurs $m$ et les quotas par un vecteur $b$.

Le graphe d'acceptabilité $G=(P,E)$ est un graphe non-orienté et non réflexif. Il décrit les compatibilités : deux pairs $i$ et $j$ peuvent interagir si, et seulement si, (ssi) ${i,j} in E$. On dit alors que $i$ est _acceptable_ pour $j$, et réciproquement. Par exemple, $G$ peut représenter la connaissance des autres pairs (il est rare qu'un pair connaisse tous les autres pairs d'un réseau, sa vision est généralement limitée à un certain nombre de _voisins_), ou encore l'existence d'un intérêt commun (la recherche d'un même fichier, l'appartenance à un même groupe, …), ou tout simplement une structure _overlay_ imposée. Le graphe $G$ peut a priori être quelconque, cependant nous userons souvent dans ce chapitre des graphes Erdős-Rényi $cal(G)(n,p)$, où chaque arête existe avec probabilité $p$ indépendamment des autres (le degré moyen est ainsi $d=p(n-1)$). Ce choix est justifié par les facilités qu'offrent les graphes $cal(G)(n,p)$ quant à l'analyse théorique des propriétés des réseaux à préférences.

La matrice de valeurs $m$ indique l'intérêt que les pairs ont les uns envers les autres. Elle détermine ainsi les préférences. Pour toute paire acceptable de pairs ${i,j} in E$, $m(i,j)$ est la valeur que $i$ donne à $j$. Sauf indication contraire, on considère que les basses valeurs sont préférées#footnote[Ce choix est purement conventionnel et n'affecte aucunement les résultats présentés ici. Il est naturel lorsque l'on considère des latences ou des distances. Dans le cas de valeurs comme la bande passante, ou plus généralement dans le cas de capacités, cela serait plutôt l'inverse.]. Ainsi, $m(i,j) < m(i,k)$ signifie que $i$ préfère $j$ à $k$. Une hypothèse que l'on fait tout au long de ce chapitre est qu'il n'y a jamais d'égalité, c'est-à-dire que pour chaque ligne de $m$, les valeurs acceptables sont deux à deux distinctes#footnote[Les cas d'égalités dans les préférences sont une source de problèmes que je ne tiens pas à évoquer dans ce chapitre @irving00hospitals @irving02stable @iwama99stable @manlove02hard @manlove02structure @ronn86complexity. On supposera donc qu'une égalité peut toujours être brisée, par exemple en attribuant à chaque pair un identifiant unique afin de départager toute ambiguïté.].
La matrice $m$ peut posséder certaines propriétés particulières qui seront décrites en @subsec:classes. Je précise également que s'il est toujours possible, et pratique, de supposer l'existence d'une matrice de valeurs $m$, cela n'est pas indispensable d'un point de vue théorique, car seuls les ordres (les préférences) induits par $m$ importent @gai07acyclic @abraham07stable. Il n'est pas nécessaire que les pairs connaissent $m$. Dans le pire des cas, il est même possible qu'un pair ne connaisse pas les valeurs de sa propre ligne. Cependant, afin de garder un sens au concept de matrice de valeurs, on suppose qu'il est toujours possible pour un pair de comparer les valeurs de deux voisins en les contactant, par exemple au cours d'une _initiative_ (voir plus loin).

Enfin, le vecteur des quotas, $b$, limite le nombre de collaborations : un pair $i$ ne peut collaborer avec plus de $b(i)$ voisins simultanément. On peut bien sûr toujours supposer que $b(i)$ n'est pas plus grand que le degré de $i$ dans $G$. Tout comme $G$ est souvent supposé Erdős-Rényi, $b$ est généralement supposé constant lorsque l'on veut analyser un réseau, même si toute distribution est autorisée a priori.

==== Configurations <subsec:definit>

La configuration d'un système décrit l'état des collaborations. Formellement, une configuration $C$ est un sous-ensemble de $E$. Les voisins $C(i)$ de $i$ dans $C$ sont les _partenaires_ actuels de $i$. Si $c(i)$ désigne le nombre de partenaires de $i$ dans $C$, les quotas impliquent $c(i) <= b(i)$. Si $c(i) < b(i)$, on dit que $i$ est _sous-couplé_.

Une configuration peut évoluer par la résolution d'arêtes _adultères_ (le terme est un hommage à la théorie originale des mariages). Une arête acceptable $e$ est adultère pour une configuration $C$ si elle n'appartient pas à $C$ et si chaque pair de l'arête a intérêt à établir la collaboration $e$, même si cela implique d'abandonner une collaboration de $C$ pour satisfaire les quotas. Formellement, une arête $e={i,j} in E without C$ est adultère ssi :
- $c(i) < b(i)$ ($i$ est sous-couplé), ou bien $exists k in C(i), m(i,j) < m(i,k)$ ($i$ préfère $j$ à l'un de ses partenaires) ;
- $c(j) < b(j)$ ou bien $exists k in C(j), m(j,i) < m(j,k)$ (condition symétrique).

Un pair qui est adjacent à au moins une arête adultère est _éligible_ (il est susceptible de modifier la configuration). Une configuration qui ne possède pas d'arête adultère (ou de manière équivalente pas de pair éligible) est _stable_.

==== Initiatives

Les arêtes adultères sont à la base de la dynamique des configurations. Plus précisément, l'évolution vient toujours d'un pair éligible qui essaie de résoudre une arête adultère à laquelle il appartient. Ce processus, supposé atomique, est appelé _initiative_. Une initiative est _active_ si elle se traduit par la résolution d'une arête adultère.

Formellement, l'initiative est une "fonction" de sélection (qui peut dépendre du temps, de l'état du système, être aléatoire, …) qui associe à chaque pair $i$ de $V$ un voisin à "essayer", ou plus formellement une arête de $E without C$ incidente à $i$. Si par défaut, l'ensemble de ces arêtes peuvent être considérées par cette fonction de sélection, dans le cas où les pairs ont la connaissance des arêtes adultères auxquelles ils appartiennent, il est possible de restreindre la sélection à ces seules arêtes.

Des exemples d'initiatives sont la sélection _meilleur partenaire_ (parmi les arêtes adultères), _décrémentale_ (choix en _round-robin_ parmi la liste des voisins), ou simplement aléatoire.
Remarquons que les différents types de sélection nécessitent, de manière implicite, plus ou moins de connaissances : ainsi, _meilleur partenaire_ et _décrémentale_ nécessitent d'être capable de trier ses voisins (et même de repérer les arêtes adultères pour la première), alors qu'une sélection purement _aléatoire_ nécessite juste d'être capable d'évaluer un voisin à la volée.
Enfin, il est toujours possible d'hybrider plusieurs sélections afin d'obtenir une sélection plus performante. Un exemple de sélection _hybride_ sera décrit en @subsec:self_expected (d'après @mathieu08self).

Partant d'une configuration initiale donnée, l'évolution d'un système est donc décrite par la suite des initiatives réalisées par les pairs. Une suite classique est la suite _Round-Robin_, adaptée pour modéliser un comportement mono-périodique des pairs, ou la suite _uniformément aléatoire_, utilisée pour modéliser un processus Poissonien homogène (chaque pair suit un processus de Poisson i.i.d.). Enfin, il y a les suites _adversariales_, qui essaient de se comporter de la "pire" façon possible.

Par commodité, le temps est directement mesuré à l'aune de la suite des initiatives (il n'est ainsi pas nécessaire d'introduire explicitement des processus temporels d'initiatives). Il est malgré tout possible de considérer plusieurs mesures suivant le contexte que l'on considère. Par exemple, si l'on se place dans le contexte de l'auto-stabilisation au sens de Dijkstra @dijkstra74self, on comptera seulement les initiatives actives, et les suites seront découpées en _rounds_ (un round est une sous-suite telle que chaque pair éligible au début du round prend une initiative ou devient non-éligible au cours de ce round). Pour les simulations, je préfère définir l'unité de temps (u.t.) par $n$ initiatives (actives ou non). Ainsi, chaque initiative atomique prend $1/n$ u.t., et au bout de $t$ u.t., le nombre d'initiatives par pair est en moyenne de $t$. Lorsque la suite d'initiatives est round-robin, round et unité de temps peuvent être considérés comme synonymes, mais ce n'est pas vrai dans le cas général.

==== Stabilité locale

La notion d'initiative entraîne une définition alternative de la stabilité : une configuration $C$ est stable si la seule configuration atteignable par initiatives à partir de $C$ est $C$ elle-même. Il est facile de vérifier que pour des initiatives arbitraires, cette définition est équivalente à celle donnée en @subsec:definit (pas d'arête adultère). L'intérêt d'une approche au sens des initiatives de la stabilité est qu'elle permet une définition locale : une arête $e$ d'une configuration $C$ est _stable_ ssi $e$ existe dans toutes les configurations atteignables à partir de $C$. Écrit autrement, une arête stable est une collaboration que les initiatives ne peuvent rompre.

Lorsqu'un pair est incident à une arête stable, son degré de liberté s'en trouve diminué. Le quota libre d'un pair $i$, noté $b'(i)$, est le quota $b(i)$ auquel l'on retranche le nombre d'arêtes stables incidentes à $i$. Les quotas libres forment un vecteur qui est fonction de la configuration et qui ne fait que décroître avec le temps. Il est ainsi possible d'étendre la définition de stabilité au niveau des pairs : un pair $i$ est _stable_ (ou _inactivé_) si $b'(i)=0$ ou si $i$ partage une arête stable avec tous ses voisins non-stables.

Enfin, une dernière notion fondamentale à propos de la stabilité est celle de _chaleur_. Dans une configuration donnée $C$, une arête $e={i,j}$ acceptable mais hors de $C$ ($e in E without C$) est chaude ssi :
- $j$ appartient aux $b'(i)$ meilleurs voisins non-stables de $i$,
- $i$ appartient aux $b'(j)$ meilleurs voisins non-stables de $j$.
Il existe de même une définition plus stricte de la chaleur : une arête acceptable $e={i,j}$ entre deux pairs non-stables qui ne collaborent pas est dite bouillante pour $C$ ssi $i$ est le meilleur voisin non-stable de $j$ et vice versa.

Par extension, un pair sera dit chaud (resp. bouillant) s'il est adjacent à une arête chaude (resp. bouillante).

Intuitivement, les arêtes chaudes, et plus encore bouillantes, sont des arêtes super-adultères, qui n'attendent qu'une initiative bien placée pour devenir des arêtes stables. Elles jouent un rôle central dans les réseaux à préférences acycliques, à cause du @lemma:hot, qui est utilisé dans beaucoup de démonstrations :

#lemme([@lebedev07using@gai07acyclic])[
  Si $C$ est une configuration non-stable d'un réseau à préférences acycliques, alors il existe au moins une arête bouillante par rapport à $C$.
] <lemma:hot>

Bien évidemment, ce lemme n'a de sens qu'une fois définie la notion d'acyclicité. C'est d'ailleurs l'objet du reste de cette section sur les bases des réseaux à préférences.

=== Grand théorème des préférences acycliques <subsec:main_therorem>

Un _cycle de préférences_, ou _cycle de Kieschnick_, est un cycle de $k >= 3$ pairs $i_1, dots, i_k$ tel que chaque pair préfère son successeur à son prédécesseur : $i_1$ préfère $i_2$ à $i_k$, $i_2$ préfère $i_3$ à $i_1$, …, $i_k$ préfère $i_1$ à $i_(k-1)$ (ou encore, exprimé en terme de valeurs, $m(i_1,i_2) < m(i_1,i_k)$, $m(i_2,i_3) < m(i_2,i_1)$, …, $m(i_k,i_1) < m(i_k,i_(k-1))$).

L'objet principal de ce chapitre est les réseaux à préférences acycliques, c'est-à-dire qui ne contiennent pas de cycle de Kieschnick. Remarquons que l'acyclicité est entièrement définie par $m$, et qu'elle ne dépend ni des quotas, ni des initiatives. De même, si $m$ produit des préférences acycliques pour une acceptabilité complète, alors le réseau sera acyclique pour tout graphe d'acceptabilité $G$. Par convention, une telle matrice de valeurs $m$ est également appelée acyclique. Une classification des matrices acycliques, et le lien avec les systèmes P2P, sont proposés en @subsec:classes.

Les réseaux à préférences acycliques sont caractérisés par une propriété qui les rend uniques au sein des réseaux à préférences :

#theoreme([@gai07acyclic])[
  Un réseau à préférences acycliques admet une, et une seule, configuration stable. De plus, il est auto-stabilisant par initiatives.
] <thm:big_convergence_theorem>

#demo[
  La preuve complète est disponible dans @gai07acyclic, mais j'en donne ici l'idée, à cause de l'importance de ce théorème et du caractère typique des techniques employées. L'on va ici procéder en deux étapes : d'abord montrer l'auto-stabilisation (ce qui prouvera l'existence d'une configuration stable), puis l'unicité.

  L'auto-stabilisation vient de la propriété suivante : quelque soit la suite d'initiatives considérée et la configuration de départ, la suite des configurations correspondantes est irréversible. C'est-à-dire que si le système se trouvait dans une configuration $C_1$ dans le passé et se trouve dans une configuration $C_2 != C_1$, alors $C_1$ n'est pas atteignable à partir de $C_2$. L'irréversibilité se démontre par l'absurde, en extrayant un cycle de Kieschnick à partir d'un cycle de configurations. Comme $n$ est supposé fini, le nombre de configurations possibles l'est également, ce qui veut dire que toute trajectoire de configurations débouche nécessairement sur une configuration qui n'évolue plus, i.e. une configuration stable.

  L'unicité se prouve également par contradiction : si l'on considère deux configurations stables distinctes $A$ et $B$ d'un même système, et un pair $i$ dont les collaborations diffèrent de $A$ à $B$, alors on peut construire un cycle de Kieschnick en partant de $i$ (même si $i$ n'appartient pas nécessairement au cycle que l'on obtient au final).
]

#subfig(
  figure(image("../figures/no_churn.pdf"), caption: [Cas statique]),
  <fig:nochurn>,
  figure(image("../figures/healing.pdf"), caption: [Altération atomique]),
  <fig:healing>,
  figure(image("../figures/churn.pdf"), caption: [Agitation continue]),
  <fig:churn>,
  columns: (1fr, 1fr),
  caption: [L'auto-stabilisation en pratique (d'après @gai07stratification).],
  label: <fig:healingchurn>,
)

J'insiste encore une fois sur le caractère fondamental de ce théorème d'existence/unicité/auto-stabilisation, car il permet de s'affranchir de l'étude de stabilité faite pour les autres types de préférences, et de se concentrer plus finement sur les configurations proprement dites.

La première application de ce théorème est apparue dans l'article _Stratification#footnote[Beaucoup de personnes me demandent pourquoi _stratification_, au lieu de _clusterisation_ par exemple. Et bien tout d'abord, parce que _clusterisation_ est déjà sémantiquement surchargé en informatique ; ensuite parce que l'image des strates est au moins aussi parlante ; enfin parce que le mot est joli.] in P2P Networks: Application to BitTorrent_ @gai07stratification. Dans cet article, qui cherchait à modéliser un réseau BitTorrent comme un réseau à préférences acycliques (j'en parlerai plus en détail dans la suite du chapitre), nous avons mesuré la convergence effective entre configuration réelle et stable. Afin d'estimer l'importance pratique de l'auto-stabilisation, nous avions considéré trois types de scénarios (cf @fig:healingchurn) :

/ Statique (@fig:nochurn): Partant de la configuration vide (souvent notée $C_emptyset$), nous avons observé la convergence vers la configuration stable. Nous avons pu observer une bonne convergence dans tous les cas, tout en remarquant que les paramètres du système, et le degré moyen du graphe d'acceptabilité en particulier, jouaient un rôle majeur ;

/ Altération atomique (@fig:healing): Un deuxième scénario élémentaire consiste à enlever un pair à partir d'une configuration stable (ce qui modifie la configuration stable), et refaire converger le système. On observe que la configuration réelle ne s'éloigne guère de la configuration stable, et finit par re-converger, même si à cause d'un éventuel effet domino, il se peut que le temps de convergence soit comparable au cas statique.

/ Agitation continue (_Continuous churn_) (@fig:churn): Enfin, un troisième scénario consiste à faire partir et arriver des pairs dans le système selon une certaine intensité. Ce scénario permet de constater que la configuration réelle n'arrive pas toujours à rattraper l'évolution de la configuration stable, surtout quand l'agitation est extrême. Cependant, l'auto-stabilisation fait en sorte que la configuration réelle reste malgré tout assez proche de la configuration stable, la _distance_ entre les deux étant grossièrement proportionnelle à l'agitation.

À la suite de cette étude, j'ai commencé à travailler en partant du principe qu'à la condition que la convergence du système soit suffisamment grande devant l'évolution de celui-ci, la configuration stable devait être une bonne approximation des configurations réelles. C'est l'image du _ressort_ (cf @fig:spring). Cette image nous suggère de décomposer l'étude des systèmes à préférences acycliques en deux problèmes distincts :

#figure(
  image("../figures/spring.pdf", width: 10cm),
  caption: [L'image du ressort : l'auto-stabilisation peut être vu comme une attirance continue de la configuration actuelle vers la configuration stable, comme si un ressort reliait ces deux configurations. Ce principe vaut même si la configuration stable bouge dans le temps.],
) <fig:spring>

/ Quelle est la vitesse de convergence ?: En effet, le @thm:big_convergence_theorem ne nous donne que le nombre de configurations possibles comme borne. Ce nombre croît de manière factorielle @chowla50asymptotic et offre donc un intérêt pratique assez limité. Une première zone d'étude consiste donc à caractériser plus finement la _raideur_ effective du ressort.

/ Quelles sont les propriétés des configurations stables ?: La question précédente doit permettre de déterminer dans quelle mesure une configuration stable est une bonne approximation d'une configuration réelle. Quand c'est le cas, les propriétés génériques des solutions stables peuvent permettre d'estimer les performances du système.

Ces deux questions vont faire l'objet des deux prochaines sections de ce chapitre. Mais avant d'y répondre, je propose de regarder d'un peu plus près ces préférences acycliques dont je n'ai jusqu'à présent donné qu'une définition sommaire et peu pratique.

=== Zoologie des préférences acycliques <subsec:classes>

Parmi toutes les matrices réelles possibles, peu sont acycliques. En fait, si l'on prend une matrice dont les coefficients sont choisis au hasard, il est très probable que les préférences qui en résultent contiennent au moins un cycle de longueur $3$#footnote[La probabilité que trois pairs mutuellement acceptables forment un cycle est de $1/4$, pour des valeurs aléatoires uniformes. La probabilité de ne pas avoir de tel cycle est donc au plus de $(3/4)^(binom(n,3))$ (si l'on néglige de possibles corrélations), ce qui ne vaut pas grand chose dès que $n$ est assez grand.].
D'un autre côté, beaucoup de propriétés matricielles sont synonymes d'acyclicité. Par exemple (@gai07acyclic) :

/ Matrices globales: Une matrice de valeurs $m$ est globale si toutes ses lignes sont identiques si l'on se restreint aux entrées acceptables. Intuitivement, c'est un cas particulier de matrice de rang $1$, et formellement, on a $m(i,k) = m(j,k)$ pour tous les $i,j$ qui acceptent $k$. Les préférences correspondantes, également appelées globales, reflètent un ordre total sur les pairs. On peut d'ailleurs remarquer qu'à cause de cet ordre total, on peut dire qu'à acceptabilité et permutation des pairs près, il n'y a qu'une seule préférence globale.

/ Matrices symétriques: Si $m$ est symétrique sur ses entrées acceptables ($m(i,j) = m(j,i)$ pour toute paire acceptable) $m$ est acyclique. Une propriété intéressante des matrices symétriques est qu'elles décrivent l'ensemble des préférences acycliques (cf @gai07acyclic @abraham07stable). Le lien entre matrices acycliques, symétriques, globales, et les préférences correspondantes est illustré @fig:classes#footnote[La @fig:classes est bien sûr incomplète. Il manque par exemple les combinaisons linéaires en général, et les matrices complémentaires en particulier, ainsi que la génération de l'ensemble des préférences acycliques par des permutations des entrées d'une matrice symétrique à coefficients distincts. Mais la lisibilité graphique s'en trouverait affectée.].

/ Combinaison linéaire de matrices globales et symétriques: Les matrices obtenues sont acycliques tant qu'elles ne génèrent pas d'égalité (mais comme indiqué en @subsubsec:pbs_def, il est toujours possible de s'affranchir des cas d'égalité). En revanche, une combinaison linéaire de matrices acycliques n'est pas forcément acyclique : si les matrices d'entrée ne sont pas déjà elles-mêmes combinaison linéaire de matrices symétriques et globales, il faut les symétriser, ce qui se fait assez facilement car la preuve de surjection des matrices symétriques dans les préférences acycliques est constructive (cf @gai07acyclic @abraham07stable).

#figure(image("../figures/classes.pdf", width: 10cm), caption: [Correspondances entre matrices et préférences : les matrices symétriques et globales forment deux sous-ensembles distincts de matrices acycliques, mais les matrices symétriques peuvent décrire l'ensemble des préférences acycliques (ce qui inclut les préférences globales).]) <fig:classes>

==== Préférences adaptées au P2P

Après avoir esquissé ce qui fait que des préférences sont acycliques, je propose maintenant de nous recentrer dans le contexte du pair-à-pair, et de considérer les préférences pair-à-pair acycliques.

/ Capacités: Un pair dans un réseau P2P possède de nombreuses caractéristiques scalaires intrinsèques qui peuvent créer des préférences : bande passante d'accès, capacité de stockage ou de calcul, _uptime_ moyen, … Si l'on prend l'exemple du protocole de partage de fichiers BitTorrent @cohen03incentives, un algorithme _donnant-donnant_ fait qu'un pair tend à collaborer de préférence avec ses voisins qui lui fournissent la plus grande vitesse de téléchargement. Cela peut être vu en première approximation comme un réseau à préférences où la valeur est la bande passante d'émission divisée par le quota (le nombre d'émissions simultanées).

/ Proximités: Toutes les valeurs qui peuvent être assimilées à une sorte de distance (physique ou virtuelle) ou de similarité sont symétriques par nature. Ainsi, beaucoup de systèmes P2P essaient de minimiser les latences#footnote[Se pose bien sûr la question de savoir si les latences sont des distances, ou même symétriques. Quoiqu'il en soit, empiriquement, elles ne produisent pas de cycle de Kieschnick.], comme par exemple la DHT Pastry @pastry ou les applications de jeu en ligne en temps réel @syncms. De même, les jeux massivement multi-joueurs en ligne (MMOG) doivent connecter ensemble les joueurs proches dans un certain espace virtuel @keller03simon @mmog @solipsis. Certains auteurs proposent également de connecter les participants d'un système de partage de fichiers en fonction de leurs intérêts communs @sripanidkulchai03efficient @fessant04clustering, ce qui reste une mesure symétrique. Le _co-uptime_, c'est-à-dire le temps (moyen) d'activité commune, est un dernier exemple de mesure symétrique ayant un intérêt pour des applications collaboratives.

/ Complémentarités: La mesure des différences entre les ressources des participants peut également s'avérer intéressante. Par exemple, dans une application de stockage distribué de fichiers, il est utile de trouver des machines qui sont allumées quand ma propre machine est éteinte, afin de garder mes données disponibles à tout moment. La mesure correspondante est l'uptime complémentaire. De même, dans un système comme BitTorrent, tous les participants cherchent à avoir le même fichier, qui est divisé en blocs#footnote[Il paraît même que parfois, certains blocs pourraient être plus rares que d'autres @mathieu06missing.]. Trouver les voisins qui ont le plus de blocs que je n'ai pas encore obtenus a un intérêt. Toutes ces préférences dites complémentaires sont un cas particulier de combinaison linéaire d'une matrice globale et d'une matrice symétrique, et sont donc acycliques @gai07acyclic.

==== Classes de préférences étudiées

Comme nous venons de le voir, il existe de nombreuses préférences acycliques présentant un intérêt du point de vue du P2P. Au cours de mes travaux, je me suis concentré sur quatre classes de préférences acycliques, ce qui évite de se disperser dans un labyrinthe de cas particuliers tout en donnant une idée précise des liens entre préférences et propriétés des systèmes.

/ Globales: Bien que représentant un sous-ensemble négligeable (en terme de cardinalité) des préférences acycliques, les préférences globales sont parmi les plus importantes des préférences acycliques (elles modélisent les capacités), et doivent recevoir une attention particulière. Comme il n'existe en fait qu'un unique système de préférences globales, induit par un ordre total sur les pairs, j'utiliserai cet ordre au lieu d'expliciter la matrice des valeurs $m$. Les pairs seront ainsi étiquetés de $1$ à $n$, $1$ étant le _meilleur_ (il est préféré par tous ses voisins acceptables), et ainsi de suite…

/ Géométriques: Pour des préférences issues de distances, les propriétés des préférences dépendent grandement de la manière dont les points sont positionnés dans l'espace sous-jacent. On peut d'ailleurs facilement montrer que toutes les préférences acycliques peuvent être générées en plaçant les $n$ pairs aux sommets d'un simplexe et en le perturbant (en bougeant légèrement les sommets) de manière adéquate. Malgré tout, l'expérience semble montrer que certaines caractéristiques se retrouvent fréquemment. Pour se donner des préférences de proximité typiques et analysables, je propose de considérer les préférences obtenues en considérant les distances prises entre $n$ points au hasard sur un $t$-tore unitaire de dimension $t$ ($t >= 1$).

/ Latences réelles: Avoir des mesures réelles pour valider les résultats est bien évidemment nécessaire, même si l'analyse théorique devient alors difficile. Pour $n <= 2500$, j'utilise, pour contrôler la validité de certains résultats géométriques, des sous-ensembles de taille $n$ extraits du jeu de données du projet Meridian @meridianproject. Les valeurs sont les latences (symétriques) entre les nœuds sélectionnés.

/ Acycliques aléatoires: Une dernière classe de préférences est obtenue en attribuant à chaque arête acceptable une valeur aléatoire uniforme comprise entre $0$ et $1$. J'appelle les préférences qui en résultent _acycliques aléatoires_ (ou simplement acycliques quand il n'y a pas d'ambiguïté), car on peut montrer que cette approche produit un échantillonnage uniforme sur l'ensemble des préférences acycliques possibles @gai07acyclic @abraham07stable.

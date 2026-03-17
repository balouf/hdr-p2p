#import "../templates/prelude.typ": *

== Foundations <sec:bases>

The purpose of this section is to present the field of preference-based networks, in broad strokes, paved and marked out after three years of exploration: the notations and definitions, as they have stabilized over time (@subsec:notation); the grand theorem of acyclic preferences, which despite its simplicity is the backbone of the model (@subsec:main_therorem); and finally, the taxonomy of acyclic preferences, which shows how to relate the model to real-world situations (@subsec:classes).

=== Notations and definitions <subsec:notation>

As mentioned in the introduction, preference-based networks originate from the theory of $b$-matchings @fleiner05generalization @diamantoudi04random, and the notation reflects this, even though a specific sub-vocabulary has been introduced over the course of various works @lebedev07using @gai07stratification @gai07acyclic @mathieu07upper @mathieu08self. Regarding the French version in particular, the often colorful vocabulary owes much to Dominique Dumont's popular science article _Mariages Stables_ (Stable Marriages) @dumont99mariages.

Thus, an instance of a preference-based network consists of a set of peers, an acceptability graph, preferences, and quotas. A configuration is a set of interactions, whose dynamics are described by peer initiatives.

==== Preference-based network <subsubsec:pbs_def>

The preference-based network itself thus consists of a set $P$ of $n$ peers (or nodes) and a graph $G=(P,E)$. Preferences are indicated by a value matrix $m$ and quotas by a vector $b$.

The acceptability graph $G=(P,E)$ is an undirected and non-reflexive graph. It describes compatibilities: two peers $i$ and $j$ can interact if, and only if, (iff) ${i,j} in E$. We then say that $i$ is _acceptable_ for $j$, and vice versa. For example, $G$ can represent knowledge of other peers (it is rare for a peer to know all other peers in a network; its view is generally limited to a certain number of _neighbors_), or the existence of a common interest (searching for the same file, belonging to the same group, ...), or simply an imposed _overlay_ structure. The graph $G$ can in principle be arbitrary; however, we will often use in this chapter Erdős-Rényi graphs $cal(G)(n,p)$, where each edge exists with probability $p$ independently of the others (the average degree is thus $d=p(n-1)$). This choice is justified by the facilities that $cal(G)(n,p)$ graphs offer for the theoretical analysis of preference-based network properties.

The value matrix $m$ indicates the interest that peers have in one another. It thus determines preferences. For every acceptable pair of peers ${i,j} in E$, $m(i,j)$ is the value that $i$ assigns to $j$. Unless otherwise stated, lower values are preferred#footnote[This choice is purely conventional and does not affect any of the results presented here. It is natural when considering latencies or distances. In the case of values such as bandwidth, or more generally capacities, the opposite would be more appropriate.]. Thus, $m(i,j) < m(i,k)$ means that $i$ prefers $j$ to $k$. An assumption made throughout this chapter is that there are never ties, that is, for each row of $m$, the acceptable values are pairwise distinct#footnote[Ties in preferences are a source of problems that I do not wish to discuss in this chapter @irving00hospitals @irving02stable @iwama99stable @manlove02hard @manlove02structure @ronn86complexity. We will therefore assume that ties can always be broken, for example by assigning each peer a unique identifier to resolve any ambiguity.].
The matrix $m$ may possess certain special properties that will be described in @subsec:classes. I also note that while it is always possible, and convenient, to assume the existence of a value matrix $m$, this is not essential from a theoretical standpoint, since only the orders (preferences) induced by $m$ matter @gai07acyclic @abraham07stable. It is not necessary for the peers to know $m$. In the worst case, a peer may not even know the values in its own row. However, in order to preserve the meaning of the value matrix concept, we assume that it is always possible for a peer to compare the values of two neighbors by contacting them, for example during an _initiative_ (see below).

Finally, the quota vector, $b$, limits the number of collaborations: a peer $i$ cannot collaborate with more than $b(i)$ neighbors simultaneously. One can of course always assume that $b(i)$ is no larger than the degree of $i$ in $G$. Just as $G$ is often assumed to be Erdős-Rényi, $b$ is generally assumed to be constant when analyzing a network, even though any distribution is allowed in principle.

==== Configurations <subsec:definit>

The configuration of a system describes the state of collaborations. Formally, a configuration $C$ is a subset of $E$. The neighbors $C(i)$ of $i$ in $C$ are the current _partners_ of $i$. If $c(i)$ denotes the number of partners of $i$ in $C$, the quotas imply $c(i) <= b(i)$. If $c(i) < b(i)$, we say that $i$ is _undermatched_.

A configuration can evolve through the resolution of _adulterous_ edges (the term is a tribute to the original theory of stable marriages). An acceptable edge $e$ is adulterous for a configuration $C$ if it does not belong to $C$ and if each peer of the edge has an interest in establishing the collaboration $e$, even if this means abandoning a collaboration in $C$ to satisfy the quotas. Formally, an edge $e={i,j} in E without C$ is adulterous iff:
- $c(i) < b(i)$ ($i$ is undermatched), or $exists k in C(i), m(i,j) < m(i,k)$ ($i$ prefers $j$ to one of its partners);
- $c(j) < b(j)$ or $exists k in C(j), m(j,i) < m(j,k)$ (symmetric condition).

A peer that is adjacent to at least one adulterous edge is _eligible_ (it is likely to modify the configuration). A configuration that has no adulterous edge (or equivalently no eligible peer) is _stable_.

==== Initiatives

Adulterous edges are at the basis of configuration dynamics. More precisely, evolution always comes from an eligible peer that tries to resolve an adulterous edge to which it belongs. This process, assumed to be atomic, is called an _initiative_. An initiative is _active_ if it results in the resolution of an adulterous edge.

Formally, the initiative is a selection "function" (which may depend on time, the system state, be random, ...) that assigns to each peer $i$ in $V$ a neighbor to "try", or more formally an edge of $E without C$ incident to $i$. While by default, all such edges may be considered by this selection function, in the case where peers have knowledge of the adulterous edges to which they belong, it is possible to restrict the selection to these edges only.

Examples of initiatives include _best partner_ selection (among adulterous edges), _decremental_ selection (round-robin choice among the list of neighbors), or simply random selection.
Note that the different types of selection implicitly require more or less knowledge: for instance, _best partner_ and _decremental_ require the ability to sort one's neighbors (and even to identify adulterous edges for the former), whereas a purely _random_ selection only requires the ability to evaluate a neighbor on the fly.
Finally, it is always possible to hybridize several selections to obtain a more efficient one. An example of a _hybrid_ selection will be described in @subsec:self_expected (after @mathieu08self).

Starting from a given initial configuration, the evolution of a system is thus described by the sequence of initiatives performed by the peers. A classical sequence is the _Round-Robin_ sequence, suitable for modeling single-period peer behavior, or the _uniformly random_ sequence, used to model a homogeneous Poisson process (each peer follows an i.i.d. Poisson process). Finally, there are _adversarial_ sequences, which try to behave in the "worst" possible way.

For convenience, time is measured directly in terms of the sequence of initiatives (there is thus no need to explicitly introduce temporal initiative processes). It is nevertheless possible to consider several measures depending on the context. For example, in the context of self-stabilization in Dijkstra's sense @dijkstra74self, only active initiatives are counted, and sequences are divided into _rounds_ (a round is a subsequence such that each peer eligible at the beginning of the round takes an initiative or becomes non-eligible during that round). For simulations, I prefer to define the time unit (t.u.) as $n$ initiatives (active or not). Thus, each atomic initiative takes $1/n$ t.u., and after $t$ t.u., the number of initiatives per peer is on average $t$. When the initiative sequence is round-robin, round and time unit can be considered synonymous, but this is not true in the general case.

==== Local stability

The notion of initiative leads to an alternative definition of stability: a configuration $C$ is stable if the only configuration reachable by initiatives from $C$ is $C$ itself. It is easy to verify that for arbitrary initiatives, this definition is equivalent to the one given in @subsec:definit (no adulterous edge). The interest of an initiative-based approach to stability is that it allows a local definition: an edge $e$ of a configuration $C$ is _stable_ iff $e$ exists in all configurations reachable from $C$. In other words, a stable edge is a collaboration that initiatives cannot break.

When a peer is incident to a stable edge, its degree of freedom is reduced. The free quota of a peer $i$, denoted $b'(i)$, is the quota $b(i)$ minus the number of stable edges incident to $i$. The free quotas form a vector that is a function of the configuration and that only decreases over time. It is thus possible to extend the definition of stability to the peer level: a peer $i$ is _stable_ (or _deactivated_) if $b'(i)=0$ or if $i$ shares a stable edge with all its non-stable neighbors.

Finally, a last fundamental notion regarding stability is that of _heat_. In a given configuration $C$, an acceptable edge $e={i,j}$ outside of $C$ ($e in E without C$) is hot iff:
- $j$ belongs to the $b'(i)$ best non-stable neighbors of $i$,
- $i$ belongs to the $b'(j)$ best non-stable neighbors of $j$.
There also exists a stricter definition of heat: an acceptable edge $e={i,j}$ between two non-stable peers that are not collaborating is said to be boiling for $C$ iff $i$ is the best non-stable neighbor of $j$ and vice versa.

By extension, a peer is said to be hot (resp. boiling) if it is adjacent to a hot (resp. boiling) edge.

Intuitively, hot edges, and even more so boiling ones, are super-adulterous edges that only need a well-placed initiative to become stable edges. They play a central role in acyclic preference-based networks, because of @lemma:hot, which is used in many proofs:

#lemme([@lebedev07using@gai07acyclic])[
  If $C$ is a non-stable configuration of an acyclic preference-based network, then there exists at least one boiling edge with respect to $C$.
] <lemma:hot>

Obviously, this lemma only makes sense once the notion of acyclicity has been defined. This is in fact the subject of the remainder of this section on the foundations of preference-based networks.

=== Grand theorem of acyclic preferences <subsec:main_therorem>

A _preference cycle_, or _Kieschnick cycle_, is a cycle of $k >= 3$ peers $i_1, dots, i_k$ such that each peer prefers its successor to its predecessor: $i_1$ prefers $i_2$ to $i_k$, $i_2$ prefers $i_3$ to $i_1$, ..., $i_k$ prefers $i_1$ to $i_(k-1)$ (or, expressed in terms of values, $m(i_1,i_2) < m(i_1,i_k)$, $m(i_2,i_3) < m(i_2,i_1)$, ..., $m(i_k,i_1) < m(i_k,i_(k-1))$).

The main subject of this chapter is acyclic preference-based networks, that is, networks that do not contain any Kieschnick cycle. Note that acyclicity is entirely defined by $m$, and depends neither on the quotas nor on the initiatives. Similarly, if $m$ produces acyclic preferences for complete acceptability, then the network will be acyclic for any acceptability graph $G$. By convention, such a value matrix $m$ is also called acyclic. A classification of acyclic matrices, and their connection to P2P systems, are proposed in @subsec:classes.

Acyclic preference-based networks are characterized by a property that makes them unique among preference-based networks:

#theoreme([@gai07acyclic])[
  An acyclic preference-based network admits one, and only one, stable configuration. Moreover, it is self-stabilizing by initiatives.
] <thm:big_convergence_theorem>

#demo[
  The complete proof is available in @gai07acyclic, but I give the idea here, because of the importance of this theorem and the typical nature of the techniques employed. We proceed in two steps: first show self-stabilization (which will prove the existence of a stable configuration), then uniqueness.

  Self-stabilization comes from the following property: regardless of the initiative sequence considered and the starting configuration, the corresponding sequence of configurations is irreversible. That is, if the system was in a configuration $C_1$ in the past and is now in a configuration $C_2 != C_1$, then $C_1$ is not reachable from $C_2$. Irreversibility is proved by contradiction, by extracting a Kieschnick cycle from a cycle of configurations. Since $n$ is assumed finite, the number of possible configurations is also finite, which means that any trajectory of configurations necessarily leads to a configuration that no longer evolves, i.e., a stable configuration.

  Uniqueness is also proved by contradiction: if one considers two distinct stable configurations $A$ and $B$ of the same system, and a peer $i$ whose collaborations differ from $A$ to $B$, then one can construct a Kieschnick cycle starting from $i$ (even if $i$ does not necessarily belong to the cycle ultimately obtained).
]

#subfig(
  figure(image("../figures/no_churn.pdf"), caption: [Static case]),
  <fig:nochurn>,
  figure(image("../figures/healing.pdf"), caption: [Atomic alteration]),
  <fig:healing>,
  figure(image("../figures/churn.pdf"), caption: [Continuous churn]),
  <fig:churn>,
  columns: (1fr, 1fr),
  caption: [Self-stabilization in practice (after @gai07stratification).],
  label: <fig:healingchurn>,
)

I emphasize once again the fundamental nature of this existence/uniqueness/self-stabilization theorem, as it allows us to dispense with the stability analysis performed for other types of preferences, and to focus more closely on the configurations themselves.

The first application of this theorem appeared in the article _Stratification#footnote[Many people ask me why _stratification_, instead of _clustering_ for example. Well, first of all, because _clustering_ is already semantically overloaded in computer science; then because the image of strata is at least as evocative; and finally because the word is elegant.] in P2P Networks: Application to BitTorrent_ @gai07stratification. In this article, which sought to model a BitTorrent network as an acyclic preference-based network (I will discuss this in more detail later in the chapter), we measured the effective convergence between actual and stable configurations. To estimate the practical importance of self-stabilization, we had considered three types of scenarios (cf @fig:healingchurn):

/ Static (@fig:nochurn): Starting from the empty configuration (often denoted $C_emptyset$), we observed convergence toward the stable configuration. We observed good convergence in all cases, while noting that the system parameters, and the average degree of the acceptability graph in particular, played a major role;

/ Atomic alteration (@fig:healing): A second elementary scenario consists of removing a peer from a stable configuration (which modifies the stable configuration), and letting the system converge again. We observe that the actual configuration does not deviate much from the stable configuration, and eventually re-converges, even though, due to a possible domino effect, the convergence time may be comparable to the static case.

/ Continuous churn (@fig:churn): Finally, a third scenario consists of having peers join and leave the system at a certain rate. This scenario shows that the actual configuration does not always manage to catch up with the evolution of the stable configuration, especially when churn is extreme. However, self-stabilization ensures that the actual configuration remains reasonably close to the stable configuration, the _distance_ between the two being roughly proportional to the churn.

Following this study, I began working under the assumption that, provided the system's convergence is sufficiently fast compared to its evolution, the stable configuration should be a good approximation of actual configurations. This is the _spring_ metaphor (cf @fig:spring). This metaphor suggests decomposing the study of acyclic preference-based systems into two distinct problems:

#figure(
  image("../figures/spring.pdf", width: 10cm),
  caption: [The spring metaphor: self-stabilization can be seen as a continuous attraction of the current configuration toward the stable configuration, as if a spring connected these two configurations. This principle holds even if the stable configuration moves over time.],
) <fig:spring>

/ What is the convergence speed?: Indeed, @thm:big_convergence_theorem only gives us the number of possible configurations as a bound. This number grows factorially @chowla50asymptotic and thus offers rather limited practical interest. A first area of study therefore consists of characterizing more precisely the effective _stiffness_ of the spring.

/ What are the properties of stable configurations?: The previous question should help determine to what extent a stable configuration is a good approximation of an actual configuration. When this is the case, the generic properties of stable solutions can help estimate system performance.

These two questions will be the subject of the next two sections of this chapter. But before answering them, I propose to take a closer look at these acyclic preferences, of which I have so far given only a summary and impractical definition.

=== Taxonomy of acyclic preferences <subsec:classes>

Among all possible real matrices, few are acyclic. In fact, if one takes a matrix whose coefficients are chosen at random, it is very likely that the resulting preferences contain at least one cycle of length $3$#footnote[The probability that three mutually acceptable peers form a cycle is $1/4$, for uniform random values. The probability of having no such cycle is therefore at most $(3/4)^(binom(n,3))$ (if one neglects possible correlations), which is not worth much as soon as $n$ is large enough.].
On the other hand, many matrix properties are synonymous with acyclicity. For example (@gai07acyclic):

/ Global matrices: A value matrix $m$ is global if all its rows are identical when restricted to acceptable entries. Intuitively, this is a special case of a rank-$1$ matrix, and formally, $m(i,k) = m(j,k)$ for all $i,j$ that accept $k$. The corresponding preferences, also called global, reflect a total order on the peers. One can moreover note that because of this total order, up to acceptability and permutation of peers, there is only one global preference.

/ Symmetric matrices: If $m$ is symmetric on its acceptable entries ($m(i,j) = m(j,i)$ for every acceptable pair), $m$ is acyclic. An interesting property of symmetric matrices is that they describe the set of all acyclic preferences (cf @gai07acyclic @abraham07stable). The relationship between acyclic, symmetric, and global matrices, and the corresponding preferences, is illustrated in @fig:classes#footnote[@fig:classes is of course incomplete. It is missing, for example, linear combinations in general, and complementary matrices in particular, as well as the generation of the set of all acyclic preferences by permutations of the entries of a symmetric matrix with distinct coefficients. But graphical readability would suffer.].

/ Linear combination of global and symmetric matrices: The resulting matrices are acyclic as long as they do not generate ties (but as noted in @subsubsec:pbs_def, it is always possible to eliminate ties). On the other hand, a linear combination of acyclic matrices is not necessarily acyclic: if the input matrices are not themselves already linear combinations of symmetric and global matrices, they must be symmetrized, which is fairly easy since the proof that symmetric matrices surject onto acyclic preferences is constructive (cf @gai07acyclic @abraham07stable).

#figure(image("../figures/classes.pdf", width: 10cm), caption: [Correspondences between matrices and preferences: symmetric and global matrices form two distinct subsets of acyclic matrices, but symmetric matrices can describe the entire set of acyclic preferences (which includes global preferences).]) <fig:classes>

==== Preferences suited to P2P

Having outlined what makes preferences acyclic, I now propose to refocus on the peer-to-peer context and consider acyclic peer-to-peer preferences.

/ Capacities: A peer in a P2P network possesses many intrinsic scalar characteristics that can create preferences: access bandwidth, storage or computing capacity, average _uptime_, ... Taking the example of the file-sharing protocol BitTorrent @cohen03incentives, a _tit-for-tat_ algorithm causes a peer to preferentially collaborate with neighbors that provide it the highest download speed. This can be seen, as a first approximation, as a preference-based network where the value is the upload bandwidth divided by the quota (the number of simultaneous uploads).

/ Proximities: All values that can be assimilated to some kind of distance (physical or virtual) or similarity are symmetric by nature. Thus, many P2P systems try to minimize latencies#footnote[The question of whether latencies are distances, or even symmetric, naturally arises. In any case, empirically, they do not produce Kieschnick cycles.], such as the DHT Pastry @pastry or real-time online gaming applications @syncms. Similarly, massively multiplayer online games (MMOGs) must connect players that are close to each other in some virtual space @keller03simon @mmog @solipsis. Some authors also propose connecting participants of a file-sharing system based on their common interests @sripanidkulchai03efficient @fessant04clustering, which remains a symmetric measure. _Co-uptime_, that is, the (average) common active time, is a last example of a symmetric measure of interest for collaborative applications.

/ Complementarities: Measuring differences between participants' resources can also prove interesting. For example, in a distributed file storage application, it is useful to find machines that are on when my own machine is off, in order to keep my data available at all times. The corresponding measure is complementary uptime. Similarly, in a system like BitTorrent, all participants seek to have the same file, which is divided into blocks#footnote[It even appears that sometimes, some blocks may be rarer than others @mathieu06missing.]. Finding neighbors that have the most blocks I have not yet obtained is of interest. All these so-called complementary preferences are a special case of a linear combination of a global matrix and a symmetric matrix, and are therefore acyclic @gai07acyclic.

==== Preference classes studied

As we have just seen, there exist many acyclic preferences of interest from the P2P perspective. Over the course of my work, I focused on four classes of acyclic preferences, which avoids getting lost in a maze of special cases while giving a precise idea of the links between preferences and system properties.

/ Global: Although representing a negligible subset (in terms of cardinality) of acyclic preferences, global preferences are among the most important acyclic preferences (they model capacities), and must receive particular attention. Since there is in fact only one unique global preference system, induced by a total order on the peers, I will use this order instead of making the value matrix $m$ explicit. Peers will thus be labeled from $1$ to $n$, $1$ being the _best_ (it is preferred by all its acceptable neighbors), and so on...

/ Geometric: For preferences derived from distances, the properties of preferences depend greatly on how the points are positioned in the underlying space. One can moreover easily show that all acyclic preferences can be generated by placing the $n$ peers at the vertices of a simplex and perturbing it (by slightly moving the vertices) in an appropriate manner. Nevertheless, experience seems to show that certain characteristics occur frequently. To obtain typical and analyzable proximity preferences, I propose to consider preferences obtained by taking distances between $n$ random points on a unit $t$-torus of dimension $t$ ($t >= 1$).

/ Real latencies: Having real measurements to validate results is obviously necessary, even though theoretical analysis then becomes difficult. For $n <= 2500$, I use, to check the validity of certain geometric results, subsets of size $n$ extracted from the Meridian project dataset @meridianproject. The values are the (symmetric) latencies between the selected nodes.

/ Random acyclic: A last class of preferences is obtained by assigning to each acceptable edge a uniform random value between $0$ and $1$. I call the resulting preferences _random acyclic_ (or simply acyclic when there is no ambiguity), because it can be shown that this approach produces a uniform sampling over the set of all possible acyclic preferences @gai07acyclic @abraham07stable.

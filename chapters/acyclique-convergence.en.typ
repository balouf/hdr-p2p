#import "../templates/prelude.typ": *

== Characterization of self-stabilization <sec:self>

_What is the speed of convergence?_ This section will attempt to answer this question, from both a theoretical (@subsec:self_worst and @subsec:self_expected) and a practical standpoint.

=== Upper bounds <subsec:self_worst>

I first propose to give upper bounds, in the sense of self-stabilization theory. The initiative considered throughout this section is _best partner_. For $b=1$, the bounds are exact, linear in rounds, and quasi-exact, exponential in initiatives. I then give weaker bounds for $b>1$.

==== Convergence (rounds) <sec:round>

For $b=1$, the maximum convergence time, expressed in rounds, is given by the following theorem.

#theoreme([@mathieu07upper])[
  Starting from any configuration, an adversarial sequence converges in at most $floor(n/2)$ rounds. This bound is achieved by a round-robin sequence.
] <thm:round>

#demo[
  The @lemma:hot guarantees the stabilization of at least one boiling edge per round. Since there are at most $floor(n/2)$ edges to stabilize, the bound follows immediately. To achieve it, one can use global preferences, a complete acceptability graph, the initial configuration $C_emptyset$, and a round-robin sequence using the _worst to best_ pattern.
]

==== Convergence (initiatives) <sec:step>

If we now want to measure convergence in number of active initiatives, the bound depends on the constraints of the sequence: round-robin or fully adversarial.

*Round-Robin Sequence*

The bound for round-robin sequences is given by the following theorem.

#theoreme([@mathieu07upper])[
  Starting from any configuration, a round-robin sequence converges in at most $sum_(k=0)^(floor(n/2)-1) n-(2k+1) approx n^2/4$ active initiatives. This bound is exact.
] <thm:robin>

#demo[
  As for @thm:round, we use the fact that at least one boiling edge is stabilized per round. Moreover, a stable peer is by definition never active again; the precise counting of possible initiatives then gives $sum_(k=0)^(floor(n/2)-1) n-(2k+1) approx n^2/4$. The system used for @thm:round achieves the bound, proving that it is exact.
]

*Adversarial Sequence*

Convergence for an adversarial sequence is described by the following theorem.

#theoreme([@mathieu07upper])[
  Starting from any configuration, an adversarial sequence converges in at most $2^(n-1) - 1$ active initiatives. Conversely, there exists a sequence that converges in $Theta(lambda^n)$ active initiatives, with $lambda approx 1.6826$, which shows that the exact bound for adversarial sequences lies between these two values.
] <thm:upperbound>

#demo[
  Like many other proofs, the bound $2^(n-1) - 1$ follows from @lemma:hot. The trick is to consider a boiling edge and look at the moment it stabilizes. Before that instant, the adjacent peers cannot take the initiative: we are by hypothesis in _best partner_ mode, so they would stabilize. Afterwards, they are inactive. We deduce a recursion on the number of peers allowed to take an initiative, from which the bound is derived.

  The bound $Theta(lambda^n)$ is obtained for global preferences, with complete acceptability, starting from a _worst first_ sequence: at each instant, the initiative is taken by the worst active peer (the one with the largest label). A complete study of the behavior of this sequence of initiatives gives the lower bound.
]

#remarque[
  In all the results I have just stated, the bounds are achieved from global preferences. From this point of view, one can therefore consider that global preferences are the "worst" possible for convergence, as the sequel will confirm. More generally, global preferences often have atypical behavior among acyclic preferences.
]

==== Generalization to $b$-matching

For $b>1$, an adaptation of @thm:round immediately gives us a bound of $floor(n b/2)$ rounds (at least one edge is stabilized per round). But it is easy to see that this is just an upper bound. For example, taking $b=n-1$ (this is the limiting case of the absence of quotas: everyone can simultaneously collaborate with everyone), each peer is guaranteed to be stabilized after taking $n-1$ initiatives, giving a bound of $n-1$ rounds much smaller than $floor(n(n-1)/2)$.

The explanation behind the imprecision of the bound is that when $b>1$, a non-stable configuration has hot edges in addition to boiling edges. These merely hot edges are harder to enumerate (not all transient configurations have them), which makes computing the bounds more difficult. We can still give bounds more precise than $floor(n b/2)$ for global preferences (which, let us recall, are intuitively the worst possible preferences).

#theoreme([@mathieu08self])[
  For global preferences, the convergence time is bounded by $b/(b+1) n$ rounds if the acceptability is complete, and by $n$ otherwise.
] <th:g_b>

Simulations (cf @sec:setup) indicate that the bound $b/(b+1) n$ reflects fairly well the actual behavior of global preferences: the first quotas are the most expensive in terms of convergence. Complete acceptability also seems to be the worst case, which means that $n$ is clearly an overestimate (not to mention $floor(n b/2)$).

#demo[
  If the acceptability is complete, the stable configuration consists of cliques of size $b+1$ (@gai07stratification); $b$ rounds stabilize a clique, hence the result. In the general case (unknown acceptability), we can only assert that $b$ rounds stabilize $b$ peers, hence the bound $n$.
]

=== Average convergence times <subsec:self_expected>

Let us now turn to the average convergence for non-adversarial round-robin and Poisson sequences. The results presented here hold for $b=1$, with the _best partner_ initiative. These are upper bounds on the average convergence time of certain classes of preference systems, where average time is measured in initiatives ($1 "u.t." = n "initiatives"$).

==== Generic bound

Under the assumptions considered ($b=1$ and _best partner_ initiative), the following bound holds for any acyclic system:

#theoreme([@mathieu08self])[
  The average convergence time is bounded by $n/4$ for a Poisson sequence, and by $(n+1)/6$ for a round-robin sequence.
] <thm:selfconv_generic>

#demo[
  As often, the theorem relies on @lemma:hot, namely the existence of at least two boiling peers in any non-stable configuration. We deduce an average time between two "boiling" initiatives of $1/2$ for a Poissonian sequence and $1/3(1+1/n)$ for a round-robin sequence. Multiplying by $n/2$ (maximum number of edges in the stable configuration), we obtain the result.
]

#remarque[
  For global preferences with complete acceptability, any unstable configuration admits exactly two boiling peers (the two best non-stabilized peers). This suggests that the bounds of @thm:selfconv_generic should be fairly precise for these systems, which is confirmed by the simulations @mathieu08self. We recover the fact that global preferences are "the worst possible acyclic preferences".
]

#remarque[
  The exact bound $(n+1)/6$ for round-robin sequences is not contradictory with the exactness of the bound $floor(n/2)$ of @thm:round: one is an average bound over all round-robin sequences, the other a worst-case bound.
]

==== Global preferences

For global preferences, with an Erdős-Rényi acceptability graph $cal(G)(n,p)$, there exist finer bounds:

#theoreme([@mathieu08self])[
  With global preferences, if $G=cal(G)(n,p)$, the average degree being $d=p(n-1)$, the average convergence time is $O(d+log(n))$ for a Poissonian sequence and $O(d)$ for a round-robin sequence.
] <thm:selfconv_node-based>

#demo[
  The core of the proof consists in _counting_ the boiling peers in non-stable configurations. Using combinatorial techniques, one shows that there are of the order of $n/d$. We then deduce an average time between two "boiling" initiatives of the order of $d/n$, which gives the common behavior in $O(d)$. Finally, particular attention must be paid to the finalization of the convergence process, when almost all edges are already stabilized. In this _endgame_, the non-stable nodes are almost all boiling. A round-robin sequence will then complete the stabilization in $O(1)$ ($1$ time unit stabilizes all currently boiling nodes), while a Poissonian sequence will need $O(log(n))$ t.u. (balls and bins problem).
]

==== Acyclic preferences

For (random) acyclic preferences, we have a similar result:

#theoreme([@mathieu08self])[
  For random acyclic preferences, if $G=cal(G)(n,p)$, the average degree being $d=p(n-1)$, the average convergence time is $O(log(d)+log(n))$ for a Poissonian sequence and $O(log(d))$ for a round-robin sequence.
] <thm:selfconv_randomacyclic>

#demo[
  A calculation can show that for random acyclic preferences, approximately half of the non-stable peers are boiling. This allows showing that the endgame is reached after $O(log(d))$ time units. If the sequence is Poisson, an additional $O(log(n))$ t.u. must be added.
]

#remarque[
  Since $d<n$, some will want me to simplify the bound $O(log(d)+log(n))$ to $O(log(n))$, and they will be right. However, I keep my notation, because as a good physicist from the land of Pagnol, I consider that _the big O of $log(d)$ matters more than the big O of $log(n)$_ (cf @infl:density).
]

==== Other acyclic preferences

For other types of acyclic preferences, the key to estimating the average convergence time is to estimate the number of boiling peers. For real preferences such as those from Meridian, this is a difficult exercise. Similarly for geometric preferences, where strong correlations exist between the preferences of nearby peers. Note that for this latter case, ignoring these correlations reduces to the case of random acyclic preferences, and this works fairly well in practice (this technique will moreover be extensively used in the following section).

In _self-stabilization in preference-based systems_ @mathieu08self, I propose to look at the distribution of peer "value" to determine whether the convergence of a system is closer to that of global preferences or to that of acyclic preferences. If some peers are well ranked by many of their neighbors (they are thus "good" peers), the convergence should resemble that of global preferences ($O(d)$ or $O(d+log(n))$). On the other hand, if no good peer stands out (peers all have roughly the same value), the convergence should be of the random acyclic type ($O(log(d))$ or $O(log(d)+log(n))$).

I suggest using this rule of thumb (every acyclic preference network has behavior between that of random acyclic preferences and that of global preferences, the cursor being positioned by the distribution of values) for all types of acyclic preferences, for instance for linear combinations of preferences. And also for arbitrary acceptability graphs and quotas. Unfortunately, I have no theoretical proof to offer. Fortunately, for everything I cannot prove, there are simulations.

=== Simulations <sec:setup>

Beyond purely theoretical results, I propose simulations to complete the understanding of the convergence of acyclic preferences. This is an approach I am particularly fond of when a system that depends on a few parameters cannot be fully analyzed: varying the parameters one by one in order to build an intuition about the influence of each of these parameters. All results presented here come from the article _self-stabilization in preference-based systems_ @mathieu08self, to which I invite the reader concerned with technical details to refer.

==== _Best partner_ initiative <infl:density>

To begin, let us look at convergence under the _best partner_ initiative, which was extensively studied at the beginning of this section. Quotas greater than $1$ will be used to see how the results seen for $b=1$ apply for $b >= 1$.

*Size of the acceptable neighborhood*

In order to understand the influence of the number of neighbors, we fix $n$ and vary $d=p(n-1)$ ($G$ is still assumed to be Erdős-Rényi). Two main behaviors are observed:
- For global preferences, the convergence time grows linearly; the round-robin sequence is faster than the Poissonian sequence except when $d$ is close to $n$;
- for the other preferences studied, the convergence time grows in a seemingly logarithmic manner; the round-robin sequence is always faster than the Poissonian sequence; the two fastest preferences (random acyclic and geometric) are virtually indistinguishable.

*System size* <infl:nodes>

Let us now consider systems where $n$ varies, with $d$ constant. The results are as follows:
- The convergence time increases with $n$ for Poissonian sequences. This is the _endgame_ effect in $O(log(n))$;
- for round-robin sequences, the convergence time increases noticeably less. There is even a slight decrease for global preferences when $n$ is close to $d$;
- except for the case above (global preferences, $n$ close to $d$), Poissonian sequences are longer than round-robin sequences;
- as in the previous experiment, acyclic and geometric preferences converge the fastest, followed by Meridian preferences and finally, relatively far behind, global preferences.

The main lesson to take away from these simulations is that for fixed $d$, $n$ has relatively little effect on the convergence time. "The big $O$ of $d$ is more important than the big $O$ of $n$".

*Collaboration quotas*

As for the other parameters, the role of quotas in convergence time depends on the type of preferences:
- For global preferences, the convergence time first grows quickly then slowly (the first quotas are the most expensive); Poissonian sequences are slightly faster;
- for the other preferences, a linear or quasi-linear growth is observed, with round-robin sequences being slightly faster.

*Summary*

In summary, global preferences are distinguished by a convergence time that is linear with respect to the average degree, making $d$ the main parameter to consider for convergence. The quotas $b$ have a weaker influence, especially once the first values are past (the more connections there are, the less time a new connection takes).

For the other preferences, where there are not really any "good" peers, it is almost the opposite: convergence is proportional to the quotas (each connection costs the same amount of time as the previous one), but only logarithmic with respect to the neighborhood size.

==== Random and hybrid initiatives <sec:initiative>

Most of the work I have done so far concerns the _best partner_ initiative, as it is a deterministic initiative, which simplifies its study. To conclude this discussion on convergence, I would like to briefly address the _random_ initiative, which I believe will be a very interesting subject to study in future work.

A _random_ initiative is much less costly in control messages than a _best partner_ initiative, because it is unnecessary to know the ranks and partners of one's neighbors to implement it. In return, it increases the convergence time: while a boiling peer necessarily stabilizes an edge by taking a _best partner_ initiative, this is no longer the case with a random initiative.

However, it is not only the time required for complete convergence that matters. The time needed to reach _good enough_ configurations (for some measure) is at least as important.

For example, it is possible to measure peer satisfaction in a given configuration (cf @mathieu08self for a detailed description) and to observe how this satisfaction evolves during the convergence process. For non-global preferences (geometric, random or Meridian) and the same initial conditions, the _best partner_ initiative produces at each instant a better satisfaction than the random initiative. On the other hand, the situation is much less clear-cut if the preferences are global: on the one hand, the random initiative needs only a few t.u. to create a high satisfaction, but then struggles to reach the stable satisfaction; on the other hand, the _best partner_ initiative has a much slower initial growth and only surpasses the satisfaction of the random initiative late, but then converges quickly.

The interest of this example is to show that in addition to being less costly, there are cases (global preferences in this instance) where the random initiative can prove more efficient: having a very strong initial convergence, even if the final convergence is slow, can be very advantageous for a system subject to high churn (and where it is therefore illusory to try to achieve complete convergence). I take the opportunity to note that the BitTorrent protocol, which can very roughly be likened to a system with global preferences subject to churn, uses the random initiative, better known here as _optimistic unchoking_.

I propose the following interpretation (also drawn from @mathieu08self) to explain this difference in convergence for global preferences: with the _best partner_ initiative, everyone tries the "good" peers. In particular, the bad peers will continuously try the best non-stabilized peers. The latter stabilize very quickly (they are hot), which breaks their bad connections. The result is a kind of convergence front (or saturation front) that moves temporally from the best to the worst peers, with peers being stabilized after the front passes, but having few or no connections before. In particular, a bad peer cannot retain its partners before the complete convergence of the system. Conversely, the random initiative does not create a saturation front, but rather a sort of uniform convergence of satisfaction: bad peers can choose bad partners, which means that their intermediate connections last longer.

The advantages of _random_ and _best partner_ initiatives can be combined in hybrid initiatives. I propose for example an initiative where each peer operates in random initiative mode below a certain number of partners, and switches to _best partner_ beyond that. The good peers converge almost as fast as with _best partner_, following a saturation front, but the peers ahead of the front still have good satisfaction due to the random component that kicks in whenever there are not enough partners. In the end, the hybrid initiative performs well regardless of the acyclic preferences (not just for global preferences therefore), both for initial and complete convergence, making it an interesting choice, particularly for acyclic systems where the exact nature of the preferences is unknown or variable.

#import "../templates/prelude.typ": *

== Stable configurations <sec:stable>

Before concluding this chapter on networks with acyclic preferences, I propose to answer, at least partially and for Erdős-Rényi acceptability graphs, the second major question of acyclic preference systems: _what are the properties of the stable configuration?_

For $b=1$, it is possible to study the distribution of partners through a (simplified) _mean field_ approach. For global preferences, one can prove the existence of a fluid limit with an explicit solution, which shows in particular that the distribution of the value of a peer's partner is centered around the value of that peer, with exponential decay: this is the _stratification_ effect @gai07stratification. For random acyclic or geometric preferences, the solution of the fluid limit decays as a power law. Although I am unable to prove the _mean field_ approach, I propose to validate it by comparing it with the exact solution (for global preferences) or using simulations.

Finally, I propose to extend the results to $b >= 1$. The fluid equations then no longer seem to admit explicit solutions, but the same asymptotic behavior as for $b=1$ is observed (exponential for global preferences, power law otherwise). An unexpected consequence is that for geometric preferences, the stable configuration is a small-world if the quotas are sufficient.

Most of the results presented here are gathered in the article _The Stable Configuration in Acyclic Preference-Based Systems_ @mathieu09stable, of which an extended version is available as a research report @mathieu08stable.

=== Specific notation

Since I propose to study the stable configuration in detail in this section, some additional notation is necessary, particularly to describe the distribution of partners. If $i$ and $j$ are acceptable, $r_i (j)$ denotes the acceptable rank of $j$ according to $i$ ($1$ being the best rank). $r_i$ is the acceptable ranking of $i$. If $i$ has more than $k$ (acceptable) neighbors, $r_i^(-1)(k)$ is the $k$th best acceptable neighbor of $i$. Similarly, for any $j != i$, $R_i (j)$ denotes the rank of $j$ in the complete graph, without taking into account the notion of acceptability#footnote[I assume the existence of a natural extension of the value matrix to non-acceptable pairs. This extension is immediate for global preferences (the intrinsic value) and geometric preferences (the distance). For random acyclic preferences, it is obtained by assigning random "phantom" values to non-acceptable edges.]. $R_i$ is the _complete_ ranking of $i$. For $K<n$, $R_i^(-1)(K)$ is the $K$th best neighbor, acceptable or not, of $i$.

In all that follows, $D$ denotes the distribution of the stable partner or partners. To lighten the notation, I propose to use a loose notation, where the meaning of $D$ is specified using subscripts and superscripts whenever necessary. Thus, $D_(R_i)(K)$ indicates the probability that $i$ has its peer of complete rank $K$ as a partner; $D_(n,d)(i,j)$ is the probability that $i$ and $j$ are partners if there are $n$ peers with Erdős-Rényi acceptability of average degree $d=p(n-1)$; if $c <= b(i)$, $D_(r_i,c)(k)$ is the probability that the $c$th best stable partner of $i$ has acceptable rank $k$...

The complementary cumulative distribution function (CCDF) of $D$ is denoted $S$, and the normalized versions of $D$ and $S$ are respectively denoted $cal(D)$ and $cal(S)$.

=== Acyclic equations <sec:mean_field>

For the case of simple matching ($b=1$), I propose a generic method to describe the complete rank of $C(i)$, if it exists, in the stable configuration $C$. The generalization to $b$-matching will be done in @sec:bb_mean.

==== Exact equation <subsec:generic>

Let $D_(R_i)(K)$ be the probability that $R_i (C(i))=K$, i.e. that the partner of $i$, if it exists, has complete rank $K$. The CCDF of $D$ is defined by $S_(R_i)(K) := 1 - sum_(L=1)^(K-1) D_(R_i)(K)$, i.e. the probability that $i$ has a partner of complete rank greater than or equal to $K$ ($R_i (C(i)) >= K$) or has no partner at all (shorthand notation for the disjunction of both events: $R_i (C(i)) lt.not K$). Inspired by the approach used in @gai07stratification, I propose an exact equation describing $D_(R_i)$ before giving a simplified version derived from a _mean field_ approach.

To express $D_(R_i)(K)$, one can observe that for $i$ to be stable with its peer of complete rank $K$, denoted $j := R^(-1)_i (K)$, the following three conditions must be (and suffice to be) satisfied:
- ${i,j}$ must be an acceptable edge, which occurs with probability $p$ if $G$ is an Erdős-Rényi graph $cal(G)(n,p)$;
- $i$ must not have a better stable partner than $j$ ($R_i (C(i)) lt.not K$);
- $j$ must not have a better stable partner than $i$ ($R_j (C(j)) lt.not R_j (i)$).

This leads to the following exact equation:

$ D_(R_i)(K) = p S_(R_i)(K) Pr(R_j (C(j)) lt.not R_j (i) | R_i (C(i)) lt.not K) $ <eq:d_exact>

==== Approximate equation <subsec:meanfield>

The main difficulty of @eq:d_exact is the conditional probability, which is delicate to handle because of the correlations that may exist between $R_j (C(j)) lt.not R_j (i)$ and $R_i (C(i)) lt.not K$. The solution is to consider these correlations as negligible:

#approximation[The events \u{201C}$i$ is not with someone better than $j$\u{201D} and \u{201C}$j$ is not with someone better than $i$\u{201D} are independent.] <ass:meanfield1>

This approximation, which I sometimes somewhat loosely call "mean field hypothesis", is reasonable for $p$ small enough#footnote[A few simple examples seem to indicate an error of order $p^3$, confirmed by the simulations @gai07stratification.]. @eq:d_exact can then be simplified to

$ D_(R_i)(K) = p S_(R_i)(K) S_(R_j)(R_j (i)) $ <eq:d_approx0>

To go further, one must take into account the type of preferences.

=== Global preferences <sec:nb>

Since global preferences are characterized by a total order on the peers, one can dispense with the value matrix $m$ by labeling the peers from $1$ to $n$, $1$ being the best. We thus directly consider the probability $D(i,j)$ that $i$ and $j$ are partners. Noting that the complete rank of $j$ for $i$ is $j$ if $j<i$ and $j-1$ if $j>i$ (a peer does not rank itself), we obtain the relation between $D$ and $D_R$:

$ D(i,j) = cases(D_(R_i)(j) & "si" j < i\,, 0 & "si" j = i " (non-réflexivité),", D_(R_i)(j-1) & "si" j > i.) $ <eq:dij_dri>

Setting $S(i,j) := 1 - sum_(k=1)^(j-1) D(i,k)$, we obtain the version of @eq:d_approx0 for global preferences:

$ D(i,j) = cases(0 & "si" i = j\,, p S(i,j) S(j,i) & "sinon.") $ <eq:dij_sij>

This equation#footnote[For the record, @eq:dij_sij was proposed by Julien Reynier based on an original idea by Fabien de Montgolfier. Chronologically it is the origin of @eq:d_approx0 (general equation), and not the other way around.], which is solved numerically by a double iteration, gives a very good approximation of the empirical distribution @gai07stratification.

==== Normalization

An explicit fluid limit toward which the discrete distributions converge is a definite asset for describing the stable configuration. It indeed allows giving a complete, immediate and global description of the distribution for all $n$ and $p$, which is not the case of @eq:dij_sij.

In order to obtain this limit, one must be able to compare distributions for arbitrary values of $n$. It is therefore necessary to normalize $D$. A fairly simple way to do this is to represent each peer $i$ by a normalized rank $alpha$, with $0 <= alpha < 1$. More precisely, we associate to each $i$ the real number $alpha(i) = (i-1)/n$, and conversely to each positive real $alpha$ the integer $i(alpha) = floor(n alpha) + 1$. The normalized version of $D$, denoted $cal(D)$, is then defined by

$ cal(D)_n (alpha, beta) = n D(floor(n alpha)+1, floor(n beta)+1) $ <eq:normalisa_d>

$cal(D)_n$ is a step function (of two variables), which takes the values $(n D(i,j))$. The factor $n$ allows expressing $D(i,j)$ simply as an integral of $cal(D)$:
$ D(i,j) = integral_((j-1)/n)^(j/n) cal(D)_n ((i-1)/n, x) dif x = integral_((i-1)/n)^(i/n) cal(D)_n (x, (j-1)/n) dif x $

The normalized complementary cumulative distribution is defined by

$ cal(S)_n (alpha, beta) = 1 - integral_0^beta cal(D)_n (alpha, x) dif x $ <eq:sab_def>

and the relation between $S$ and $cal(S)$ is

$ S(i,j) = cal(S)((i-1)/n, (j-1)/n) $ <eq:sij_sab>

==== Convergence of normalized distributions

If the average degree remains constant, I have shown the existence of a continuous limit of the distributions $cal(D)$. The first step is to address the problem of an intrinsic discontinuity along the main diagonal ($alpha approx beta$), due to the fact that $D(i,i)=0$. This is a minor problem since this discontinuity is simply there to recall the non-reflexivity of the matching. It is resolved by introducing a more "continuous" function $cal(D)$, obtained by extending $cal(D)$ on the main diagonal using @eq:dij_sij:

$ tilde(cal(D))(alpha, beta) = cases(cal(D)(alpha, beta) & "si" floor(n alpha) != floor(n beta)\,, n p (S(floor(n alpha)+1, floor(n alpha)+1))^2 & "sinon.") $

The fluid limit, at constant degree, of the functions $tilde(cal(D))$ is then given by the following theorem:

#theoreme[
Soit $d>0$ une constante. Si $n -> infinity$, avec $p = d/n$, les fonctions $tilde(cal(D))_(n,d)$ convergent uniformément vers
$ cal(D)_infinity (alpha, beta) = (d e^(d abs(beta - alpha))) / (1 - e^(-d min(alpha, beta)) + e^(d abs(beta - alpha)))^2 $ <eq:f_nb_d>
] <th:f_nb_d>

This result shows that asymptotically, the distribution of partners depends only on the average degree of $G$ (assumed Erdős-Rényi). This allows quantitatively describing the _stratification_ effect @gai07stratification: for fixed $alpha$, the distribution of the stable partner of $alpha$ decays exponentially in $|beta - alpha|$, with intensity $d$ ($cal(D)_infinity (alpha, beta) approx d e^(-d|beta - alpha|)$ for $d|beta - alpha|$ large enough). In other words, a peer of normalized rank $alpha$ tends to have as partner a peer of the same rank, within plus or minus $1/d$.

#demo[
The proof of @th:f_nb_d consists of four steps @mathieu08stable:
- show that the functions $tilde(cal(D))_(n,d)$ are uniformly Cauchy on $[0,1]^2$;
- use Cauchy convergence to show that $cal(S)_N$ and $tilde(cal(D))_N$ admit limits $cal(S)_infinity$ and $cal(D)_infinity$;
- give a PDE satisfied by $cal(S)_infinity$;
- solve the PDE#footnote[For the reader eager for "exotic" equations, this involves solving $partial_beta cal(S)_infinity (alpha, beta) = -d cal(S)_infinity (alpha, beta) cal(S)_infinity (beta, alpha)$, with the initial condition $cal(S)_infinity (alpha, 0) = 1$. Although seemingly innocent, solving this non-local equation gave me quite a hard time, even though I already knew its solution by other means. I take this opportunity to thank François Baccelli who pointed me toward the approach of de-non-localization.], and deduce $cal(D)_infinity$ from the solution.
]

The existence of this fluid limit had been proposed as a conjecture as early as @gai07stratification, and proven for the case $alpha=0$, but it was only later that the complete proof and expression were found @mathieu08stable.

@th:f_nb_d yields three immediate corollaries that complete the understanding of the stable configuration.

#corollaire[
Considering $cal(S)_infinity (alpha, 1)$, the probability that a peer of normalized rank $alpha$ is unmatched in the stable configuration is $1 / (1 + e^(-d alpha)(e^(-d) - 1))$.
]

#corollaire[
For $i != j$ (discrete case), a good approximation of $D(i,j)$ is
$ D(i,j) approx (p e^(p abs(j-i))) / (1 - e^(-p min(i,j)) + e^(p abs(j-i)))^2 $ <eq:dij_explicit>
]

#corollaire[
Let a sequence of normalized distributions $cal(D)_(n,d)$ with unbounded increasing degree ($d arrow.r^(n -> infinity) infinity$). We have
$ forall alpha in [0,1[, quad cal(D)_(n,d) (alpha, .) arrow.r^(n -> infinity)^* delta_alpha $
] <coro:weak_dirac>

This last corollary generalizes a theorem proposed in @gai07stratification, which showed the existence of a weak Dirac limit in the case of a sequence of distributions with $p = d/(n-1)$ constant. It means that as soon as the degree tends to infinity (for instance as $O(log(n))$), then asymptotically, a peer has as partner a peer of the same normalized rank (no deviation), and the probability of being unmatched becomes zero.

==== Validation

To validate the previous results, one must compare simulation results with @eq:dij_sij (recurrence under the independence approximation), then with @eq:dij_explicit. This is what was done in @gai07stratification@mathieu08stable.

As indicated previously, we observe for @eq:dij_sij a very good precision, of order $p^3$.

For the fluid limit, apart from the continuous extension on the main diagonal, the precision is also very good, except for small values of $n$ and high values of $d$. These observations are consistent with the complete proof of @th:f_nb_d @mathieu08stable, which shows convergence in $O(d^2/n dot e^(8d))$. They would even rather support convergence in $O(d^2/n)$, which is in my opinion the true bound, although this remains to be proven#footnote[The factor $e^(8d)$ comes from the use of Grönwall's lemma @gronwall, which amplifies an incompressible quantization error of $O(d^2/n)$. But in practice, @eq:dij_sij, which serves as the basis for constructing the distributions, is self-stabilizing (an error in one direction at a given moment is compensated in the other direction at the next iteration), which Grönwall's lemma does not allow to take into account.].

==== Exact resolution

In the situation I have just proposed ($b=1$, global preferences, acceptability $cal(G)(n,p)$), it is in fact unnecessary to resort to the independence approximation, since there exists a recurrence that yields the exact distribution @mathieu08stable.

I was able to obtain this recurrence by conditioning the fact that $i$ and $j$ are partners according to the rank of the partner of peer $1$ (less than $i$, between $i$ and $j$, greater than $j$, or no partner).

Just as for the approximate formula, the exact formula admits a fluid limit, which obeys a certain PDE. Although the two PDEs (exact and approximate) are extremely different#footnote[The exact PDE is relatively classical and is solved by the method of _characteristics_, whereas the approximate PDE, described in an earlier note, had to be solved in a less conventional manner.], they give the same solution, namely @eq:f_nb_d.

The fact that in this particular case, the recurrence given by the independence approximation has exactly the same fluid limit as the exact recurrence is a strong argument (albeit not a rigorous one) for justifying the use of this approximation in other cases. For a major drawback of the exact recurrence is that the "trick" used does not apply to other preferences, nor for $b>1$. However elegant this recurrence may be, the independence hypothesis therefore remains indispensable if one wants to generalize the results.

=== Acyclic and geometric preferences <section:ra_db>

I now propose to turn to (random) acyclic and geometric preferences. For these preferences, one can note that the peers are undifferentiated. Over the set of possible realizations, one can therefore consider that all peers follow the same partner distribution: $D_(R_i)(K)$ is independent of $i$, and can therefore be denoted $D_R (K)$.

As for global preferences, the goal is to find the distribution of the complete rank by simplifying @eq:d_exact before solving it. I also briefly give the distribution of distances and elements for solving the distribution of the relative rank.

==== Distribution of the complete rank <section:rank>

For geometric or random preferences, the @ass:meanfield1 is not sufficient, which is why I propose an additional approximation:

#approximation[The complete rank is symmetric: $R_i (j) = R_j (i)$.] <ass:meanfield2>

I thus assume that $R_i (j)$ is not too bad an approximation of $R_j (i)$ for the preferences considered. This gives a very simple equation for $D_R (K)$:

$ D_R (K) = p S_R^2 (K), quad "avec" S_R (K) = 1 - sum_(L=1)^(K-1) D_R (L) $ <eq:d_approx>

$S_R$ can thus be obtained by a simple recurrence:

$ S_R (K) = cases(1 & "si" K = 1\,, S_R (K-1) - p S_R^2 (K-1) & "sinon.") $ <eq:s_approx>

And $D_R$ is directly given by $D_R (K) = S_R (K) - S_R (K+1)$.

*Fluid limit.* <subsec:fluid>

As for global preferences, $D_R$ can be normalized. For $0 <= alpha < 1$, we set $cal(d)_R (alpha) := (n-1) D_R (floor((n-1)alpha)+1)$. The normalization factor is now $n-1$ since this is the maximum value of $K$ ($n$ was that of $i$ and $j$ in @sec:nb). $D_R$ is expressed as an integral of $cal(d)_R$:
$ D_R (K) = integral_((K-1)/(n-1))^(K/(n-1)) cal(d)_R (x) dif x $
$cal(s)_R$ is then naturally defined by:
$ cal(s)_R (alpha) = 1 - integral_0^alpha cal(d)_R (x) dif x $

#theoreme[
Soit $d>0$ une constante. Si $n -> infinity$, avec $p = d/n$, les fonctions $cal(S)_R$ convergent uniformément vers
$ cal(s)_infinity (alpha) = 1 / (d alpha + 1) $ <eq:f_sr_alpha>
En particulier, la probabilité qu'un pair soit célibataire dans la configuration stable est asymptotiquement $cal(s)_R (1) = 1/(d+1)$, et une bonne approximation de $S_R (K)$ est
$ S_R (K) = 1 / (p(K-1) + 1) $ <eq:f_sr_k>
] <th:complete>

#demo[
The proof is the same as for @th:f_nb_d, but easier. One must first show that the $cal(D)_R$ are uniformly Cauchy (which is easier here since there is only one variable and no need to introduce an extension on the main diagonal). We then have uniform convergence toward a continuous function $cal(s)_infinity$. We then deduce from @eq:s_approx an ordinary differential equation satisfied by $cal(s)_infinity$:
$ -dot(cal(s))_infinity (alpha) = d cal(s)_infinity^2 (alpha) $ <eq:fprime_c_alpha>
with the initial condition $cal(s)_infinity (0) = 1$. The solution of @eq:fprime_c_alpha is @eq:f_sr_alpha, which completes the proof.
]

*Validation.* <subsec:validation_geo>

Given the approximations made, it is necessary to verify on a few examples the precision of @eq:f_sr_k. I have therefore tested its validity for a few values of $n$ and $p$ @mathieu08stable.

For $p=1$, one cannot really say that the independence hypothesis is satisfied. Simulations show that the distributions are affected by the particular type of preferences, and the fluid limit is not very precise, particularly at the boundaries ($K$ close to $1$ or $n$). One can among other things note that the probability of being unmatched $1/n$ given by @eq:f_sr_k is clearly overestimated if $n$ is even (since it is then actually zero), but exact for odd $n$. The fluid limit nevertheless manages to give the $1/K$ behavior common to all preferences considered. From this point of view, it is better than the recursive #ref(<eq:s_approx>, supplement: none) (from which it derives), which gives $S_R (K) = delta_K^1$ for $p=1$.

As $p$ decreases, the empirical curves and the limit given by @th:complete converge very quickly. By $p=1/10$, they are almost indistinguishable, which validates the use of the fluid limit as an approximation of the complete rank distribution.

==== Distribution of distances <subsec:geometric>

It may be interesting to consider distributions other than that of the complete rank. For example, for geometric preferences, the distribution of distances between stable partners can be interesting if the performance of a matching is related to distances. Now, this distribution can be deduced from that of the complete rank:

#theoreme[
Soit $S_X (x)$ la probabilité qu'un pair n'ait pas de partenaire stable à distance inférieure à $x$ dans le tore unitaire de dimension $t$. Soit $B_t$ le volume d'une boule de rayon $x$ dans ce tore. Sous la limite fluide, on a
$ S_X (x) = 1 / (d B_t (x) + 1) $ <eq:f_c_x>
]

#demo[
A ball of radius $x$, centered on any peer, contains approximately $n B_t (x)$ peers since it occupies a proportion $B_t (x)$ of the torus (which is assumed to be unit). The most distant peer inside this ball should therefore have a complete rank of approximately $n B_t (x)$ for the central peer, while being at a distance of approximately $x$. We thus obtain the relation $S_X (x) = S_R (n B_t (x))$, and it only remains to use @eq:f_sr_k to conclude.
]

The function $B_t (x)$ depends on the dimension $t$ and the norm used. For the infinity norm, we simply have $B_t (x) = min((2x)^t, 1)$. The expression for other norms can be somewhat more complicated due to possible wrap-around effects at the boundaries. Note that if I had chosen $RR^t$ (with homogeneous density) instead of the unit torus, $B_t (x)$ would simply have been the volume of a ball of radius $x$, without boundary effects.

As usual, the precision of @eq:f_c_x has been verified empirically, and the result is that it has virtually the same region of validity as @eq:f_sr_k @mathieu08stable.

==== Distribution of the relative rank <sec:relative>

For random acyclic and geometric preferences, I have also studied the distribution of the relative rank, given by the function $D_r (k)$ and its complementary cumulative distribution $S_r (k) := 1 - sum_(l=1)^(k-1) D_r (k)$.

I therefore tried to adapt the method used for the complete rank. The conditions to be fulfilled for the stable partner of $i$ to be its $k$th acceptable neighbor $j = r_i^(-1)(k)$ are the following:
- $i$ must have at least $k$ neighbors (if the $k$th neighbor exists, it is acceptable by definition),
- $i$ must not be with a peer better than $j$,
- $j$ must not be with a peer better than $i$.

By adapting the independence and symmetry approximations to the relative rank, we then obtain the following recurrence formula @mathieu08stable:

$ D_r (k) = S_r (k) (1 - I_(1-p)(n-k+1, k)) / (k+1) $ <eq:spetit_r_1>

where $I_x$ is the regularized incomplete beta function.

Unfortunately, @eq:spetit_r_1 is much less precise than @eq:f_sr_k is for the complete rank, particularly for $D_r (1)$ @mathieu08stable. The reason is that correlations are much more present when it is the acceptable rank that is considered (particularly if one considers the close neighborhood).

As an exercise, I therefore asked myself whether it was possible to refine the estimate of the relative rank, and I partially succeeded: for $D_r (1)$, it is possible to have a better estimate in the fluid limit, which is obtained by conditioning $D_r (1)$ on the normalized complete rank of the first acceptable partner @mathieu08stable. We then obtain

$ D_r (1) = e dot E_1 (1) approx 0.596 $

where $E_1$ is the exponential integral.

This value is very good in almost all cases for random acyclic preferences. For geometric preferences, it is however necessary to be in good conditions, i.e. small $p$ and large $n$ @mathieu08stable.

=== Generalization to $b$-matching <sec:bb_mean>

I now propose to extend the previous results to the $b$-matching problem. $b$ is still assumed to be constant across peers for simplicity. I only propose here results on the complete rank, although it is a priori possible to reuse the techniques seen previously for the relative rank or distances.

==== Equations under the independence hypothesis

A peer can now have up to $b$ partners. We therefore denote, for $1 <= c <= b$, $D_c$ the distribution of the complete rank of the $c$th best stable partner, and $S_c$ the corresponding CCDF. Just as for the case $b=1$, it is possible to give the necessary and sufficient conditions for $j = R_i^(-1)(K)$ to be the $c$th best stable partner of $i$:
- the pair ${i,j}$ must be acceptable,
- the $(c-1)$th best partner of $i$ (if $c>1$) must be strictly better than $j$, while the $c$th (if it exists) must not be,
- the $b$th partner of $j$, if it exists, must not be better than $i$.

By extending the independence hypothesis @ass:meanfield1, we thus obtain a generic formula for $b$-matching:

$ D_(R_i, c)(K) = cases(p S_(R_i, 1)(K) S_(R_j, b)(R_j (i)) & "si" c = 1"\, sinon", p (S_(R_i, c)(K) - S_(R_i, c-1)(K)) S_(R_j, b)(R_j (i)) & .) $ <eq:generic_meanfield_multiple>

To be usable, this formula must be adapted to the type of preferences considered.

For global preferences, if $D_c (i,j)$ denotes the probability that the $c$th stable partner of $i$ is $j$#footnote[I take the opportunity to point out that $D_c$ is no longer symmetric, whereas it was for $b=1$.], we obtain the following recursive system, which is solved by a triple iteration over $i$, $j$ and $c$ @gai07stratification:

$ D_c (i,j) = cases(0 & "si" i = j"\, sinon", p S_1 (i,j) S_b (j,i) & "si" c = 1\,, p (S_c (i,j) - S_(c-1)(i,j)) S_b (j,i) & "si" c > 1.) $ <eq:nodebase_meanfield_multiple>

Similarly, for random acyclic and geometric preferences, we obtain the following system from @ass:meanfield2 (symmetry of the complete rank) @mathieu08stable:

$ D_(R,c)(K) = cases(p S_(R,1)(K) S_(R,b)(K) & "si" c = 1\,, p (S_(R,c)(K) - S_(R,c-1)(K)) S_(R,b)(K) & "si" c > 1.) $ <eq:drc_meanfield>

Using $S_(R,c)(1) = 1$ and $D_(R,c)(K) = S_(R,c)(K) - S_(R,c)(K+1)$, system @eq:drc_meanfield is easily solved by a double iteration over $K$ and $c$.

Simulations show that both systems agree very well with the empirical distributions as long as $n$ and $p$ satisfy the usual conditions @mathieu08stable. The behavior is qualitatively very similar to that of simple matching: exponential decay for global preferences (but because of the multiplicity of partners, shifts appear between the density peaks of the $D_c$ and the value of the original peer), heavy tail distribution for geometric and random acyclic preferences.

For $b>1$, fluid limits also exist. Unfortunately, unlike simple matching, I have not managed to find explicit solutions to describe them (and as time passes, I increasingly doubt that such solutions exist). It is nevertheless possible to give the PDEs satisfied by these limits.

For global preferences, the fluid limits satisfy

$ partial_y cal(S)_c (alpha, beta) = cases(-d cal(S)_1 (alpha, beta) cal(S)_b (beta, alpha) & "si" c = 1"\, sinon", -d (cal(S)_c (alpha, beta) - cal(S)_(c-1)(alpha, beta)) cal(S)_b (beta, alpha) & .) $ <eq:bbfluid>

with the initial conditions $cal(S)_c (alpha, 0) = 1$.

Similarly, for acyclic and geometric preferences, the limits $cal(s)_(R,c)$ satisfy

$ dot(cal(s))_(R,c) = cases(-d cal(s)_(R,1) cal(s)_(R,b) & "si" c = 1\,, -d (cal(s)_(R,c) - cal(s)_(R,c-1)) cal(s)_(R,b) & "si" c > 1.) $ <eq:bfluid>

with the initial conditions $cal(s)_(R,c)(0) = 1$.

Even if these equations cannot be solved completely, the fluid limit still has several advantages.

First, the very existence of a limit allows computing it numerically with precision and using the result for multiple values of $n$ and $d$. Take for example the case of global preferences (the same reasoning can be applied to acyclic and geometric preferences). We assume $b$ is fixed. Let $d_(max)$ be the maximum average degree of the distributions we want to evaluate, and $N$ a fixed sampling size of the fluid limit (the larger $N$, the more precise the evaluation). We can then set $p = d_(max)/(N-1)$ and compute the $D_(N,p,c)$ (once and for all) using @eq:nodebase_meanfield_multiple. For a degree $d <= d_(max)$, we set $N' = d/p$ ($N'$ is not necessarily an integer). Inspired by the normalization @eq:normalisa_d, we obtain the following approximation for $|alpha - beta| >= 1/N'$:

$ cal(D)_(d,c) (alpha, beta) approx N' D_(N,p,c) (floor(N' alpha)+1, floor(N' beta)+1) $

We can then in turn use this estimate of the fluid limit for discrete distributions. Thus, for any integer $n$ and for any $d <= d_(max)$, we have, for $|i-j| >= n/N'$ (which amounts to $i != j$ if $n <= N'$)

$ D_(n,d,c)(i,j) approx (N'/n) D_(N,p,c) (floor((N'/n)(i-1))+1, floor((N'/n)(j-1))+1) $

Another advantage of fluid limits is that the PDEs they satisfy give us information about their behavior. One can for example use them to show that $cal(s)_(R,1) <= cal(s)_R <= cal(s)_(R,b)$ (and the equivalent for global preferences) and thus understand why the behavior in $b$-matching remains similar to that of simple matching.

=== Some applications <sec:applications>

Having put considerable effort into the mere study of distributions, I must admit I have not yet devoted much time to advanced properties of stable configurations, i.e. those likely to help understand existing systems and develop new ones. Here are nevertheless two: the stratification of global preferences and the "small-worldification" of geometric preferences.

==== Stratification <subsec:appli_bittorrent>

As we have just seen, with global preferences, the stable partners of a given peer $i$ have, on average, the same rank as $i$. This is stratification, which guarantees a certain fairness in the stable configuration @gai07stratification: in terms of rank, what a peer gives should be roughly equal to what it receives. One must also remember that the $cal(D)_c (alpha, .)$ have exponential decay with deviation of $1/d$, $d$ being the average degree of the acceptability graph. One then realizes that the following trade-off must be resolved:
- if $d$ is too small the deviation is high. In particular, if the entries of the value matrix (for example the bandwidths of a _BitTorrent_-like system) follow a non-uniform distribution, there can be a very large difference between the expected gain and what one gives. This problem was highlighted in @gai07stratification to explain potential flaws in the Tit-for-Tat technique employed by BitTorrent;
- a large $d$ on the other hand strengthens fairness. But in practice, increasing the size of the acceptability graph has a cost for the peers: convergence time, memory space, graph maintenance... A large $d$ also shortens the deviation (down to the Dirac in the fluid limit), and therefore increases the diameter of the stable configuration, which can be problematic if one wants to propagate information through stable edges.

For the quota $b$, which represents the maximum degree in the stable configuration, a similar trade-off exists: a large $b$ can improve fairness and decrease the diameter, but will be costly in resources.

This suggests that for most systems with global preferences (i.e. based on the sharing of bandwidth, storage capacity, computing power, uptime...), there should exist a pair $(d,b)$ (or more generally a coupling between an acceptability graph and a vector of quotas) optimal for the stable configuration, whose exact value would depend on the importance given to parameters such as diameter, fairness, convergence time, or maintenance cost.

==== Small-worldification <subsec:diaclust>

A small-world is a sparse graph (average degree in $O(log(n))$ or even $O(1)$) with an average shortest path length (ASPL) in $O(log(n))$ and a high clustering coefficient (there are far more short cycles than for a random graph of the same size). For example, Kleinberg showed some years ago that an $n$-dimensional grid could be transformed into a small-world by adding long-range edges following a distribution in $Omega(1/x^n)$ @kleinberg00small.

Let us now look at what happens for a stable configuration, with $b$ in $O(log(n))$ so that the configuration is "sparse". If it is global preferences, the clustering is indeed there as a consequence of stratification, but the diameter tends to grow linearly @gai07acyclic. Similarly, for random acyclic preferences, the small diameter is verified but there is no high clustering (the stable configuration behaves like an incomplete random $b$-graph). On the other hand, for geometric preferences, the heavy tail distribution allows having both properties: on the one hand, most stable partners have a small complete rank; they are therefore "geographically" close which gives clustering; on the other hand, there exist long-range links that make the diameter small. Geometric preferences are therefore conducive to generating small-world configurations, and this is indeed what occurs @gai07acyclic. This opens a number of perspectives on the use of the stable configuration, starting with an easy-to-use small-world generator.

What is surprising about this small-worldification with geometric preferences is that it is solely created by the way peers rank each other: actual distances are used to construct these rankings, but the values themselves play no direct role in the preference system in general and in its stable configuration in particular. This leads one to think that topological characteristics of a system can therefore be contained in a set of preferences.

As an example of characteristics, I computed numerically the small-world parameters of preferences on tori for a few dimensions, the result being that the diameter and clustering tend to decrease when the dimension increases @mathieu08stable. I then looked at what the Meridian latencies gave, and the parameters obtained turned out to be close to those of the 3-dimensional torus. I particularly like this unexpected result, because it seems to suggest that there exists a dimension of the Internet _in the sense of preferences_, which is about $3$. I can thus add my brick to the wall of efforts made everywhere to estimate a dimension of the Internet (see for example @abrahao08internet).

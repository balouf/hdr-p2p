= Content distribution <ch:distribution>

The purpose of this chapter is to survey the issues related to content distribution in a peer-to-peer approach, focusing on the themes that I have personally addressed during my research. I begin by specifying what I mean exactly by _content distribution_ (file sharing, slightly delayed broadcast, video-on-demand), highlighting the specific and common challenges of each type of distribution. I then discuss three specific problems: bandwidth dimensioning (generic to all types of distribution), epidemic broadcasting (slightly delayed), and decentralized video-on-demand

== Distributing

When I speak of distribution, I think first and foremost of large content: computer programs and operating systems, music files, DivX movies, channels broadcast in high definition#footnote[The distribution of very small content (for example a peer-to-peer classified ads system), due to the non-existence of bandwidth as a limiting parameter, obeys radically different challenges from those I will present here.]. For this kind of content requiring large network resources, one can roughly distinguish three ways of performing distribution: file sharing, slightly delayed broadcast, and _on-demand_ broadcast.

=== File sharing

Historically, the flagship application of peer-to-peer in distribution is file sharing, whose success is I think no longer in question. As in the case of a classic (non peer-to-peer) download, it is a _best effort_ application by nature, and the effective download time constitutes the main metric. From a network perspective, a challenge is therefore to achieve optimal use of available resources, in order to minimize this download time. Guaranteeing a certain durability of the shared content (avoiding impossible downloads) also plays a role.

=== _Streaming_ broadcast

A _streaming_ application aims to transmit multimedia content for viewing or listening purposes. This kind of application is not at all _best effort_, unlike file sharing, because constraints appear at the time of content playback (mainly, one must ensure that the part of the content one wants to play is there when it is needed). Among the metrics common to all broadcasting, there are:

/ Quality: as a first approximation, it is proportional to the stream bitrate, even though other parameters come into play, such as the choice of encoding or the loss rate.
/ Initialization delay: this is the time that elapses between the moment one decides to watch content and the moment it begins to play.

From a network perspective, the challenge is to
- maximize the useful throughput, notably by minimizing control messages (_overhead_),
- minimize losses,
- minimize the transmission delay (network).

These three parameters are closely related to each other in peer-to-peer. For example, it is generally possible to reduce the transmission delay at the cost of higher losses or overhead. The art of designing a broadcast system then consists of finding the right trade-off.

==== Slightly delayed

Slightly delayed streaming (the term _live_ being somewhat presumptuous on the Internet) seeks to broadcast an event that is currently taking place, for example a football match. In addition to the constraints related to any broadcast over the Internet, the main challenge of slightly delayed broadcast is to minimize the end-to-end transmission delay, that is, the time that elapses between the moment a goal is scored (and therefore when one hears one's neighbors, who are watching the match on television, shout) and the moment one can see it on one's computer screen. From a network perspective, the challenges are the same as for streaming in general, except that the importance of the transmission delay is increased. The very nature of slightly delayed broadcast also creates specific advantages and disadvantages. For example, there is no need to worry about the existence of the content (it is directly injected into the system), but one must be able to satisfy a large number of people watching the same content in a quasi-synchronous manner.

==== Video-on-demand (VoD)

Video-on-demand essentially consists of combining a file-sharing system with a streaming system. In addition to the constraints related to broadcasting, one must be able to manage a large content catalog, and in particular ensure its availability in an asynchronous manner, each client wanting to watch what they want when they want.

== Dimensioning

The bandwidth conservation law is a tool so simple that many people tend to forget its existence, while it allows, at little cost, to understand and dimension (approximately at least) a distribution system. As I mentioned in the introduction, the first time I became interested in it was when I saw the first discussions about the possibility of sharing files in P2P appear on various forums.

My first reaction was negative: indeed, in a network, if one abstracts away control data, losses, and other multicast replications, data transfer can be compared to a transfer of physical matter: if Alice sends one liter of music to Bob, and if everything goes well, one liter of music leaves Alice's place, flows through the network, and one liter of music ends up at Bob's place. The problem is that the outgoing and incoming pipes do not have the same size in ADSL technology, which is the one used today for most residential connections, and the receiving capacity is generally $4$ to $20$ times greater than the sending capacity. This is why I was rather skeptical about the future of peer-to-peer: even if all participants fully opened their sending taps, it seemed to me that my bathtub would always fill up more slowly in peer-to-peer than if I used a server capable of saturating my incoming pipe.

This intuition was wrong. Today, when one can download the latest episodes of popular series in less time than it takes to heat up a pizza, I have forged a new intuition, still based solely on the bandwidth conservation law, which allows understanding and predicting (dimensioning) the behavior of a peer-to-peer system.

The key to my error was that I had forgotten that in a peer-to-peer network, not everyone is simultaneously a client and server (that is, a _leecher_ to use the standard term). One must account for those who leave their outgoing tap open without using the incoming one (the _seeders_), and also possibly, in the case of hybrid systems, dedicated servers responsible for supporting the system. In the end, the proper way to write the bandwidth conservation law is

$ sum_(l in L) d(l) = min(D_"max", U_L + U_S + U_E), $ <eq:bandiwdth_conservation>

where $L$, $S$, and $E$ respectively denote the population of leechers, seeders, and servers, $U_X$ the total upload capacity of population $X$, and $D_"max"$ the total receiving capacity of the leechers.

Despite its simplicity, this equation leads to fairly fine results, the main ones being @benbadis08playing:
- For a closed _streaming_ system there exists a scalability threshold that depends on the bitrate one wants to achieve, the average upload capacity, and the ratio between $S$ and $L$.
- Below this scalability threshold, a hybrid system allows multiplying the initial server capacity, the amplification depending on the parameters mentioned above.
- For an open system, with arrivals and departures, similar results are obtained by considering the arrival process intensity and the behavior of peers instead of population sizes.
- Unlike a closed system, an open system possesses a zone of over-performance, whose boundary is defined by the behavior of seeders, where leechers can receive at maximum capacity regardless of the arrival intensity. Intuitively, an open system can accumulate enough seeders to make the transfer capacity arbitrarily large. An enforced sharing ratio policy is a good way to approach this critical zone.
- For tit-for-tat incentive systems, a la BitTorrent, there exists a tolerance threshold for selfish users (free-riders). Beyond this threshold, the system can no longer expel free-riders, who accumulate continuously in the system.

== Simplifying

When slightly delayed broadcast became the objective to achieve in peer-to-peer, the theoretical and practical currents followed two radically different paths: on one side, theoretical solutions were proposed based on trees with disjoint interior nodes @splitstream @prefixstream. The problem with these techniques is that for various reasons that I will not have space to discuss here, there currently exists no viable client based on them. As a consequence, these structured approaches have not yet managed to reach the general public.

On the other side, the practical camp started from what already worked, namely file-sharing applications like BitTorrent, and sought to adapt it to broadcasting. This resulted in a generation of new applications like PPLive @pplive, which enjoy growing success with the general public. But the problem with this approach, even though the result is functional, is that BitTorrent is not designed for live broadcasting. In particular, while a live stream should be transmitted as linearly as possible, the ideal being to receive the stream pieces in the order in which they were created, BitTorrent is designed to shuffle the order of pieces as much as possible in order to maximize availability and avoid the appearance of a _missing piece_ @mathieu06missing. To work around this contradiction, the solution generally employed is to group successive pieces into macro-pieces. Each macro-piece taken individually is broadcast _a la BitTorrent_, while the retrieval of successive macro-pieces is done linearly, which ultimately allows reading the stream in the right order, macro-piece after macro-piece. The drawback is that in the end, the performance obtained, notably in terms of initialization delay and end-to-end transmission delay, falls well below the promises of theory.

Faced with this alternative, a third way, which has held my attention during my work, is that of epidemic broadcasting. If I had to give a single reason to justify my choice, it would be their simplicity (not to be confused with triviality). Indeed, while structured algorithms require setting up a fairly complex structure and current applications add an additional layer to an existing algorithm that is already quite elaborate, the design of an epidemic broadcast is much simpler. When a peer has the technical ability to send a piece of the stream to one of its neighbors, it must answer the following two questions:
- _To whom should it send?_
- _Which piece should it choose to send?_

Each way of answering these two questions (which one will notice are very close to the _Who retrieves what from whom?_ that I proposed to define peer-to-peer) corresponds to an epidemic broadcast algorithm. One can thus very easily generate a quasi-infinite number of distinct algorithms, and evaluate their performance through theoretical analysis or simulations @bonald08epidemic.

Without going into the technical details, I would say about the ongoing research that a consensus seems to be emerging regarding the choice of piece (second question): once the recipient is chosen, the most efficient approach seems to be to send the _latest useful chunk_, that is, the most recent piece that the target does not yet possess. Although variations are still under study, this _latest useful_ strategy currently gives the best performance in terms of delay.

For the first question, the choice of recipient, the question is still far from settled: we know that in certain cases, choosing the recipient simply at random gives quasi-optimal performance on a theoretical level, but simulations suggest that there is much room in that _quasi_. Current research (conducted at Orange Labs, but also by other teams in France and in Europe) therefore aims to do better than random selection, knowing that to choose otherwise than at random, the sender must be given more information, and that there is a trade-off to find between the amount of information to be provided to the sender at the time of its choice and the quality of the resulting choice. In the extreme, one could imagine a mechanism where senders communicate in order to synchronize and manage to create an optimal broadcast, but the cost of such a technique in terms of control messages (_overhead_) would very likely be prohibitive.

== Decentralizing

Finally, I would like to close this chapter on content distribution by briefly discussing the problem of decentralized video-on-demand, which I had the opportunity to address under the impetus of Laurent Viennot @boufkhad08achievable @boufkhad09upload. This problem, originally proposed by Suh _et al._ @diot07push, uses the fact that more and more households are equipped with _set-top boxes_, which among other features have a hard drive and Internet access. Hence this very simple idea: since a video-on-demand service essentially requires storage capacity and bandwidth to operate, why not build a service that relies on the resources of the _set-top boxes_?

The interest of this subject is that beyond the classic problems encountered in distribution (bandwidth and initialization delay for example), we see the emergence of a trade-off between bandwidth, storage capacity, and failure rate. Thus, if video files are stored with low redundancy, the closer the available bandwidth is to the limit necessary for the proper functioning of the service (conservation law), the greater the risk that in practice, when it comes time to distribute a video, the set-top boxes possessing that video have already exhausted the necessary network resources, leading to distribution failure. To reduce the risk of failure, one must either increase network capacities or increase redundancy, and therefore mechanically decrease the available storage capacity#footnote[The way in which videos are segmented also plays a role @boufkhad08achievable @boufkhad09upload.].

Another specificity of this problem is that although very simple practical solutions, based on random choices, can be implemented to solve it in a nearly optimal manner, the underlying allocation theory is very subtle and assuredly non-trivial.

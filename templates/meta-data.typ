// =============================================================================
// Métadonnées de la thèse
// =============================================================================

#import "i18n.typ": lang, t

// -----------------------------------------------------------------------------
// Résumés et mots clés
// -----------------------------------------------------------------------------

#let french-abstract = [
D'un millénaire à l'autre, le pair-à-pair a émergé comme un nouveau paradigme informatique. Plus précisément, des nouveaux enjeux sociaux et économiques, ayant trait en particulier à la distribution de contenus, sont venus raviver d'anciennes problématiques liées aux systèmes décentralisés, leur donnant de nouvelles justifications et de nouveaux éclairages. Dans ce mémoire, je propose tout d'abord de donner des bases pour comprendre et aborder les problématiques pair-à-pair. Après un bref survol des travaux auxquels je me suis intéressé dans le but d'améliorer la distribution de contenu, je me tourne vers un sujet plus théorique : les réseaux à préférences acycliques, lesquels sont un moyen élégant pour modéliser des systèmes pair-à-pair non-structurés ou hybrides. Issus de la théorie des mariages stables, leur principale caractéristique est une capacité auto-stabilisante. Deux questions fondamentales se posent alors, auxquelles je donne un début de réponse : à quelle vitesse un réseau à préférences acycliques se stabilise-t-il, et vers quel état converge-t-il ?
]

#let french-keywords = [
P2P --- Théorie des mariages stables --- Distribution de contenu
]

#let english-abstract = [
Peer-to-peer (P2P) recently emerged as a new paradigm in computer science. Due to major economic and social stakes, mostly related to content distribution, P2P has brought back to the forefront many existing research fields related to distributed systems, providing new incentives and goals. In this work, we give some keys to the understanding of the research fields related to P2P systems. After a brief survey of our work on content distribution, we consider a more theoretical subject: acyclic preference-based systems, which recently appeared as an elegant way to model many P2P unstructured or hybrid systems. The strength of these models is a self-stabilizing property that allows us to provide analytical results in addition to empirical validation.
]

#let english-keywords = [
Peer-to-Peer --- Stable Marriages --- Content Distribution
]

// -----------------------------------------------------------------------------
// Informations générales
// -----------------------------------------------------------------------------

#let thesis-title = t(
  [#smallcaps[Autour du pair-à-pair :] \ #smallcaps[Distribution de contenus,\
   réseaux à préférences acycliques]],
  [#smallcaps[On Peer-to-peer:] \ #smallcaps[Content Distribution,\ Acyclic Preference Networks]],
)

#let thesis-author = [Fabien #smallcaps[Mathieu]]
#let thesis-type = t([Habilitation à diriger des recherches], [Habilitation to Supervise Research])
#let thesis-date = t([11 février 2009], [February 11, 2009])
#let thesis-specialty = t([Informatique], [Computer Science])
#let thesis-domain = t([Réseaux et télécommunications (cs.NI)], [Networking and Internet Architecture (cs.NI)])

// -----------------------------------------------------------------------------
// Jury
// -----------------------------------------------------------------------------

#let thesis-jury = (
  (
    name: [M. Pascal #smallcaps[Felber]],
    position: t([Professeur, Université de Neuchâtel], [Professor, University of Neuchâtel]),
    role-key: "reviewer",
  ),
  (
    name: [M. Pierre #smallcaps[Fraigniaud]],
    position: t([Directeur de recherche, CNRS], [Research Director, CNRS]),
    role-key: "reviewer",
  ),
  ( name: [M. Jérôme #smallcaps[Galtier]], 
    position: [Orange Labs], 
    role-key: "examiner" ),
  ( name: [M. Laurent #smallcaps[Massoulié]], 
    position: [Thomson Technology Paris Laboratory], 
    role-key: "examiner" ),
  (
    name: [M. Philippe #smallcaps[Robert]],
    position: t([Directeur de recherche, INRIA], [Research Director, INRIA]),
    role-key: "reviewer",
  ),
  (
    name: [M. Sébastien #smallcaps[Tixeuil]],
    position: t([Professeur, Université Pierre et Marie Curie], [Professor, Pierre et Marie Curie University]),
    role-key: "chair",
  ),
  (
    name: [M. Laurent #smallcaps[Viennot]],
    position: t([Chargé de recherche, INRIA], [Research Scientist, INRIA]),
    role-key: "examiner",
  ),
)

#let jury-role(key) = {
  let roles = (
    reviewer: t("Rapporteur", "Reviewer"),
    examiner: t("Examinateur", "Examiner"),
    chair: t("Président", "Chair"),
  )
  roles.at(key)
}

// =============================================================================
// Remerciements
// =============================================================================

#import "../templates/prelude.typ": *
#import "@preview/griddle:0.2.1": *

#citation[#smallcaps[George Orwell], the server farm][All peers are equal,\ but some peers are more equal than others.]

#pagebreak()

#heading(outlined: true, numbering: none)[#t([_Remerciements_], [_Acknowledgements_])]


The acknowledgements are certainly the most delicate part of a thesis to write. Since my father was a great crossword enthusiast, I decided to pay him this tribute, transferring in the process the difficulty from the author to the reader. A few useful pointers to tackle these acknowledgements in the best possible conditions:
- Many definitions refer to personal anecdotes. It is therefore normal not to be able to solve the entire grid (in this respect, these acknowledgements are after all like any other).
- I do hope, however, that everyone will find their squares. If not, $V 31$.
- For living organisms, I only give the first name or the species. In case of a duplicate, a single entry on the grid, but possibly two definitions.
- Some words in the grid are not acknowledgements, but are just there to decrease the difficulty (or increase it according to some). They are often (but not always) the shortest ones.

_Note: The crossword puzzle below is in French and relies on wordplay, personal anecdotes, and cultural references that are inherently untranslatable. It is preserved in its original French form. Francophone readers will appreciate the clues; others are warmly invited to seek help from a French-speaking friend._

#let defs = (
  across: (
    (number: 5, row: 1, col: 0, word: "rapporteurs", definition: "C'est vilain de le faire, mais je suis content qu'ils aient accepté"),
    (number: 6, row: 1, col: 13, word: "safari", definition: "Où l'on chasse les têtes"),
    (number: 8, row: 2, col: 14, word: "rat", definition: "Grosse souris sans fil"),
    (number: 9, row: 3, col: 3, word: "liafa", definition: "Annexe parisienne de Montpellier"),
    (number: 11, row: 3, col: 9, word: "elf", definition: "Total"),
    (number: 14, row: 3, col: 16, word: "hp", definition: "Pas Dell"),
    (number: 16, row: 4, col: 0, word: "pl", definition: "Où l'on inverse la notation"),
    (number: 17, row: 4, col: 9, word: "fabien", definition: "Atos (l'autre)"),
    (number: 19, row: 4, col: 16, word: "ih", definition: "Système d'autoroutes aux USA"),
    (number: 20, row: 5, col: 0, word: "al", definition: "Prénom balafré"),
    (number: 21, row: 5, col: 13, word: "serein", definition: "Zen"),
    (number: 23, row: 6, col: 0, word: "sebastien", definition: "Expert démoniaque"),
    (number: 27, row: 6, col: 12, word: "jt", definition: "Messe du soir"),
    (number: 28, row: 6, col: 16, word: "ulm", definition: "Rue des grosses têtes"),
    (number: 29, row: 7, col: 8, word: "fleau", definition: "Calamité"),
    (number: 30, row: 8, col: 0, word: "alf", definition: "Melmacien"),
    (number: 31, row: 8, col: 15, word: "dupe", definition: "S'est fait avoir"),
    (number: 32, row: 9, col: 3, word: "jury", definition: "Honorable"),
    (number: 33, row: 9, col: 8, word: "mathilde", definition: "Blonde insulaire"),
    (number: 34, row: 11, col: 2, word: "thibaut", definition: "Fumeur de Drums"),
    (number: 37, row: 11, col: 10, word: "gang", definition: "Association criminelle se réunissant le MARDI"),
    (number: 39, row: 12, col: 1, word: "prune", definition: "Fruit indigeste pour les pandas"),
    (number: 41, row: 13, col: 0, word: "jim", definition: "C'est le meilleur qui s'en va en premier"),
    (number: 42, row: 13, col: 6, word: "amis", definition: "Là quand on a besoin d'eux"),
    (number: 43, row: 13, col: 13, word: "diego", definition: "Apprentice"),
    (number: 44, row: 14, col: 0, word: "ee", definition: "Fin de soirée"),
    (number: 45, row: 14, col: 8, word: "x", definition: "Avec ça, on gagne bien sa vie"),
    (number: 46, row: 15, col: 0, word: "rr", definition: "Au cœur de l'horreur"),
    (number: 47, row: 16, col: 0, word: "or", definition: "Rêve de chercheur"),
    (number: 48, row: 16, col: 3, word: "lecteurs", definition: "Amateurs de plaisir solitaire"),
    (number: 51, row: 16, col: 13, word: "thomas", definition: "Il faut le voir pour le croire"),
    (number: 53, row: 17, col: 0, word: "medit", definition: "Jase"),
    (number: 54, row: 17, col: 10, word: "agir", definition: "Faire fait"),
    (number: 56, row: 18, col: 5, word: "fanfan", definition: "Une Pomme tombée sur ma tête (merci d'être velu)"),
    (number: 57, row: 18, col: 12, word: "nidhi", definition: "Canadienne sans fil"),
  ),
  down: (
    (number: 1, row: 0, col: 1, word: "famille", definition: "C'est compliqué"),
    (number: 2, row: 0, col: 9, word: "grief", definition: "Motif de plainte"),
    (number: 3, row: 0, col: 14, word: "marine", definition: "Ma hyène"),
    (number: 4, row: 0, col: 16, word: "mathieu", definition: "Un homme à marier ?"),
    (number: 7, row: 1, col: 15, word: "fa", definition: "Sous-sol"),
    (number: 9, row: 3, col: 3, word: "luca", definition: "Made in Italia"),
    (number: 10, row: 3, col: 6, word: "farid", definition: "What else ?"),
    (number: 12, row: 3, col: 10, word: "laurent", definition: "Push and Beyond -- Master"),
    (number: 13, row: 3, col: 11, word: "fb", definition: "Quinze fois rien"),
    (number: 15, row: 3, col: 17, word: "philippe", definition: "Grand prénom du rap -- Amateur de péplums"),
    (number: 16, row: 4, col: 0, word: "pascal", definition: "Le petit se fait rouler (mais pas lui !)"),
    (number: 18, row: 4, col: 13, word: "est", definition: "6 heures du mat' les nuits de deadline"),
    (number: 22, row: 5, col: 18, word: "nm", definition: "Mesure un moment"),
    (number: 24, row: 6, col: 2, word: "bnf", definition: "Tombeau présidentiel"),
    (number: 25, row: 6, col: 4, word: "spoutine", definition: "Muridé informaticien (qu'il repose en paix sur son petit nuage de gruyère)"),
    (number: 26, row: 6, col: 8, word: "nf", definition: "Aux normes"),
    (number: 27, row: 6, col: 12, word: "julien", definition: "D'artagnan"),
    (number: 31, row: 8, col: 15, word: "desole", definition: "À ceux qui recherchent vainement leur nom ici (cette marque d'affection me va droit au cœur)"),
    (number: 33, row: 9, col: 8, word: "matrix", definition: "Le monde de Neo"),
    (number: 34, row: 11, col: 2, word: "trm", definition: "Ce n'est pas la taille qui compte"),
    (number: 35, row: 11, col: 3, word: "hu", definition: "Cocotte"),
    (number: 36, row: 11, col: 5, word: "be", definition: "Un bleu qui n'a pas lu"),
    (number: 38, row: 11, col: 11, word: "ali", definition: "Baba cool"),
    (number: 39, row: 12, col: 1, word: "pierre", definition: "Routeur glouton"),
    (number: 40, row: 12, col: 17, word: "rob", definition: "Expert de l'égalité"),
    (number: 41, row: 13, col: 0, word: "jerome", definition: "Master of the WebWorld"),
    (number: 42, row: 13, col: 6, word: "anhtuan", definition: "Aramis"),
    (number: 43, row: 13, col: 13, word: "dmitri", definition: "White Russian"),
    (number: 48, row: 16, col: 3, word: "lip6", definition: "Vue imprenable sur la Tour Eiffel"),
    (number: 49, row: 16, col: 4, word: "et", definition: "Additif"),
    (number: 50, row: 16, col: 10, word: "sang", definition: "Liquide mis en banque"),
    (number: 52, row: 16, col: 18, word: "sara", definition: "Sans hache, j'écris ton nom"),
    (number: 55, row: 17, col: 12, word: "in", definition: "À fond de train"),
  ),
)

#let cw = load-crossword(defs)

// La grille et les définitions sont wrappées dans des grid(columns: 1) afin
// que le show rule de html-overrides.typ les convertisse en SVG pour l'export HTML.

#grid(columns: 1)[
  #align(center)[#show-schema(cw.schema, solved: false, wall-fill: none, wall-stroke: none, cell-fill: lime.lighten(92%),
  cell-size: (18pt, 18pt))]
]

#grid(columns: 1)[
  #table(columns: 2, rows: 1, stroke: none, inset: 0pt, gutter: 20pt,
	[
#heading(outlined: false, numbering: none, level: 3)[Across]
#show-definitions(cw.definitions.across)
	],
	[
#heading(outlined: false, numbering: none, level: 3)[Down]
#show-definitions(cw.definitions.down)
	]
  )
]
 #pagebreak()

#v(1fr)

#align(center, box[
  #image("../figures/guided_missile.png")
  #place(center+horizon, dx: 2cm)[#image(width: 6cm, "../figures/hache.png")]
 ])

#v(1fr)


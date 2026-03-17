// =============================================================================
// Thèse : Graphes du Web - Mesures d'importance à la PageRank
// Fabien Mathieu - 2004
// Conversion LaTeX → Typst - 2026
// =============================================================================
//
// Compilation:
//   typst compile --input lang=fr main.typ thesis-fr.pdf
//   typst compile --input lang=en main.typ thesis-en.pdf
// =============================================================================

// -----------------------------------------------------------------------------
// Imports
// -----------------------------------------------------------------------------

#import "templates/i18n.typ": lang, t
#import "templates/thesis-style.typ": *
#import "templates/prelude.typ": *

// Initialiser les acronymes
#init-acronyms(acronyms)

// Appliquer le style de thèse
#show: double-vowels
#show: thesis-style

// Note: les refs aux algorithmes utilisent #algref() car @alg: cause des problèmes avec ctheorems

// Configurer les théorèmes
#show: thmrules

// -----------------------------------------------------------------------------
// Page de titre
// -----------------------------------------------------------------------------

#title-page()

// -----------------------------------------------------------------------------
// Avertissement
// -----------------------------------------------------------------------------

#include "templates/disclaimer.typ"


#pagebreak()

// -----------------------------------------------------------------------------
// Remerciements
// -----------------------------------------------------------------------------

#include "chapters/remerciements.typ"

// #if lang == "en" {
//   include "chapters/remerciements.en.typ"
// } else {
//   include "chapters/remerciements.typ"
// }


// -----------------------------------------------------------------------------
// Table des matières
// -----------------------------------------------------------------------------

#outline(
  title: t([Table des matières], [Table of Contents]),
  depth: 3,
  indent: auto,
)




#include "chapters/introduction.typ"

#include "chapters/positionnement.typ"

#include "chapters/distribution.typ"

#include "chapters/acyclique.typ"

#include "chapters/conclusion.typ"


// -----------------------------------------------------------------------------
// Bibliographie
// -----------------------------------------------------------------------------

#pagebreak()
#set page(header: [
#align(left, text(size: 0.9em, style: "italic")[#t([Bibliographie], [Bibliography])])
#line(length: 100%, stroke: 0.5pt)])
#bibliography("references.bib", style: "springer-lncs-alphabetical.csl")

// -----------------------------------------------------------------------------
// Quatrième de couverture
// -----------------------------------------------------------------------------

#back-cover()

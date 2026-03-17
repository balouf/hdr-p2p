// =============================================================================
// HDR : Autour du pair-à-pair — Distribution de contenus,
//       réseaux à préférences acycliques
// Fabien Mathieu - 2009
// Conversion LaTeX → Typst - 2026
// =============================================================================
//
// Compilation:
//   typst compile --input lang=fr main.typ hdr-fr.pdf
//   typst compile --input lang=en main.typ hdr-en.pdf
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

#if lang == "en" {
  include "chapters/remerciements.en.typ"
} else {
  include "chapters/remerciements.typ"
}

#pagebreak()

#if lang == "en" {
  include "chapters/avant-propos.en.typ"
} else {
  include "chapters/avant-propos.typ"
}


// -----------------------------------------------------------------------------
// Table des matières
// -----------------------------------------------------------------------------

#outline(
  title: t([Table des matières], [Table of Contents]),
  depth: 3,
  indent: auto,
)



#if lang == "en" {
  include "chapters/introduction.en.typ"
} else {
  include "chapters/introduction.typ"
}

#if lang == "en" {
  include "chapters/positionnement.en.typ"
} else {
  include "chapters/positionnement.typ"
}

#if lang == "en" {
  include "chapters/distribution.en.typ"
} else {
  include "chapters/distribution.typ"
}

#if lang == "en" {
  include "chapters/acyclique.en.typ"
} else {
  include "chapters/acyclique.typ"
}

#if lang == "en" {
  include "chapters/conclusion.en.typ"
} else {
  include "chapters/conclusion.typ"
}


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

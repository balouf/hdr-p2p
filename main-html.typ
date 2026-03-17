// =============================================================================
// HDR : Autour du pair-à-pair — Distribution de contenus,
//       réseaux à préférences acycliques
// Point d'entrée pour l'export HTML
// =============================================================================
//
// Compilation:
//   typst compile --features html --format html --input lang=fr --input html=true main-html.typ web/dist/full.html
//   typst compile --features html --format html --input lang=en --input html=true main-html.typ web/dist/full.html
// =============================================================================

// -----------------------------------------------------------------------------
// Imports
// -----------------------------------------------------------------------------

#import "templates/i18n.typ": lang, t
#import "templates/thesis-style.typ": *
#import "templates/meta-data.typ": *
#import "templates/math-macros.typ": *
#import "templates/environments.typ": *
#import "templates/algorithms.typ": *
#import "templates/acronyms.typ": *
#import "templates/html-overrides.typ": *
#import "templates/prelude.typ": double-vowels

// Initialiser les acronymes
#init-acronyms(acronyms)

// Appliquer le style de thèse (page/headers seront ignorés en HTML, c'est OK)
#show: thesis-style

// Appliquer les ligatures œ/æ
#show: double-vowels

// Appliquer les show rules HTML (math → SVG, grid → SVG)
#show: html-show-rules

// Configurer les théorèmes
#show: thmrules


// -----------------------------------------------------------------------------
// Métadonnées HTML
// -----------------------------------------------------------------------------

#set document(
  title: t(
    "Autour du pair-à-pair — Distribution de contenus, réseaux à préférences acycliques",
    "On Peer-to-peer — Content Distribution, Acyclic Preference Networks",
  ),
  author: "Fabien Mathieu",
)

// -----------------------------------------------------------------------------
// Page de titre (version HTML simplifiée)
// -----------------------------------------------------------------------------

#chapter-section("cover")[
  #include "chapters/cover.typ"
]

// -----------------------------------------------------------------------------
// Avertissement
// -----------------------------------------------------------------------------

#chapter-section("disclaimer")[
  #include "templates/disclaimer.typ"
]

// -----------------------------------------------------------------------------
// Remerciements
// -----------------------------------------------------------------------------

#chapter-section("remerciements")[
  #if lang == "en" {
    include "chapters/remerciements.en.typ"
  } else {
    include "chapters/remerciements.typ"
  }
]

// -----------------------------------------------------------------------------
// Avant-propos
// -----------------------------------------------------------------------------

#chapter-section("avant-propos")[
  #if lang == "en" {
    include "chapters/avant-propos.en.typ"
  } else {
    include "chapters/avant-propos.typ"
  }
]

// -----------------------------------------------------------------------------
// Introduction
// -----------------------------------------------------------------------------

#chapter-section("introduction")[
  #if lang == "en" {
    include "chapters/introduction.en.typ"
  } else {
    include "chapters/introduction.typ"
  }
]

// -----------------------------------------------------------------------------
// Positionnement
// -----------------------------------------------------------------------------

#chapter-section("positionnement")[
  #if lang == "en" {
    include "chapters/positionnement.en.typ"
  } else {
    include "chapters/positionnement.typ"
  }
]

// -----------------------------------------------------------------------------
// Distribution de contenu
// -----------------------------------------------------------------------------

#chapter-section("distribution")[
  #if lang == "en" {
    include "chapters/distribution.en.typ"
  } else {
    include "chapters/distribution.typ"
  }
]

// =============================================================================
// Chapitre principal : Réseaux à préférences acycliques (décomposé)
// =============================================================================

#chapter-section("acyclique")[
  #if lang == "en" {
    include "chapters/acyclique-html-intro.en.typ"
  } else {
    include "chapters/acyclique-html-intro.typ"
  }
]

#chapter-section("acyclique-origine")[
  #if lang == "en" {
    include "chapters/acyclique-origine.en.typ"
  } else {
    include "chapters/acyclique-origine.typ"
  }
]

#chapter-section("acyclique-bases")[
  #if lang == "en" {
    include "chapters/acyclique-bases.en.typ"
  } else {
    include "chapters/acyclique-bases.typ"
  }
]

#chapter-section("acyclique-convergence")[
  #if lang == "en" {
    include "chapters/acyclique-convergence.en.typ"
  } else {
    include "chapters/acyclique-convergence.typ"
  }
]

#chapter-section("acyclique-stable")[
  #if lang == "en" {
    include "chapters/acyclique-stable.en.typ"
  } else {
    include "chapters/acyclique-stable.typ"
  }
]

#chapter-section("acyclique-conclusion")[
  #if lang == "en" {
    include "chapters/acyclique-conclusion.en.typ"
  } else {
    include "chapters/acyclique-conclusion.typ"
  }
]

// -----------------------------------------------------------------------------
// Conclusion
// -----------------------------------------------------------------------------

#chapter-section("conclusion")[
  #if lang == "en" {
    include "chapters/conclusion.en.typ"
  } else {
    include "chapters/conclusion.typ"
  }
]

// -----------------------------------------------------------------------------
// Bibliographie
// -----------------------------------------------------------------------------

#chapter-section("bibliography")[
  #bibliography("references.bib", style: "springer-lncs-alphabetical.csl")
]

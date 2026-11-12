// =============================================================================
// HDR : Autour du pair-à-pair
// Point d'entrée de l'édition web (une page HTML par chapitre)
// =============================================================================
//
// Site complet (deux langues, PDF, index de recherche) :
//   uv run web/build.py
// Une langue à la main :
//   typst compile --features html,bundle --format bundle --input lang=fr main-html.typ web/dist/fr
//
// Les chapitres et les environnements sont les mêmes que dans main.typ. Ce qui
// diffère est ici : pas de mise en page (thesis-layout), la couche web à la
// place (templates/web/web.typ, copie vendorisée de typst-thesis-web), et un
// `chapter(...)` par page du site.
// =============================================================================

// -----------------------------------------------------------------------------
// Imports
// -----------------------------------------------------------------------------

#import "templates/i18n.typ": lang, t, _appendix-state, reset-chapter-counters
#import "templates/thesis-style.typ": thesis-content
#import "templates/meta-data.typ": *
#import "templates/math-macros.typ": *
#import "templates/environments.typ": *
#import "templates/algorithms.typ": *
#import "templates/acronyms.typ": *
#import "templates/prelude.typ": *
#import "templates/web/web.typ": page, part, site-assets, web-rules

// Initialiser les acronymes
#init-acronyms(acronyms)

// -----------------------------------------------------------------------------
// Règles. L'ordre compte : les règles qui remplacent un élément, puis la couche
// web, puis les règles qui renvoient l'élément reçu.
// -----------------------------------------------------------------------------

#show: thesis-content
#show: thmrules

// Police du PDF : en HTML elle ne sert qu'à l'intérieur des cadres SVG (grilles
// de figures, algorithmes, diagrammes), le texte courant suit la feuille de style.
#set text(font: "New Computer Modern", size: 12pt)

// Préfixe des titres : « Chapitre 3 — », « Annexe A — », puis « 3.1 ».
#let numero-titre(it, n) = {
  if it.level == 1 {
    let prefix = if _appendix-state.get() { t([Annexe], [Appendix]) } else { t([Chapitre], [Chapter]) }
    [#prefix #n — ]
  } else if it.level <= 3 [#n ]
}

#show: web-rules.with(
  heading-offset: 0, // le titre d'un chapitre est le <h1> de sa page
  heading-number: numero-titre,
)

// Les compteurs repartent à chaque chapitre (en PDF, thesis-layout s'en charge).
#show heading.where(level: 1): it => it + reset-chapter-counters()

// -----------------------------------------------------------------------------
// Site
// -----------------------------------------------------------------------------

#set document(author: "Fabien Mathieu")

#let site = (
  title: t(
    "Autour du pair-à-pair — Distribution de contenus, réseaux à préférences acycliques",
    "On Peer-to-peer — Content Distribution, Acyclic Preference Networks",
  ),
  repo: "https://github.com/balouf/hdr-p2p",
  other-lang: t("en", "fr"),
  favicon: "assets/favicon.svg",
)
#let chapter = page.with(site: site)
// Entrée secondaire de la navigation (liminaires, sections du chapitre 4).
#let subchapter = chapter.with(sub: true)

#site-assets(extra: ("assets/favicon.svg": read("web/assets/favicon.svg")))

// -----------------------------------------------------------------------------
// Pages. Le chemin est le nom du fichier sur le site, donc l'URL publique : ne
// pas le changer. Le titre est l'entrée de la navigation.
// -----------------------------------------------------------------------------

#chapter("index.html", title: t([Accueil], [Home]))[
  #include "chapters/cover.typ"
]

#subchapter("disclaimer.html", title: t([Avertissement], [Disclaimer]))[
  #include "templates/disclaimer.typ"
]

#subchapter("remerciements.html", title: t([Remerciements], [Acknowledgments]))[
  #if lang == "en" { include "chapters/remerciements.en.typ" } else { include "chapters/remerciements.typ" }
]

#subchapter("avant-propos.html", title: t([Avant-propos], [Foreword]))[
  #if lang == "en" { include "chapters/avant-propos.en.typ" } else { include "chapters/avant-propos.typ" }
]

#chapter("introduction.html", title: [Introduction])[
  #if lang == "en" { include "chapters/introduction.en.typ" } else { include "chapters/introduction.typ" }
]

#chapter("positionnement.html", title: t([Positionnement], [Positioning]))[
  #if lang == "en" { include "chapters/positionnement.en.typ" } else { include "chapters/positionnement.typ" }
]

#chapter("distribution.html", title: t([Distribution de contenu], [Content Distribution]))[
  #if lang == "en" { include "chapters/distribution.en.typ" } else { include "chapters/distribution.typ" }
]

// -----------------------------------------------------------------------------
// Réseaux à préférences acycliques : en PDF, acyclique.typ inclut ses cinq
// sections ; ici chacune a sa page, et l'introduction du chapitre vient d'une
// copie (acyclique-html-intro) du début de acyclique.typ.
// -----------------------------------------------------------------------------

#chapter("acyclique.html", title: t([Préférences acycliques], [Acyclic Preferences]))[
  #if lang == "en" { include "chapters/acyclique-html-intro.en.typ" } else { include "chapters/acyclique-html-intro.typ" }
]

#subchapter("acyclique-origine.html", title: t([Origine], [Origin]))[
  #if lang == "en" { include "chapters/acyclique-origine.en.typ" } else { include "chapters/acyclique-origine.typ" }
]

#subchapter("acyclique-bases.html", title: t([Les bases], [Foundations]))[
  #if lang == "en" { include "chapters/acyclique-bases.en.typ" } else { include "chapters/acyclique-bases.typ" }
]

#subchapter("acyclique-convergence.html", title: t([Auto-stabilisation], [Self-stabilization]))[
  #if lang == "en" { include "chapters/acyclique-convergence.en.typ" } else { include "chapters/acyclique-convergence.typ" }
]

#subchapter("acyclique-stable.html", title: t([Configurations stables], [Stable Configurations]))[
  #if lang == "en" { include "chapters/acyclique-stable.en.typ" } else { include "chapters/acyclique-stable.typ" }
]

#subchapter("acyclique-conclusion.html", title: t([Conclusion du chapitre], [Chapter Conclusion]))[
  #if lang == "en" { include "chapters/acyclique-conclusion.en.typ" } else { include "chapters/acyclique-conclusion.typ" }
]

// -----------------------------------------------------------------------------
// Conclusion et bibliographie
// -----------------------------------------------------------------------------

#chapter("conclusion.html", title: t([Synthèse et perspectives], [Synthesis and Perspectives]))[
  #if lang == "en" { include "chapters/conclusion.en.typ" } else { include "chapters/conclusion.typ" }
]

#chapter("bibliography.html", title: t([Bibliographie], [Bibliography]))[
  #bibliography("references.bib", style: "springer-lncs-alphabetical.csl")
]

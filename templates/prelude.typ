// =============================================================================
// Prelude - Imports communs pour tous les chapitres
// =============================================================================
//
// Usage dans les chapitres :
//   #import "../templates/prelude.typ": *
// =============================================================================


#let double-vowels(body) = {
  show "oe": "œ"
  show "Oe": "Œ"
  show "ae": "æ"
  show "Ae": "Æ"
  // autres règles...
  body
}

#import "environments.typ": *
#import "math-macros.typ": *
#import "algorithms.typ": *
#import "acronyms.typ": *

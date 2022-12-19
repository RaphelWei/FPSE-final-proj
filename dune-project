(lang dune 3.4)

; (name Chess)

; (generate_opam_files true)

; (source
;  (github username/reponame))

; (authors "Author Name")

; (maintainers "Maintainer Name")

; (license LICENSE)

; (documentation https://url/to/documentation)

; (package
;  (name Chess)
;  (synopsis "A short synopsis")
;  (description "A longer description")
;  (depends ocaml dune)
;  (tags
;   (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project

(generate_opam_files true)
(authors "Jiarui Wang")
(maintainers "none")
(package
 (name Chess) ; put in your own project name here
 (synopsis "A Chinese game")
 (description "A longer description")
 (depends
  (ounit2 (> 2.2.5)) ; for each opam dependency list the version
  (core (> 0.15.0)) ; `opam list core` will display which version of core you have
  (dream (> 1.0.0))
))

# Onboarding

Note: I (Nick) am writing this document in the first person. Writing in the
third person about yourself started to feel stupid.

First things to do:
- Read the dUSD whitepaper
  https://github.com/ArdanaLabs/apps-team/blob/dusd-whitepaper/ardana-dollar/ardana-dollar.tex
  * You can generate the pdf by running `nix-build` on
    https://github.com/ArdanaLabs/apps-team/blob/dusd-whitepaper/ardana-dollar/default.nix
  * This (technical) whitepaper is slightly out of date, but is by far the best
    document to learn the jargon specific to this project
- Read the dUSD spec
  https://github.com/ArdanaLabs/dUSD/blob/master/docs/dusd-spec.tex
  * You can generate the pdf by running `latexmk` on the .tex file
  * Alternatively, run `nix run .#feedback-loop` in the root of the git repo
    - Given `haskell.nix` issues, this also builds Haskell code though, so it
      could take a while to build
  * This document is the single source of truth on the dUSD project. It is,
    however, a living document.
    - If there is anything you disagree with in the spec, please let me know and
      we can talk about updating it
    - It is best to check it out once every while to stay up to date with what
      we're building and how we will do it
- Read the Hello World spec
  https://github.com/ArdanaLabs/dUSD/blob/master/docs/hello-world.tex
  * Generate the pdf same as for the dUSD spec
  * On any software project, there are three sources of complexity
    - Setting up a plan (spec), tooling and business logic
    - On most projects, the tooling is reasonably understood, and you can start
      building things rather quickly
    - Given how bleeding edge this project (and the Cardano ecosystem) is, we
      decided to start by building a Hello World project
    - The goal of the Hello World project: Build something minimal while
      exploring how to build production-grade projects in the Cardano system
- Read the workflow guidelines
  https://github.com/ArdanaLabs/apps-team/blob/master/workflow-guidelines.md
  * These are guidelines, not to be enforced
  * I wrote them to give you an idea of my understanding of _a_ solid,
    productive and safe software development process
    - This doesn't mean there are no other solid, productive and safe software
      development processes
    - It also doesn't mean that this process works on any project
    - I have found it useful in the past to know how others in my team think
      about the software development process. Hence the document.
  * Please let me know how you feel about the guidelines. Please feel free to
    disagree with the guidelines, it's the only way I can learn!

# Jargon on Cardano

Note: If anything is not included here that confused you at first, please add it
here, to help the rest of the team.

- dUSD = stablecoin = Ardana USD
- DANA = governance token (involved with exDANA as well, but ignore that for
  MVP)
- DEX = decentralized exchange
- Danaswap = our DEX. Project was started but deprioritized for now so we can
  focus all our resources on the stablecoin MVP first.
- PAB = Plutus Application Backend
- IOG = IOHK = Input Output Hong-Kong (Input Output Global)
- Cardano = IOG + CF (Cardano Foundation). The Cardano Foundation is the
  non-profit organization that "owns" Cardano, IOG builds everything

# What if I need help?

Anyone in the team is happy to help you out on anything they can. However, it
seems useful to give you an idea whom to reach out to if you have an issue with
a specific topic. Hence this list:
- Nix: Lee (`nixinator` on Discord) / Matthew (`matthewcroughan`), from the
  Ardana Nix team
- Plutus: Dan Firth (`locallycompact`), from the Ardana Orbis team
- PAB E2E testing: Tommy (`tbidne`), from the Ardana Apps team
- Frontend: Kai (`kai.dao.platonic`), from the Ardana Frontend team




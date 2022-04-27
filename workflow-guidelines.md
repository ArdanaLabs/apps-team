# About this document

This is a document explaining a possible, productive workflow. This is reference
material, nothing to be enforced.

# Workflow guidelines

Workflow:
- Design is important, every software project deserves a design document
  * What is the goal of the project?
  * What does "done" look like?
  * What is important in making design decisions about this project?
  * List the design decisions which need to be made. For each decision, list the
    options and their pros and cons.
  * For an example, see `design/price-oracle.md`
  * What are the acceptance criteria? This is a list of things which, if true,
    mean that the project is done and can go into production.
  * Turn the acceptance criteria into (descriptions of) tests
- Next step: Break down the project into subprojects or subfeatures
  * As a rule of thumb, a subproject tends to be under 150 LoC
  * Each subproject must be self-contained, i.e. it can be built and tested
    without depending on things that aren't ready yet
    - For example, the dUSD vaults depend on price oracles, so we start by
      building price oracles
  * Each subproject must be tested, and the tests should be written before any
    code, to make sure you
    - have a good design
    - write tests
    - set up a proper feedback loop to see if/when you're done
    - code is written such that it can be tested
  * Each subproject/subfeature leads to a PR, to be reviewed by at least one
    person. If it touches any Nix code, a Nix engineer must review.
    - When you create a PR, please ping your reviewers, to make sure they're
      aware. Too many people turn off GitHub notifications to rely on those.

GitHub branches:
- For each project you start working on, create a feature branch with a sensible
  name. There is no specific format for GitHub branches.
- Create sub-feature branches
- For each sub-feature, you can create a PR from the sub-feature to the feature
  branch and ping the right people for a review

Notes:
- TDD doesn't deny design-first, it enforces it
  * It is possible to start implementing something without fully thinking
    through the design first. Testing, not so much.
- I have found the 150 LoC/PR idea a good rule of thumb. Not everything fits
  into that.
  * The use of feature and subfeature branches can be very productive




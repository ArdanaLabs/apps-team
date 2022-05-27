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

# Frontend workflow

All feature PRs will point to `staging`. Once every while, a PR can be created
from `staging` to `master`. Whenever this happens, Hao will go through the QA
process, making sure the new version of the website is ready to go into
production. The QA process includes both looking at generated HTML/CSS/JS and
the deployed staging website (on different browser).

When someone notices a bug (in production or staging), someone from the frontend
team should get in touch to set up a bug report together with the person who
first noticed the bug. A regression test should be set up (either an automated
test, or in the QA process).

Given the different expertises in the frontend team, we have decided to split
the frontend in half:
- The first half contains all the structure and design of the websites, but no
  business logic
  * Built by Greg
  * Tooling: EJS + esbuild, to generate HTML/CSS-based websites with a bit of JS
  * The result of this work is the single source of truth on what the HTML/CSS
    of the production website should be
- The second half is the business logic
  * Built by Hao and Peter
  * These components will be designed by Greg first, but without the business
    logic
  * The components which require business logic, will be rebuilt in Purescript
    to generate the exact same HTML as what Greg wrote, but with business logic
- This way everyone can work through tools they are more comfortable and
  familiar with (compared to fp-ts), and build great websites
- Note: The landing pages don't contain any business logic, so they will be
  entirely built by Greg




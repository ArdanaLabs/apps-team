# Developer experience

- Which formatters?
  * HTML
  * CSS
  * Typescript
  * Nix!
  * Anything else?
- How do we enforce certain standards through linters?
  * Hlint allows you to block certain functions, libraries/modules and language
    extensions. Do we want the same for e.g. `null/undefined`?
  * How would we go about doing this?
- Which linters
  * Typescript
  * Anything else?
- The monorepo will be split up
  * There will be a separate `monorepo` for everything dUSD related, and one for
    Danaswap. That means the Ardana landing page will be alone.
  * Kai brought up issues here. Anything we should do about this?
    - "Nix works better"
    - Note: I think Nix shells might always have to be bash, for
      reproducibility. What would you like here?
- Staging environments
  * What will they be used for? How can we accomplish this?
  * What do we want in staging environments? `development`?
- PR reviews
  * When you open a PR, ping the relevant parties right away. Let's not rely on
    Github notifications.
  * Developers start their day with PR reviews, and don't do anything else until
    all PRs are reviewed
  * I will try to do the same to the extend possible, but keep in mind I have
    lots of meetings. Today I have 7.
  * 150 lines of code
    - How to accomplish this?
    - Should this be a 'guideline'?

Notes:
- "generally stay CLI and TUI-friendly whenever possible"
  * Not sure what this means?
- "create static pages if 'fancy' documentation is needed"
  * Nothing fancy should be needed. Markdown with nothing but headers and lists
    should suffice.
  * Where is documentation written in markdown that you (Kai) don't like?
- A kanban board is coming, but it will be derived from the test plan, which is
  currently being set up
  * This should create some clarity as to what needs to get done, who will do
    what, current status of the projects..




# Team responsibilities

DEX:
- Invariant equation solver RESTful API
- Link DEX with Stats & rollups, to store the states correctly
- DEX Admin API
- Create a second DEX to exchange ADA with dUSD
  * Research a good invariant equation, implement the equation and solver

Stablecoin:
- Price oracle off-chain code
- Vault off-chain code
- dUSD Admin API: Adjust parameters, trigger protocol-wide actions, treasury
  (and buffer) to hold governance-owned assets
- Vault liquidation arbitrage bot

Others:
- Maeserat & E2E testing
- Hardware security module
- Ardana tenant Nix expression
- Merge repos into a birepo: One haskell.nix repo, one non-haskell.nix repo

# Doing

- Athan: Invariant equation solver
- Tommy: Setting up basic E2E testing framework
- Matthew: Figuring out the genesis transaction generation to set up a more
  complex E2E testing framework
- Oleg: Hardware security module
- Nick: Move Stats to a stack-based project




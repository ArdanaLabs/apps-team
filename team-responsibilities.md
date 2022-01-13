# Team responsibilities

DEX:
- Invariant equation solver RESTful API
  * Build the RESTful API
  * Integrate the API with Danaswap
  * Add an endpoint to Stats to produce a price quote for a trade
- Finish Stats
  * Link DEX with Stats & rollups to store the states correctly
  * Make sure Stats recovers well after downtime
- DEX Admin API
- Create a non-stablecoin DEX (initially ADA <-> dUSD)
- Upgrade Danaswap to Aeson >= 2.0.1.0

Stablecoin:
- Understand exactly what is there already: Code, docs, design decisions still
  to be made...
- Price oracle off-chain code
- Vault off-chain code
- dUSD Admin API: Adjust parameters, trigger protocol-wide actions, treasury
  (and buffer) to hold governance-owned assets
- Vault liquidation arbitrage bot

Others:
- Maeserat & E2E testing
- Hardware security module
- Ardana tenant Nix expression
- Deploy contracts to mainnet
- Haskell package management
  * Look into stacklock2nix
  * Stack + nix?
  * Merge repos into a birepo: One haskell.nix repo, one non-haskell.nix repo?
- Improve CI: Dangerous functions list

# Doing

- Athan: Invariant equation solver
- Tommy: Setting up basic E2E testing framework
- Matthew: Genesis transaction generation for more complex E2E testing framework
- Oleg: Hardware security module
- Nick: Understand the current status of the dUSD project

# Blocked

- YubiHSM2 server access
- Genesis transaction generation
- Nix issue with the basic E2E testing framework
- The smart contracts team is ready to implement on-chain code
  * Set up a test to make sure on-chain and off-chain match
  * Set up designs for each component: DEX, DEX Admin, price oracle, vault,
    buffer, dUSD Admin
- Invariant equation: What is the goal of the non-stablecoin DEXes at launch?




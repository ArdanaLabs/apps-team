# Team responsibilities

DEX:
- Invariant equation solver RESTful API
  * Build the RESTful API or library
  * Integrate with Danaswap and Stats
  * Add an endpoint to Stats to produce a price quote for a trade
- Finish Stats
  * Set up testing environment for Stats + Danaswap
  * Link DEX with Stats & rollups to store the states correctly
  * Make sure Stats recovers well after downtime
- DEX Admin CLI
- Create a non-stablecoin DEX (initially ADA <-> dUSD): Implement invariant
  equation and solver and test (including boundary finder)

Stablecoin:
- Understand exactly what is there already: Code, docs...
- Set up design documents
- Set up a testing environment and test the code that is already there (except
  what will be thrown out)
- Price oracle off-chain code
- Vault off-chain code
- dUSD Admin API: Adjust parameters, trigger protocol-wide actions, treasury
  (and buffer) to hold governance-owned assets
- Vault liquidation arbitrage bot
- Build a backend between the dUSD PAB and StablecoinUI

Frontend:
- Ardana website
- DanaswapUI
- StablecoinUI
- Orbis website

Others:
- Maeserat & E2E testing
- Hardware security module
- Ardana tenant Nix expression
- Deploy contracts to mainnet
- Improve CI: Dangerous functions list

# Doing

- Athan: Invariant equation solver
- Tommy: E2E testing framework setup
- Matthew: E2E testing framework setup
- Oleg: Hardware security module
- Nick: Onboard new reports & understand the dUSD and frontend current status
  and goals

# Blocked

- Nix issue integrating the basic E2E testing framework with CI
- Tests that on-chain and off-chain code match
- On-chain/off-chain interface specs
- Invariant equation: What are the goal and constraints on the non-stablecoin
  DEXes at launch?




# Team responsibilities

DEX:
- Invariant equation solver RESTful API
  * Rewrite the solver using Doubles
  * Benchmark
  * Integrate with Danaswap
  * Add an endpoint to Stats to produce a price quote for a trade
- Finish Stats
  * Set up testing environment for Stats + Danaswap
  * Link DEX with Stats & rollups to store the states correctly
  * Make sure Stats recovers well after downtime
- DEX
  * Make the address of the pools deterministically predictable, to make
    discovering pools easy
  * Anyone can create the first pool for a given trading pair, but the second
    one requires the admin API
  * Set up a minting policy for liquidity tokens
    https://github.com/ArdanaLabs/DanaSwap/issues/234
  * Test and finalize Danaswap
  * Admin CLI
- Create a non-stablecoin DEX (initially ADA <-> dUSD): Implement invariant
  equation and solver and test (including boundary finder)

Stablecoin:
- Write a whitepaper
- Set up design documents
- Set up a testing environment
- Decide which code should be tested and which should be thrown out
- Price oracle
- OSM
- Vault
- Buffer: Adjust parameters, trigger protocol-wide actions (surplus auctions,
  debt auctions..)
- Vault liquidation arbitrage bot
- Connect the dUSD PAB and StablecoinUI

Frontend:
- Ardana website
- DanaswapUI
- StablecoinUI
- Orbis website

Others:
- Maeserat & E2E testing
- Hardware security module
  * DevOps the YubiHSM code
  * Write a script to put a Cardano wallet's private key on a YubiHSM2, and test
  * Write a script to Cardano-sign using a YubiHSM2, and test
  * Figure out how Cardano signing works
  * Integrate YubiHSM signing with the Cardano PAB
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




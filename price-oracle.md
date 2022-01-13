# Price oracle

The price oracle bot needs to pull the exchange rate between USD and ADA (or
other collateral/pegged currency price) from an external source (some kind of
exchange) and put that price into the oracle contract state at periodic
intervals where that price can be accessed by other contracts that are part of
ardana-dollar (e.g. vaults, debt and surplus auctions).

What should we optimize for?
- Security
- Resistence to price manipulations
- Resistence against unknown unknowns
- Implementation time
- dUSD ecosystem stability: Vault liquidations don't occur too late too often

Current status:
- Single, private-key oracle. It hasn't been decided yet where that price
  could/would come from.

# How the price oracle gets updated

The creator of the price oracle can update it, his public key identifying the
oracle.

Q: Does this mean one wallet can only create one price oracle?

# Price oracle sources

Do we pull the price from a single source? Several sources? (We could pull from
a single source and leave the task of managing multiple price feeds to on-chain
code.)

Option 1. Single source
+ Easy to implement

Option 2. Multiple sources
- Much, much more complexity
  * More implementation work
  * More verification work: Which oracles can be trusted?
  * How to determine one price from multiple sources? Take the median?
  * How do new price oracles get added/removed?
+ Flexibility towards the future: Add/remove price oracles to keep the system
  trusted

# Price delay

Option 1. Delay by a certain time period & allow governance to block an oracle
+ Protection against manipulation
- If the price crashes, liquidations might not happen in time

Option 2. Don't delay

Option 3. Only delay in case of heavy price fluctuations

Option 4. Use exponential delay
  * `p_used = (1 - a) * p(t) + a * p(t')` where `p(t)` is the price at time `t`
    and `a = e^{t'-t}`

Questions:
- How common is manipulation on MakerDAO? How impactful?
- How necessary is a sense of smearing the price out, so as to avoid very short
  term fluctuations being abused?
- How big of a problem have price crashes been for MakerDAO?

# Oracle security module

https://docs.makerdao.com/smart-contract-modules/oracle-module/oracle-security-module-osm-detailed-documentation
The only purpose of the Oracle Security Module in MakerDAO seems to be delaying
the price by 1 hour.

If we are implementing this it needs to go on-chain, if that is off-chain code
there is no way to tell if the price actually was delayed.

Option 1. Yes
+ In MakerDAO this gives time to react to price manipulations
- Harder to implement
- In an event of an actual price crash the liquidators cannot
  get the value they would do otherwise (the collateral they
  are buying is worth less now)

Option 2. No

# If there are multiple oracles, who decides which ones to add?

Governance decides. We can't think of another option.

# How to interact with the price oracle

Option 1. PAB
+ The PAB is set up, we know how it works
+ An E2E testing framework to run against the PAB is currently being set up
- The PAB is not working with actual networks right now (testnet and mainnet)
  and it is not known when it will be ready

Option 2. Purescript-based project
  * https://github.com/Plutonomicon/cardano-browser-tx
+ Can run directly in the browser
- Early-stage project
- PS compiles to JS, which doesn't have anything that can represent moneys

# Earlier MakerDAO architecture

The biggest difference between modern and initial MakerDAO is that initially it
only supported ETH as collateral and was named Single-Collateral DAI (SAI).

Multi-Collateral DAI appears to be introduced in November 2019
https://blog.makerdao.com/zero-to-one-billion-dai-five-years-of-growth-for-makerdao/.




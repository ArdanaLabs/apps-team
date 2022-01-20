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

# How the price oracle gets updated and identified

The creator of the price oracle can update it, his public key identifying him as
the person allowed to update the oracle.

Price oracles themselves will be identified by an NFT or TxOutRef (from their
creation), to asure one wallet can create multiple price oracles. (If the
wallet's public key is used to identify price oracles, only one can be created.)

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

Proposal: Each price oracle is recommended to only use one source (though this
off-chain code, and hence cannot be enforced). The dUSD ecosystem takes the
median of multiple price oracles, to reduce exposure to price manipulations.

# Price delay

Should we add a delay in the prices?
- Delays are needed to allow governance to defend against price manipulations
- Delays could lead to liquidation trouble if the price of the collateral drops

Questions:
- How common is manipulation on MakerDAO? How impactful?
- How necessary is a sense of smearing the price out, so as to avoid very short
  term fluctuations being abused?
- How big of a problem have price crashes been for MakerDAO?
  * Related to network congestion and lack of liquidation bot instances
  * Liquidation auctions are dangerous, if there aren't enough people/bots
    bidding

Proposals:
- Algorithmic liquidation: Liquidation price is set to be a small discount
  compared to the price oracles' price
- Delay by 1h, to avoid price manipulation issues
  * Price crashes don't matter anyway if the collateral's price goes up again
  * If the price doesn't go up again, 
- Price smearing (i.e. using moving averages of the price from a given source)
  will be left up to the price oracle's off-chain code
  * Enforced by governance judging each specific oracle to (not) let it into the
    list of used oracles

# Oracle security module

The OSM is a smart contract which tracks a list of governance-allowed price
oracles, and outputs the currently accepted price within the dUSD ecosystem with
a 1 hour delay. One OSM exists per collateral asset class.
https://docs.makerdao.com/smart-contract-modules/oracle-module/oracle-security-module-osm-detailed-documentation

We need this in order to actually implement the merging of multiple price
oracles, tracking which oracles are accepted, and add the delay.

# If there are multiple oracles, who decides which ones to add?

Governance decides.

# How to interact with the price oracle

Option 1. PAB
+ The PAB is set up, we know how it works
+ An E2E testing framework to run against the PAB is currently being set up
- The PAB is not working with actual networks right now (testnet and mainnet)
  and it is not known when it will be ready
- Requires us to wait for IOHK to build a dApp store

Option 2. Purescript-based project
  * https://github.com/Plutonomicon/cardano-browser-tx
+ Can run directly in the browser
- Early-stage project
- PS compiles to JS, which doesn't have anything that can represent moneys

# How to turn multiple prices into one

Proposal: Take the median.

# Do we want to add emergency shutdowns?


# Do we want to use read-only UTXOs?

See CIP-31. Might take a while to be on mainnet.

# What are the effects of price manipulations on MakerDAO?

Black Thursday: Submit transactions with too small a gas fee. These get
rejected, but forms a DoS attack. As a result, the attack could take all the
MakerDAO auctions at a very, very low price. This is the only price manipulation
attack on MakerDAO so far.

Worries for us:
- Block space is small, so resource contention is an issue




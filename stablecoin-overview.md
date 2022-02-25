# dUSD protocol

We are building a stablecoin called the Ardana dollar (dUSD), using a
MakerDAO-like protocol based on overcollateralized vaults. Initially, the only
allowed collateral class will be ADA.

Liquidation mechanism:
- The collateral-to-debt (CtB) ratio must initially be at least 1.5
- When this ratio drops below 1.2, the vault opens up to external parties
  liquidating part of the vault, until the ratio is back up to 1.5
- If the ratio drops below 1.0, liquidation will no longer happen, so the buffer
  must mint dUSD and pay back the debt instead
  * This shouldn't happen too often, as it decreases the dUSD price

When the dUSD price goes up:
- Users create more dUSD debt
- Daily savings rate (DSR) goes down
- Stability fee goes up
- Surplus auctions

If the dUSD price drops:
- Users pay back their dUSD debt
- Daily savings rate (DSR) goes up
- Stability fee goes down
- Debt auctions

Notes:
- We will create a buffer to hold the system's profits. This buffer will be able
  to mint and burn dUSD for surplus/debt auctions.
- In surplus auctions, the buffer mints dUSD and sells them for DANA, in order
  to decrease the dUSD price
  * The DANA is locked in the buffer, increasing the value of DANA, which is how
    profits are generated
- What must be built: Price oracle, OSM, vault, liquidity bot, buffer

Design decisions:
- How to modulate between the three protocol/admin-governed stability
  mechanisms: DSR, stability fee and surplus/debt auctions
- Which data should the price oracle store?
  * Option 1. Just the most recent price
  * Option 2. The price fluctuations in the last 48h, allowing people to prove a
    vault has been in trouble for 48h+
- Do we want to set a minimum vault deposit?
- Do we want to implement an emergency shutdown procedure?
  * We can ignore this question for the coming months, and re-evaluate once
    everything else has been built
- How big should the liquidation fee (punishment for the vault owner) be?

# Ensuring stablecoin backing

The stablecoin system contains three major parts:
- Price oracle: Smart contract which keeps an up to date exchange rate between
  ADA and USD
- Vault: Smart contract in which collateral (ADA) can be locked and dUSD
  borrowed. Includes repaying debt, withdrawing collateral and liquidations.
- Governance: Change system parameters, add/remove price oracles or collateral
  asset classes, pay or withdraw admin fees

Several mechanisms keep the price stable in addition to the
over-collateralization itself:
- Collateral auctions
- Buffers
- Keepers

## Collateral auction

Collateral or liquidation auctions are the first step in ensuring that the total
amount of dUSD in circulation stays backed.

Each vault has a collaterizaion ratio, defined as the ratio of the collateral
dollar value to the outstanding dUSD debt:
```
cRatio = (collateral * price in USD) / debt
```

There is a global protocol-level parameter called the minimum collaterization or
liquidation ratio. In the MakerDAO system, the parameter is set to 150%.
Whenever a vault's collaterization ratio drops below the liquidation ratio due
to a drop in the collateral's price, the vault becomes available for
liquidation. This opens up an auction where the collateral is partially sold to
bidders at a discount until the collaterization ratio is back above the
liquidation ratio.

Design decisions:
- How will vault liquidations work for dUSD? Through a public auction?
- If an auction, how long will the auction be open?

## Buffers

Imagine vault liquidations happen too late, and some of the dUSD debt cannot be
paid back. The protocol will continuously put a part of its profits into a
buffer (both in dUSD and ADA), which will be used to pay back this remaining
debt.

Notes:
- In the MakerDAO system, there is another fail safe called debt/surplus
  auctions
  * However, this requires minting and selling governance tokens, thus diluting
    the supply, which Ardana is not set up to allow.
  * Problem: Surplus auctions are how the MakerDAO makes money for the
    governance owners, namely by burning governance tokens

# Price stabilization

## Open market mechanisms: Keepers

If the dUSD price is below 1 you can buy dUSD on the open market for a given
collateral and buy that type of collateral in a liquidation auction.

If the dUSD price is above 1 you can open new vaults and sell the borrowed dUSD
in the market (you need to repay the loan eventually so also the complete
picture is not clear).

Generally you can also keep a buffer of dUSD and collateral, and buy/sell dUSD
to compensate for price fluctuations. If the fluctuations are sufficiently
large and fast, this is a reasonable way to arbitrage the system in Ardana's
favor. The smaller and slower the fluctuations, and the more statistically
biased they are, the more money the keeper would be required to have in order to
do a good job. At launch, Ardana will not set up a keeper of its own.

## Stability fees

For every collateral type there is a governance-set parameter called the
stablity fee. It works like an interest rate applied to a vault's outstanding
debt: Whenever you pay your dUSD debt back, you pay the amount you initially
loaned plus the stability fee. It contributes to price stabilization by
controlling demand for dUSD: If you have a loan in dUSD you need to pay back
more than what you started with, so you need to buy that dUSD somewhere.

# Current state of ardana-dollar

- All on-chain (PlutusTx) code will be replaced by the Smart Contracts team
- Off-chain code
  * The price oracle and vaults have a first implemented version
  * Will have to be updated subject to design changes of the oracle and the
    on-chain code




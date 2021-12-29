# Ensuring stablecoin backing

Note: This is a description of how things work on MakerDAO, not dUSD. Within
dUSD, we cannot freely mint more governance tokens, so a buffer will be used
instead (filled through part of the stability fee profits) to temporarily stop
certain issues.

## Collateral auction

Collateral (or liquidation) auctions are the first step in ensuring that the
total amount of dUSD in circulation stays backed.

For every vault we can talk of its collaterizaion ratio, the ratio of the
collateral dollar value to the outstanding dUSD debt:
```
cRatio = (collateral * price) / debt
```

There is a global protocol-level parameter called minimum collaterization (or
liquidation) ratio (it is set at 150% in MakerDAO), it is used in collateral
auctions as following: if the collaterization ratio of a vault drops below the
liquidation ratio due to price decline the vault becomes available for
liquidation: the collateral is partially sold to bidders at a discount until the
collaterization ratio is back above the liquidation ratio.

More details in MakerDAO here:
https://makerdao.world/en/learn/vaults/liquidation/

## Debt auction

If the collateral auctions did not restore backing in full and available dUSD
reserves are depleted a debt auction is triggered. Debt auctions are on the
protocol level, they start when the total amount of dUSD circulating exceeds the
total dollar value of all collateral in the protocol.

Debt auctions start when the unbacked dUSD amount makes for a certain percentage
of the total dUSD amount (probably a governance-set parameter).

In a debt auction, the governance token is minted and sold (thus diluting the
supply) for the dUSD which is then burned.

This is all part of the MakerDAO system. Unfortunately, Ardana governance tokens
(exDANA) cannot be minted. Not even DANA can be minted ad infinum. This means
that we need an alternative to the debt auction system (and possibly the surplus
auction system as well?). The alternative is to put together a buffer, filled
with part of the stability fee profits, and to use that to buy back dUSD and
burn it when necessary, i.e. when the amount of dUSD in circulation is bigger
than the amount that is backed by vaults.

## Surplus auction

Surplus auctions are the reverse of debt auctions: if the protocol accumulated
more dUSD reserves than it needs it can use those funds to buy back the
governance token (burning it).

Surplus auctions start when the accumulated funds exceed certain amount
(probably a governance-set parameter).

More details in MakerDAO here:
https://makerdao.world/en/learn/governance/param-system-surplus-buffer

# Price stabilization

## Open market mechanisms

If dUSD price is below 1 you can buy dUSD on the open market for a given
collateral and buy that type of collateral in a liquidation auction.

If dUSD price is above 1 you can open new vaults and sell the borrowed dUSD in
the market (you need to repay the loan eventually so also the complete picture
is not clear).

## Stability fees

For every collateral type there is a governance-set parameter called stablity
fee. It works like an interest rate applied to a vault's outstanding debt. It
contributes to price stabilization by controlling demand for dUSD: if you have a
loan in dUSD you need to pay back more than what you started with, so you need
to buy that dUSD somewhere.

# Current state of ardana-dollar

We started implementing some pieces of the protocol (price oracle, treasury,
governance token staking) in plain Plutus, however it is likely that the current
redesign will affect all of the on-chain code. A part of the redesign is moving
to an L2-based solution and we are not sure yet if that L2-based system will
look anything like the Cardano blockchain itself and its Plutus platform.

On a conceptual level, the most explored component is the price oracle.




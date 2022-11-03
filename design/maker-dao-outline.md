# Maker Protocol Modules

## Core

### Vat
- Central dependency free contract containing all business logic and data model
- Contains risk parameters, Dai, system debt, and collateral balances.
- Accounting
- Vault mgmt
  - Create DAI / receive collateral
- Vault fungibility
  - Transfer, split, and merge vaults
- Contract is designed rigidly, as it's structures are inherent to the core protocol

### Cat
- Seizes unsafe collateral (cat bites vault)
- Sells seized collateral for DAI in an Auction

### Spotter
- Oracle that stores market prices for each collateral type

## Collateral

### Joiner
- Deposits supported collateral types to vaults via adapters.

### Flipper
- Conducts auctions where investors bid on seized collateral with DAI until the vault’s DAI balance deficit is covered, avoiding insolvency.

## Dai Module

### Dai
- ERC20 tokens with the addition of mint and burn to control supply.

### DaiJoin
- Used by vault owner to mint and burn Dai.

## System Stabilizer

### About
Incentivizes keepers to maintain collateral value above liquidity level

### Components

#### Vow
- System Debt:
  - When Cat bites bad collateral, vow places the debt in a debt queue. If no flip auction occurs within an interval of time (?), it is then covered by a debt auction. DAI saving accumulation comes from increasing bad debt.
- System Surplus:
  - When there is additional internal DAI in the vow from stability fee accumulation, the DAI is discharged through surplus actions.

#### Flopper
- Debt Auction House
  - Auction of MKR for a fixed amount of DAI.
The amount of DAI is fixed but the amount of MKR is set by the bidder. This results in bidders competing by lowering the amount of MKR they are willing to exchange for the fixed DAI until the lowest bid wins.

  - The purpose is to raise the amount of debt as fast as possible and minimize MKR inflation (through decreasing bids).

#### Flapper
- Surplus Auction House
  - Sells a fixed amount of DAI for a bid amount of MKR.
  - Burns the winning MKR.
  - The purpose is to release surplus DAI.

## Oracle

### About
- Provides exchange rate to calculate value of collateral in a vault.
### Components

#### Medianizer
- Takes price estimates from trusted addresses and calculates the median for usage by Vat.

#### Oracle Security Module (OSM)
- Allows authorized users to set prices
- Delays the usage of them by an hour

## Mkr Module

### About
- Utility token: MKR holders can bid for fixed amount of DAI accrued from stability fees during a surplus auction.
- Governance token: MKR holders can vote on changes to the protocol.
- Recapitalization resource: MKR can be sold for a fixed amount of DAI during a debt auction.

### Components

#### DS-Token
ERC20 implementation of MKR token

### Mkr-Authority
- Allows flopper to call mint during debt auctions
- Allows flapper to call burn during surplus auctions

## Governance Module
### DS-Chief
- Allows any user to create a proposal object (DS-Spell), which  MKR holders can vote on by locking up their tokens in the contract.
- The proposal with the most approval has access to the Maker protocol through the Admin interface contract for Maker Governance.

### Polling Emitter
- Contains metadata on a poll. Anyone can create a poll and cast votes.
Polls are tallied off chain

### DS-Spell
- Unowned contract that performs a single preconstructed change to the Maker protocol.

### DS-Pause
- Delays a spell from being executed.
- Similar to OSM.

## Rates Module

### About
- Collect stability fees on vault debt
- Distribute DAI earned from locked DAI

### Components

#### Jug
- Apply stability fees on all outstanding Dai positions within the Vaults. Exposes drip function for updating debt unit rate.
#### Pot
- Incentivizes DAI holders to lock their tokens in the pot to accrue savings. Exposes drip function to update internal rate.

## Proxy Module
### About
Exposes interfaces for vault management and Maker government for end user

### Components

#### DssCdpManager
- Handles vault transfers and ownership
DSSProxyActions
- Used for personal ds-proxy (?). Oasis Borrow utilizes it. 
#### VoteProxy
- Facilitates online voting with offline MKR storage.

## Helper
### DS-Auth
- Helps restrict access to contract function calls
### DS-Note
Logging that easily indexable by blockchain client

## Emergency Shutdown
### About
- Last resort mechanism to protect against serious threat

### Components
#### End
- Facilitates the shut down
- Interface for Vault owner to claim collateral during shutdown
- Dai holders can claim proportional amount of collateral to Dai at USD value amount at the time.

#### ESM (Emergency shutdown module)
- Has ability to call End.cage() which initiates shutdown
- MKR holders join their funds in the contract to exceed minimum threshold to trigger End.cage(). All locked MKR are immediately burnt.

# Modules Under Development

## Instant Access Module
### About
- Allows changes to the Maker Protocol without consensus in DS-Chief.
### Components
#### RO (Rates oracle)
Updates Rates Module’s risk premium rates, base rate, and savings rate. Rate can be set by vote with MKR IOU from locking MKR in CD-Chief.

#### VO (Vault Oracle)
- Controlled by Risk Team
- Supports adding an NFT/LIEN Vault type on the fly

## Authorized Interface Module

### About
- Interface between system and governance

### Components
#### Mom
- Interface for adjusting risk parameters through DS-Chief proposal execution
#### INT-RO (Rates Oracle Interface)
- Interface for the rates oracle
- Has bounded authority over Rates Module
#### INT-VO (Vault Oracle Interface)
- Interface for VO contract.
- Authorized to add NFT/LEIN vault types



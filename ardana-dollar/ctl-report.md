# Cardano Transaction Library (CTL)

CTL is a PureScript SDK which allows for building smart contract transactions on cardano using browser wallets.
The goal of CTL is to move IOHKs `Contract` monad monad to the browser. But instead of being a standalone process, it is a library.

To achieve this CTL makes use of the `Cardano Serialisation Library` and `Ogmios`:

## Sub-components of CTL
### Cardano Serialisation Library
The CTL uses the Cardano-Serialization-Library ([CSL](https://docs.cardano.org/cardano-components/cardano-serialization-lib)) which is used for reliably serializing and deserializing Cardanos Haskell data structures.
That way CTL assures that transactions match the correct format.
CSL also provides wallet utilities like generating key-pairs, addresses and metadata handling.
CTL abstracts over CSL for a easier creation of transactions by querying the blockchain using ogmios.

### Ogmios
It is used by CTL to query the blockchain. Ogmios itself is a lightweight bridge interface for `cardano-node`, which basically allows for RPC calls of `cardano-node`.

### Ogmios Datum Cache
The CTL uses the `ogmios-datum-cache` which is a database storing datums instead of just hashes.

## Observations
### Capabilities so far:
 - building simple user to user transactions submittable using nami

### Incapabilities so far
 - build Plutus smart contract transactions using a DSL, i.e. lookups and constraits like in the `Contract` monad
 - wallet support beyond `Nami`

### Open questions CTLs Developers are asking themselves which could be interesting for us
- A lingering concern remains around storage solutions, if needed. This can be in memory, in various browser storage solutions, or a decentralized DB like Flure

### Possible Technical Debt/ Concerning Decisions
 - third party `ogmios-datum-cache` maintained by mlabs to allow for querying datums
 - a haskell server which allows to call cardano-library functions which are not implemented in purescript yet
 - only chromium based browsers are supported
 - Nami extensions need to be installed manually
 - testing the project requires nodejs e.g. `npm run unit-test`

## Our Questions
 - building Plutus smart contract transactions with a datum (can we also use non-unit redeemers?)
 - is there a ready-to use local testing environment
 - how does plutarch integrate into this

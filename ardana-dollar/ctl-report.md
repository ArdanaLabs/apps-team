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

### CTL haskell server
A haskell server which allows to remotely call cardano-library functions that are not implemented in purescript

## Observations
### Capabilities so far
 - building simple user to user transactions submittable using nami
 - basic constraints and lookups are available already, therefore a `hello-world` project could already be built

### Incapabilities so far
 - build Plutus smart contract transactions using a DSL, i.e. lookups and constraits like in the `Contract` monad
 - wallet support beyond `Nami`
 - support for browsers other than chromium based browsers

### Open questions CTLs Developers are asking themselves which could be interesting for us
- A lingering concern remains around storage solutions, if needed. This can be in memory, in various browser storage solutions, or a decentralized DB like Flure

### Possible Technical Debt
 - third party `ogmios-datum-cache` maintained by mlabs to allow for querying datum
    - could be a source of race-conditions
    - needs to be maintained by the infrastructure team
    - needs to be maintained by the infrastructure team
 - Nami extensions need to be installed manually
    - could imply that we will need a team for manual testing
 - testing the project requires nodejs e.g. `npm run unit-test`

### Architectual implications for dUSD
Since CTL brings the PAB to the browser it implies that all operations that could be computationally intense are moved to the browser, while the base information for these computations are fetched from a remote server.
What I mean by that is that we have a lot of operations that would possibly run faster on a remote server running in the browser (e.g. transaction balancing, data processing for updating datums). And the basis for these computations (e.g. a wallets utxo) is data that needs to be fetched from a remote server (cardano-node, datum-server and other services).
If we avoid computationally intense operations in the CTL endpoints by e.g. having services for all those complex computations

## Our Questions
 - building Plutus smart contract transactions with a datum (can we also use non-unit redeemers?)
 - is there a ready-to use local testing environment
 - how does plutarch integrate into this

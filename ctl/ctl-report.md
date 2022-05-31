# Cardano Transaction Library (CTL)

CTL is a PureScript SDK which allows for building smart contract transactions on cardano using browser wallets.
The goal of CTL is to move IOHKs `Contract` monad to the browser. But instead of being a standalone process, it is a library.

To achieve this CTL makes use of the `Cardano Serialisation Library`, `Ogmios`, and a [`CIP-30`](https://cips.cardano.org/cips/cip30/) Supported Wallet available at run-time:

## Sub-components of CTL
### Cardano Serialisation Library
The CTL uses the Cardano-Serialization-Library ([CSL](https://docs.cardano.org/cardano-components/cardano-serialization-lib)) which is used for reliably serializing and deserializing Cardano's Haskell data structures. That way CTL assures that transactions match the correct format. CSL also provides wallet utilities like generating key-pairs, addresses and metadata handling. CTL abstracts over CSL for a easier creation of transactions by querying the blockchain using ogmios.

### Ogmios
It is used by CTL to query the blockchain. Ogmios itself is a lightweight bridge interface for `cardano-node`, which basically allows for RPC calls of `cardano-node`.

### Ogmios Datum Cache
The CTL uses the `ogmios-datum-cache` which is a postgres database storing datums instead of just hashes.

### CTL haskell server
A haskell server which allows to remotely call cardano-library functions that are not implemented in purescript.

## Observations
### Capabilities so far
 - Building simple user to user transactions submittable using nami.
 - Basic constraints and lookups are available already, therefore a `hello-world` project could already be built.

### Incapabilities so far
 - Build Plutus smart contract transactions using a DSL, i.e. lookups and constraints like in the `Contract` monad.
 - Wallet support beyond `Nami`.
 - Support for browsers other than chromium based browsers.

### Open questions CTLs Developers are asking themselves which could be interesting for us
 - A lingering concern remains around storage solutions, if needed. This can be in memory, in various browser storage solutions, or a decentralized DB like Flure

### Possible Technical Debt
 - Third party `ogmios-datum-cache` is maintained by mlabs to allow for querying datum.
    - This could be a source of race-conditions.
    - Needs to be maintained by the infrastructure team.
 - The Nami extension needs to be installed manually.
    - This could imply that we will need a team for manual testing.
    - EDIT: using home-manager we can add chromium having nami installed already
 - We need a way to programatically interact with the nami extension
    - We need to use selenium to automate the user interaction with this extension.
 - Reliance on docker creates a Nix impurity.
    - Not necessarily an impurity, the docker images are built using nix
    - However we need a docker daemon running on the system

### Architectural implications for dUSD

Since CTL brings the PAB to the browser it implies that all operations that could be computationally intense are moved to the browser, while the base information for these computations are fetched from a remote server.

What I mean by that is that we have a lot of operations that would possibly run faster on a remote server, now running in the browser (e.g. transaction balancing, data processing for updating datums). And the basis for these computations (e.g. a wallets utxo) is data that needs to be fetched from a remote server (cardano-node, datum-server and other services). This location separation also requires more network traffic than having them on the same machine.

If we avoid computationally intense operations in the CTL endpoints by e.g. having services for all those complex computations, we actually achieve a much more modular architecture. We create services for all these complex computations instead of doing them in the contract handler. That way the contract handler is just responsible for distributing work, collecting results, balancing, signing and submitting and nothing more.

#### PAB vs CTL

##### PAB

###### Pros

- Unit test using emulator traces
- Property tests using contract models
- Lots of docs, Plutus Pioneer Program

###### Cons

- Contract monad forces us to do all the computations for the client. We can't do any IO inside the contract monad. In the case of the price-feeder: we can't call the price-fetcher in the contract handler and then publish the price. Instead our script fetches a price and calls the contract handler requesting the price change.
- Endpoints create additional complexity.
- Not maintained.

##### CTL

###### Pros

- CTL role is simpified to wallet oriented operations.
- Basic contract monad-like construction of transactions using lookups and contraints (we could implement hello-world).
- It does not deviate much from the PAB contract model
- Actively maintained.

###### Cons

- Backend service (runtime) depedencies.
- Run-time dependency on Wallet APIs.
- Testing is dependent on backend services.
- Ogmios is under-documented

## Our Questions
([See meeting notes](ctl/mlabs-meeting.md))
 - Building Plutus smart contract transactions with a datum (can we also use non-unit redeemers?)
 - Is there a ready-to-use local testing environment?
 - How does plutarch integrate into this?
 - Are there plans to move docker-compose managed service dependencies into the Nix flake?
 - What is the proper way to test ctl contracts?
 - How can we property and unit test?

# MLabs CTL Meeting

Monday, May 30th, 2022

## Current status of CTL and Roadmap

- They're releasing V1 this week (5-30-2022)
- Api should be mostly stable.
- Over the next month, change will be made to the API and back-ported to V2.
- They’re investigating getting support set for the Vasil hardfork.
- They want to deprecate some runtime dependencies and simplify the deployments.

## Deprecation Efforts
### Haskell server
Haskell server contains functionality that is not currently supported in purescript such as:
- Calculating fees
- Supporting parameterized scripts.
    They don’t have a UPLC (Untyped plutus core) API on the front-end yet so they send the scripts in a serialized form to the backend, and apply them, then send it back to the front-end.

They’ve been putting more functionality into the server because they’ve been in a bit of a time crunch. There are projects that need to have CTL working as quickly as possible. The goal is to deprecate the entire server.

Ogmios will be used to accommodate some of the server functionality. It can calculate xUnits as well as transaction fees.

### Datum Cache

They’re all thinking about getting rid of the datum cache after Vasil is rolled out. To do this, you have to make a requirement in your contract that you’re using inline datums and only inline datums.

### Cardano Node

Deprecation of needing to run you own node is expected for V2.

SPOs (Stake Pool Operators) can run services on a registry. They’re already doing it with the submit API, they want to expand it to a larger suite. So you can load balance across many nodes. 

Vasil nodes have a 4x use regression so it takes 64 gigs of memory to run the node. If this regression isn't resolved quickly, further pressure will be put on sourcing node connections from registries. 

## Wallets
They support only Nami currently. They chose Nami to implement first because they started the project back in January and Nami was the only CIP-30 wallet at the time. It’s defacto for working with smart contracts so it had a lot of idiosyncrasies with how collateral is handled and many have been up-streamed to CIP-30 itself.

They will be supporting [GeroWallet](https://gerowallet.io/) potentially this week. They’ll be adding wallets over the next month or 2, essentially any wallet that “approximates” the CIP-30. They aim to cover:
- Nami
- GeroWallet
- Youroi
- Eternal
- Flint


The Vasil fork may break Nami support. With nami you have to serialize, sign, then serialize again. Apparently Vasil nodes will complain.

## E2E Example Project

[`Seabug`](https://github.com/mlabs-haskell/seabug) is the most worked together example. There are a couple bugs in it though. In the project, CTL is brought in as a purescript dependency which is then brought in as an SDK, which is then used in the front-end project to consume as a library in typescript.

## Plutus in CTL

Hardcoded scripts are fed into the front-end as a build-time configuration.
There is a CTL contracts repo that is private, that they’ll be open-sourcing the next couple days.

## Testing

### Testing Environments

Localized testing can be enabled by modifying the protocol parameters file. You could have different protocol param files for different networks that get swapped out for different kinds of testing.

### Test Wallet

They’re working on a test wallet that can write a transaction out to a file in the NodeJS context rather than the browser context, then you can make assertions about the transaction that is generated and submit it via the node or the submit API to the testnet of your choice. This could enable a bot-wallet support.

### Plutip

They’ve been developing [Plutip](https://github.com/mlabs-haskell/purescript-bridge), which is an emulator trace on a local testnet. It’s spiritually an MVP of something like Maserat where you can emulator trace on testnet.

There are limits on parallelism in Plutip because you need to involve a real chain. You’re going to want more parallelism in unit testing and property test where you’re running it in CI. Plutip is more for integration tests.


## Issues

### Websockets

Websocket reliability is going to be an ongoing issue. They have washers on both ends of the websockets to make sure they’re not silently failing. 

Ogmios is the only horse in town that satisfies the websocket requirement. If Ogmios starts supporting an HTTP interface, those reliability issues will fall in favor of slower connections. There is a lot of back and forth between Ogmios
E2E testing in the next two weeks should be done with Selenium or Puppeteer.


## Complexity

Balancing in the browser is not a big issue. Purescript isn’t doing anything with a huge amount of overhead but the code can be complex without it being a hotspot.

A lot of balancing work is done already by the light wallets.

## Performance

The biggest concern is can we get anything to work at a production level standard.

- How do we control bundle sizes?
- How do we control overall time of a given query?
- How do we control the overall time of a transaction to land?
- Is your infrastructure distributed enough?

Everyone should be able to use CTL without performance issues and the bundles that are produced when you start using CTL as an SDK should be reasonably sized.
Right now they don’t have benchmarks for this but the goal is to get them in place and watch for regressions as they go.

A potential performance optimization could be moving the execution context of a function from the browser to a node server and send back the result.

Websockets in low connectivity zone are going to take a toll on performance.

## Plutarch

[Cardax](https://cardax.io/) is using plutarch already because of plutarch’s reliance on GHC 9. Right now contracts are being spun out of pluturch and being read by other parts of the infrastructure using GHC 8.

You’re spitting out your contract from GHC 9, you have a makefile script that’s gonna move it into your front-end config repository, and it’s being picked up like any other script. You’re going to have to do that with PlutusTx too.

## Parameterized scripts
There is a [function](https://github.com/Plutonomicon/cardano-transaction-lib/blob/4e645acb68c212bcbcad9e53b00e08c094a0e48f/src/QueryM.purs#L512) for support applying parameters to scripts


## CTL Support

In the [plutonomicon discord](https://discord.com/channels/922576618424250418/922576618969514076), there are a number of CTL experts available for help. CTL is being adopted by 3 or 4 new projects so support is very active. In the short term, Rory and Viet can also answer high level question directly.

After the Ardana team gets beyond the basics, we can have a dedicated support team member from MLabs who will actively address Ardana tickets we open.

Viet has already worked with a client who has already completed a roundtrip hello world on CTL. 

## Haskell to Purescript Bridge

There is a [helper project](https://github.com/mlabs-haskell/purescript-bridge) to get various haskell types into purescript. This was open-sourced by Cardax.

## CTL and the PAB
CTL does not directly depend on plutus.

Haskell server component relies on plutus, but not plutus-apps.

Plutip and Masarat rely on the plutus-apps repo and the sub-components the PAB uses.

## Vasil Hard-fork Breakage
There are breaking changes in the Vasil hard-fork. Block representation has changed. Everyone's tooling is going to lose compatibility if not updated. Ogmios will break, so it will also need to be updated before the Vasil hard-fork lands.



*For internal distribution only, pending final approval.*

Cardano allows only one transaction per block to use a given piece of on-chain data, such as a UTXO or the state of a smart contract instance. This means that for each smart contract instance on the blockchain, only one transaction per block can change the state of the smart contract instance. With the expectation that about three blocks wil be created per minute, that translates to about three state-changing transactions per smart contract instance per minute.

This has implications for the design of smart contracts which aim to support massive scale and high transaction throughput. There are essentially two ways for a Cardano smart contract to support high transaction throughput. The contract can be designed so that transaction types need to support high throughput can be done without modifying the contract state. Or, the other way, the contract can have multiple instances. The maximum number of state-changing transactions per block which the contract can support is equal to the number of instances. Thus, increasing the number of contract instances allows transaction throughput to be scaled without limit, in principle.

DanaSwap is a decentralized exchange (DEX) under development by Ardana. DanaSwap will allow users to trade financial assets according to rules specified by smart contracts. It will support massive scale and high transaction throughput. We are doing this using the second mentioned strategy: using a large number of contract instances.

How does this work? How do multiple instances of the same DEX contract work together to create a single DEX? Essentially, each contract instance can act as a self-contained DEX, and additional off-chain code supports features which let us view and interact with all of the contract instances as a single exchange.

When a market participant wants to make a trade on DanaSwap via the Ardana app, the app will select a contract instance to do their trade on. If the trade is too big to performed with low slippage on one instance of the contract, then it will be split up into multiple trades.

The different contract instances may offer different prices for the same trade. Therefore, the app will attempt to select a contract instance which offers the user a good price, relative to other contract instances. In general, the prices offered on different contract instances should be close together and roughly equal. If they are not close together, then arbitrage trading can bring them close together. The process by which the Ardana app selects contract instances to perform trades also will cause the rices offered on different contract instances to come closer together if they are not already close together.

In summary, DanaSwap's strategy for supporting high transaction throughput has the following ingredients:

1. A DEX contract which allows for many instances, each of which can function independently as a DEX.
2. Off-chain services which allow for users to interact with the whole collection of DEX contract instances as if they were one DEX, which they effectively are as a result of these services being provided.
3. A strategy for creating reasonably consistent behavior, such as pricing behavior, across all of the DEX contract instances.

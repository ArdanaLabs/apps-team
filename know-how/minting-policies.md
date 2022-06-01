# The Wonderful World of Minting Policies

In this guide, we delve into the concepts underlying minting policies, creating an NFT, using NFTs to control minting policy actions, and creating policy scripts which controls a token supply collateralized by locked ADA. 

## Prerequisites Concepts

Before diving into token policies, let's first summarize the concepts of the Cardano ecosystem we'll be using to implement our policies.

### Users

The user on the Cardano network is the entity that constructs and signs transactions, moving chain state forward. A user has a signing key, which is the private key that a user employs to consent to participating in a transaction, and a verification key, which is used to prove that a transaction was signed by the user and to generate addresses, which are used as the source and destination of funds in a transaction.

### Transactions

Transactions are represented in Cardano as a set of inputs and a set of outputs. The inputs consist of value and data being consumed, and the outputs consist of value and data changing hands.

### UTxOs

All value on the Cardano blockchain is locked in Unspent Transaction Outputs (UTxOs). By value, we mean ADA, the base token of Cardano, as well as any number of tokens created by minting policies. All tokens on Cardano belong to an address and are expressed in a eUTxO in the following structure:

```
  <address>
  <ADA amount>
  <token1 amount> <token1 policy hash>.<token1 name>
  <token2 amount> <token2 policy hash>.<token2 name>
  ...
  <datum hash>
```

Note that a UTxO can also contain a datum hash. This is used to represent state in Plutus scripting transactions which we'll cover later.

### Simple Minting Policies

Minting policies are the means through which tokens are created and destroyed. A simple minting policy specifies whose signature is used when minting and burning tokens managed by that policy. This is specified by providing one or more verification keys corresponding to users.

To mint tokens, the issuer submits a transaction which specifies the minting policy and the quantity of the tokens in the policy that they want to mint. The outputs of the transaction must then contain the value of the tokens created and the address they want to send the tokens. This results in a UTxO containing the newly minted tokens. 

To burn tokens, the issuer must own a UTxO that contains tokens and submit a transactions that specifies the minting policy and the quantity of tokens they wish to burn.

We'll expand our understanding of minting policies later when we discuss minting validators. 

### Plutus Scripting

Plutus scripts are the means in which the automation of financial policies occur on Cardano. The fundamental concept of Plutus scripting can be understood through examining two actions that can occur within a transaction: locking tokens at a script address, and redeeming tokens from a script address. Let's dive into both of these.

#### Sending to a Script Address
In Plutus, there is no explicit process of deploying a script. The initializing action consists of hashing the script into an address, constructing a transaction that sends tokens and the hash of a initial state, referred to as the datum, to that address, and signing and submitting it to the network. What you're essentially doing here is publishing a UTxO which is owned not by a person but by a future computation which is executed when a transaction is submitted that attempts to spend the UTxO locked at the scripting address. 

A scripting address can be thought of an escrow account which has an automated means of validating who gets to withdraw and deposit from it as well as any other arbitrary conditions set up within the script. This step is the initial deposit into the account, which now gives the account a UTxO that can be spent by anyone who has the validator script and the original datum, and can get the script to validate their transaction.

#### Calling the Redeemer
The second action, the spending of the script UTxO, involves the actual execution of the validator script. The user constructs a transaction which provides the standard input and output structure with the addition of the following:

- The script that was used to produce the script hash address which owns the UTxO being spent.
- The datum that was used to produce the datum hash on the UTxO being spent.
- A redeemer value, which is passed as an argument to the validator. This redeemer value is commonly used to specify what kind of operation the user wants to perform on the scripting UTxO during the execution of a validator. Examples of this would be depositing and withdrawing tokens, or bidding on an auction.
- Collateral to compensate the node validating the transaction should the validator script fail

Once the transaction is submitted to the network, a node runs the validator in the script against the transaction. If the validator executes successfully, the transaction is created. If not, the collateral is consumed and the transaction is rejected.

### Minting Policy Validators
We can come up with more complex minting policies by employing a minting policy validator rather than minting policies that only validate the signer. A minting policy validator differs from a transaction validator in that it does not receive a datum or redeemer, just the context of the transaction. This is because a minting policy does not spend a UTxO; the process of minting/burning does not depend on any value in the inputs of the transaction, just the quantity of minting specified in the transaction.

## NFTs

Now that we've covered some of the underlying concepts in Cardano, let's discuss NFTs and how to create them. An NFT (Non-fungible token) is a token that cannot be duplicated or destroyed. Let's go through how the requirements are implemented.  

### Minted Once

This is achieved through a minting policy validator that is designed to only run successfully once. Because a minting policy validator can receive the context of the transaction that it is being called from, it can get a hold of input UTxOs. UTxOs can be identified by a unique hash due to all UTxOs being unique. This hash can be hardcoded into the validator and matched against the input UTxOs during the validator's execution. If the UTxO is not present, the validator returns a failure. Otherwise, the NFT is minted.

### Uniqueness

Another requirement is that there can only be one NFT. This is achieved by accessing the context of the transaction where lies the token quantity being minted. By ensuring the quantity being minted is one, the NFT can be guaranteed uniqueness.

## NFT Managed Minting Policies

A common use-case for NFTs is designating a single user the authority to mint and burn a token. The user's authority is proven through their ownership of a UTxO containing the NFT. We can implement an NFT managed minting policy in a similar manner that we used for NFTs above - within a validator we can pull in the input UTxOs from the context of the transaction and only allow the validator to execute further if the NFT is found. This also makes the permission to mint and burn tokens from this policy transferrable so long as NFT can be spent.

## Collatoralized Token

Let's say we want to create a minting policy that enforces a one to one collateralization ratio with ADA. That is, for each token minted, there is an ADA token stored at a reserve address. The minting policy validator for this policy will apply the following logic:

- There is an output UTxO in the transaction context that sends a quantity of ADA to the reserve address.
- The quantity of tokens being minted in the transaction context is equal to the quantity of ADA being sent to the reserve address.   

## Conclusion

While we've covered enough to build a practical understanding of minting policies and validator scripts, what's possible with them has yet to be fully explored. With the Vasil hard-fork and the inclusion of reference inputs, inline datums, and script references, the framework becomes more accessible and performant opening up further possibilities.     



<!-- ## Stateful Minting

Let's say we want to have a minting policy that will stop minting after a certain quantity is reached and is only callable by a user who owns a certain NFT, called the issuer NFT. For us to do this, we need a way to track how many tokens have been minted in prior transactions so that we can apply the limit in the minting policy validator. To accomplish this, we'll need the following components.

### State UTxO

To provide state to a minting policy, we'll need a scripting UTxO which records the quantity of tokens that have been minted in the datum and validates  


### NFT UTxOs

The list of input UTxOs in the validator's transaction context must contain the issuer NFT, and a plutus script -->
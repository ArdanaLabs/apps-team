# DanaSwapStats

DanaSwapStats (or Stats for short) constitutes the Haskell backend responsible
for two things:
- Showing statistics about the DEXes
- Allowing users to interact with Danaswap in order to create unsigned
  transactions

What should we optimize for?
- Security & safety
- Decentralization
- Implementation time

Current status: Mostly finished. Still to be done:
- Remove invariant equation solver code, and link up Stats with the invariant
  equation solver library/API
- Remove Double, add dangerous functions list and some other small improvements
- Link up Stats with Danaswap and ZKR, and replace the mock parts of the server
- Make sure Stats recovers well after downtime, i.e. first sync up with the
  Cardano and prover nodes, only then continue to function

# Admin fees

How will we deal with the existence of admin fees in a context which includes
the invariant equation? We need to track the admin fees separately from the
"usable" contents of each pool somehow.

Solution: Track both the nominal balance ("usable" amount) and the actual
balance (which includes the admin fees).

# The number of pools can be increased by governance

How do we implement this?

Option 1. Governance can decide to add new, empty pools or destroy an existing
empty pool.

Option 2. Pools can be merged/split.
- Harder to implement: Requires the concept of a "killed" pool

# Representing money

Option 1. Double

Option 2. Rational

Option 3. Fixed point number.

Conclusion: Money will be represented by fixed point numbers, though Rational
will be used as a type representing intermittent calculations, e.g. while
solving the invariant equation, in order to increase the accuracy.

# Postgres setup

Option 1. Postgres must be set up manually both in development and in
deployment.

Option 2. Deployment automatically sets up a Postgres dB.

Option 3. Deployment and development automatically set up a Postgres dB.

# Where to put the invariant equation solver

Option 1. Library

Option 2. Channels, i.e. using worker threads

Option 3. RESTful API

Proposal: We need benchmarks of solving the invariant equation to a reasonable
accuracy.




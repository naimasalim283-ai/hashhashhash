# HASH256 Node Miner

Safe CPU miner and auto-mint script for wallets you own.

## What it does

- Reads private keys from `accounts.txt`, one key per line.
- Gets each wallet-specific `getChallenge(address)` from HASH256.
- Searches nonce values using `keccak256(challenge || uint256 nonce)`.
- Submits `mine(uint256 nonce)` only for the same wallet that produced the challenge.

## Contract

- Address: `0xAC7b5d06fa1e77D08aea40d46cB7C5923A87A0cc`
- Network: Ethereum mainnet RPC-compatible endpoint
- Functions used: `genesisState()`, `miningState()`, `getChallenge(address)`, `mine(uint256)`

## Setup

```bash
npm install
copy .env.example .env
copy accounts.txt.example accounts.txt
```

Edit `.env` and add a reliable Ethereum RPC URL.

Edit `accounts.txt` and add one private key per line. Use a dedicated wallet, not your main wallet.

## Run

```bash
npm run mine
```

Mining mode only:

```bash
node src/miner.js --mode=mine
```

Speedup mode only:

```bash
node src/miner.js --mode=speedup
```

On Windows, you can also run:

```bat
start_mining.bat
start_speedup.bat
start_gpu_browser.bat
```

## Docker / Clore.ai

Build and push your own image:

```bash
docker build -t your-dockerhub-user/hash256-node-miner:latest .
docker push your-dockerhub-user/hash256-node-miner:latest
```

On Clore.ai, choose `Custom image` and use:

```txt
your-dockerhub-user/hash256-node-miner:latest
```

Set environment variables from `clore.env.example`, especially `HASH256_PRIVATE_KEY`. Use a dedicated mining wallet only.

## Configuration

```env
HASH256_RPC_URL=wss://ethereum-rpc.publicnode.com
HASH256_SUBMIT_RPC_URL=
HASH256_BATCH_SIZE=50000
HASH256_POLL_INTERVAL_MS=1000
HASH256_SPEEDUP_INTERVAL_MS=2500
HASH256_WAIT_RECEIPT=1
HASH256_KEEP_MINING=1
HASH256_ONCE=0
HASH256_GAS_LIMIT=300000
HASH256_MAX_PRIORITY_FEE_GWEI=2
HASH256_MAX_FEE_MULTIPLIER=2
HASH256_MAX_TX_COST_USD=5
MAX_GAS_BUDGET_USD=5
PRIORITY_BOOST_PERCENTAGE=20
HASH256_ETH_USD_PRICE=
```

## Notes

This is a pure Node.js CPU miner, so it will be slower than Rust/GPU miners. It is designed to be simple, auditable, and safe for owned wallets only.

`start_gpu_browser.bat` opens the official HASH256 browser miner with WebGPU flags. This is the recommended way to use Intel/AMD/NVIDIA GPU from Windows without native CUDA/OpenCL tooling.

`--mode=speedup` only replaces pending transactions previously sent by this script and stored in `pending-transactions.json`.

`HASH256_RPC_URL` can use WSS for fast reads, while `HASH256_SUBMIT_RPC_URL` should use a private-orderflow RPC for sending mint transactions. Alternatives include `https://rpc.flashbots.net/fast` and `https://rpc.mevblocker.io/fast`.

`HASH256_MAX_PRIORITY_FEE_GWEI=2` sets the EIP-1559 priority fee to 2 Gwei. To keep gas from becoming too expensive, lower `HASH256_MAX_FEE_MULTIPLIER` or `HASH256_GAS_LIMIT`.

Do not commit `.env` or `accounts.txt`.

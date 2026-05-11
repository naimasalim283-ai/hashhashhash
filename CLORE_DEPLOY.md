# Deploy to Clore.ai

## Option A: Build image with GitHub Actions, no local Docker needed

Push this repository to GitHub, then open:

```txt
GitHub repository > Actions > Publish Docker image > Run workflow
```

The workflow publishes:

```txt
ghcr.io/YOUR_GITHUB_USERNAME/hash256-node-miner:latest
```

Use that image in Clore.ai `Custom image`.

If the image is private, set the package visibility to public:

```txt
GitHub profile > Packages > hash256-node-miner > Package settings > Change visibility > Public
```

## Option B: Build locally with Docker Desktop

## 1. Build Docker image

Replace `myuser` with your Docker Hub username.

```bat
build_docker.bat myuser/hash256-node-miner:latest
```

## 2. Login and push

```bat
docker login
push_docker.bat myuser/hash256-node-miner:latest
```

## 3. Configure Clore.ai order

Choose:

```txt
Custom image
```

Image:

```txt
myuser/hash256-node-miner:latest
```

## 4. Environment variables

Add these in Clore environment variables. Replace the private key with a dedicated mining wallet private key.

```env
HASH256_PRIVATE_KEY=replace_with_dedicated_mining_wallet_private_key
HASH256_RPC_URL=wss://ethereum-rpc.publicnode.com
HASH256_SUBMIT_RPC_URL=https://rpc.flashbots.net/fast
HASH256_BATCH_SIZE=10000000
HASH256_WORKERS=4
HASH256_BOOST_WORKERS=0
HASH256_WORKER_PROGRESS_EVERY=100000
HASH256_POLL_INTERVAL_MS=2000
HASH256_SPEEDUP_INTERVAL_MS=3000
HASH256_WAIT_RECEIPT=0
HASH256_EPOCH_WATCH_INTERVAL_MS=4000
HASH256_MAX_PENDING_SUBMISSIONS=1
HASH256_KEEP_MINING=1
HASH256_ONCE=0
HASH256_GAS_LIMIT=250000
HASH256_GAS_BUFFER_PERCENTAGE=25
HASH256_MAX_PRIORITY_FEE_GWEI=2
HASH256_MAX_FEE_MULTIPLIER=2
HASH256_MAX_TX_COST_USD=5
MAX_GAS_BUDGET_USD=5
PRIORITY_BOOST_PERCENTAGE=20
HASH256_ETH_USD_PRICE=
```

## 5. Command

Default command is already:

```txt
mine
```

If Clore asks for a command or arguments, leave it empty or set:

```txt
mine
```

## Important

This image runs the Node.js CPU miner. It does not use NVIDIA CUDA yet. The RTX GPU on Clore will not be used until a native CUDA/OpenCL/WebGPU backend is added.

Use a dedicated mining wallet only. Do not use your main wallet private key.

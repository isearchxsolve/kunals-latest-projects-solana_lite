CREATE DATABASE crypto_db;

npx drizzle-kit pushset

set BIRDEYE_API_KEY=YOUR_BIRDEYE_API_KEY

set SOLANA_RPC_URL=https://mainnet.helius-rpc.com/?api-key=YOUR_HELIUS_API_KEY

set SOLANA_RPC_BACKUP_URL=https://twilight-old-diamond.solana-mainnet.quiknode.pro/YOUR_QUIKNODE_API_KEY/

set SOLANA_RPC_TERTIARY_URL=https://api.mainnet-beta.solana.com

set JITO_ENGINE_URL=https://tokyo.mainnet.block-engine.jito.wtf/api/v1/transactions

JITO_TIP_LAMPORTS=100000

set WALLET_PRIVATE_KEY=YOUR_SOLANA_WALLET_PRIVATE_KEY

set PRIORITY_FEE_LAMPORTS=100000

set DATABASE_URL=postgres://postgres:postgres@localhost:5432/crypto_db

npm run build && start "ML Server" cmd /k "python solana_hybrid_sniper_ultra/ml_server.py" && start "Fast Scanner" cmd /k "node fast_scanner.cjs" && start "TSX Server" cmd /k "npx cross-env NODE_ENV=development tsx server/index.ts"


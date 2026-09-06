const { Keypair, Connection, LAMPORTS_PER_SOL } = require('@solana/web3.js');
const bs58 = require('bs58');

const privateKeyBase58 = 'YOUR_SOLANA_WALLET_PRIVATE_KEY';

async function main() {
  try {
    const decoded = bs58.decode(privateKeyBase58);
    const keypair = Keypair.fromSecretKey(decoded);
    const pubkey = keypair.publicKey.toBase58();
    console.log('PUBLIC KEY (wallet address):', pubkey);

    // Check balance via Helius
    const conn = new Connection('https://mainnet.helius-rpc.com/?api-key=YOUR_HELIUS_API_KEY', 'confirmed');
    const lamports = await conn.getBalance(keypair.publicKey);
    console.log(`ON-CHAIN BALANCE: ${lamports} lamports = ${(lamports / LAMPORTS_PER_SOL).toFixed(6)} SOL`);
  } catch(e) {
    console.error('ERROR:', e.message);
  }
}
main();

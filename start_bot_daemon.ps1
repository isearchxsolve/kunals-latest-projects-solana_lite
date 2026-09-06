$env:BIRDEYE_API_KEY="YOUR_BIRDEYE_API_KEY"
$env:SOLANA_RPC_URL="https://mainnet.helius-rpc.com/?api-key=YOUR_HELIUS_API_KEY"
$env:SOLANA_RPC_BACKUP_URL="https://twilight-old-diamond.solana-mainnet.quiknode.pro/YOUR_QUIKNODE_API_KEY/"
$env:SOLANA_RPC_TERTIARY_URL="https://api.mainnet-beta.solana.com"
$env:JITO_ENGINE_URL="https://tokyo.mainnet.block-engine.jito.wtf/api/v1/transactions"
$env:JITO_TIP_LAMPORTS="100000"
$env:WALLET_PRIVATE_KEY="YOUR_SOLANA_WALLET_PRIVATE_KEY"
$env:PRIORITY_FEE_LAMPORTS="100000"
$env:DATABASE_URL="postgres://postgres:postgres@localhost:5432/crypto_db"
$env:NODE_ENV="production"

Set-Location "C:/Users/Admin/Downloads/god_ai/crypto-trader-v1_1"

# Kill existing processes on port 5000
$existing = netstat -ano | Select-String ":5000 "
foreach ($line in $existing) {
    $parts = $line -split '\s+'
    $pid = $parts[-1]
    if ($pid -and $pid -ne "0") {
        try { Stop-Process -Id $pid -Force -ErrorAction SilentlyContinue } catch {}
    }
}
Start-Sleep 2

# Start in background
$pinfo = New-Object System.Diagnostics.ProcessStartInfo
$pinfo.FileName = "node.exe"
$pinfo.Arguments = "dist/index.cjs"
$pinfo.WorkingDirectory = "C:/Users/Admin/Downloads/god_ai/crypto-trader-v1_1"
$pinfo.RedirectStandardOutput = $true
$pinfo.RedirectStandardError = $true
$pinfo.UseShellExecute = $false
$pinfo.CreateNoWindow = $true
$pinfo.EnvironmentVariables["BIRDEYE_API_KEY"] = "YOUR_BIRDEYE_API_KEY"
$pinfo.EnvironmentVariables["SOLANA_RPC_URL"] = "https://mainnet.helius-rpc.com/?api-key=YOUR_HELIUS_API_KEY"
$pinfo.EnvironmentVariables["SOLANA_RPC_BACKUP_URL"] = "https://twilight-old-diamond.solana-mainnet.quiknode.pro/YOUR_QUIKNODE_API_KEY/"
$pinfo.EnvironmentVariables["SOLANA_RPC_TERTIARY_URL"] = "https://api.mainnet-beta.solana.com"
$pinfo.EnvironmentVariables["JITO_ENGINE_URL"] = "https://tokyo.mainnet.block-engine.jito.wtf/api/v1/transactions"
$pinfo.EnvironmentVariables["JITO_TIP_LAMPORTS"] = "100000"
$pinfo.EnvironmentVariables["WALLET_PRIVATE_KEY"] = "YOUR_SOLANA_WALLET_PRIVATE_KEY"
$pinfo.EnvironmentVariables["PRIORITY_FEE_LAMPORTS"] = "100000"
$pinfo.EnvironmentVariables["DATABASE_URL"] = "postgres://postgres:postgres@localhost:5432/crypto_db"
$pinfo.EnvironmentVariables["NODE_ENV"] = "production"

$p = New-Object System.Diagnostics.Process
$p.StartInfo = $pinfo
$p.Start() | Out-Null

$outFile = [System.IO.StreamWriter]::new("logs/console.log", $false)
$errFile = [System.IO.StreamWriter]::new("logs/console.err.log", $false)

# Start async readers
$reader1 = [System.Threading.Tasks.Task]::Run({
    $p.StandardOutput.BaseStream.CopyToAsync($outFile.BaseStream).Wait()
})
$reader2 = [System.Threading.Tasks.Task]::Run({
    $p.StandardError.BaseStream.CopyToAsync($errFile.BaseStream).Wait()
})

Write-Host "Bot started with PID: $($p.Id)"
$p.Id

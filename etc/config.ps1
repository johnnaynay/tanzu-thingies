$BaseDir = Resolve-Path "$PSScriptRoot/.."
$BinDir = "$BaseDir/bin"
$ConfigDir = "$BaseDir/etc"
$DataDir = "$BaseDir/share"
$LibDir = "$BaseDir/lib"
$LibExecDir = "$BaseDir/libexec"
$LocalDir = "$BaseDir/local"
$LocalBinDir = "$LocalDir/bin"
$LocalDistDir = "$LocalDir/distfiles"
$LocalToolDir = "$LocalDir/tools"

. "$LibDir/pwsh-functions.ps1"
. "$LibDir/k8s-functions.ps1"
. "$LibDir/minikube-functions.ps1"

. "$ConfigDir/platform.ps1"
. "$ConfigDir/tap.ps1"
. "$ConfigDir/minikube.ps1"

$Overrides = "$ConfigDir/overrides.ps1"
If (Test-Path "$Overrides")
{
    . "$Overrides"
}

$Credentials = "$ConfigDir/credentials.ps1"
If (!(Test-Path "$credentials"))
{
    Copy-Item "$BaseDir/share/templates/credentials.ps1.template" "$ConfigDir/credentials.ps1"
    throw "credentials.ps1 was not found! It has now been copied to $ConfigDir/credentials.ps1 for you - configure this copy and re-run the script"
}
. "$Credentials"

$Env:PATH="$LocalBinDir;$Env:PATH"

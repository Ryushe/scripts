$Source = @"
	[DllImport("BluetoothAPIs.dll", SetLastError = true, CallingConvention = CallingConvention.StdCall)]
	[return: MarshalAs(UnmanagedType.U4)]
	static extern UInt32 BluetoothRemoveDevice(IntPtr pAddress);
	public static UInt32 Unpair(UInt64 BTAddress) {
		GCHandle pinnedAddr = GCHandle.Alloc(BTAddress, GCHandleType.Pinned);
		IntPtr pAddress     = pinnedAddr.AddrOfPinnedObject();
		UInt32 result       = BluetoothRemoveDevice(pAddress);
		pinnedAddr.Free();
		return result;
	}
"@


$device = Get-PnpDevice -class Bluetooth -FriendlyName "Lic Pro Controller" -ErrorAction SilentlyContinue
$command = Get-Command "btpair" -ErrorAction SilentlyContinue
$isBetterJoyRunning = Get-Process -Name "BetterJoyForCemu" -ErrorAction SilentlyContinue

Function RemoveBtDevice(){
    $BTR       = Add-Type -MemberDefinition $Source -Name "BTRemover"  -Namespace "BStuff" -PassThru
    $Result = $BTR::Unpair("52989118758945")
    If (!$Result) {
	    "Device removed successfully." | Write-Host
    } Else {
	    ("Sorry, an error occured. Return was: {0}" -f $Result) | Write-Host
    }
}
Function BetterJoyChecker() {
    Write-Host "Checking for betterjoy..."
    if($isBetterJoyRunning) {
        Write-Host "BetterJoy is already Running"
        Start-Sleep 5
        exit
    } Else {
        Write-Host "Starting BetterJoy"
        Start-Process ".\dependencies\BetterJoy\BetterJoyForCemu.exe"
    }
}

Function PairDevice() {
    Write-Host "Starting Pairing... (hold the sync button now)"
    btpair -p -n"Lic Pro Controller"
    if($device) {
        Write-Host "Device Paired"
    } Else {
        Write-Host "Device Errored, Rerun Script"
        exit
    }
}
Function FuckNintendo {
    If ($command) { # does btpair exist
        If($device) {
            Write-Host "Removing Device"
            btpair -u -n"Lic Pro Controller"
            # @(RemoveBtDevice)
            @(PairDevice)
        } Else {
            Write-Host "No Device Named Lic Pro Controller"
            @(PairDevice)
        }
    } Else {
Write-Host @'
LMAO btpair not on system
Opening link for you bbg

Then Rerun script
'@
        Start-Sleep 5
        Start-Process "https://bluetoothinstaller.com/bluetooth-command-line-tools"
        exit 
    }

    @(BetterJoyChecker)
}
@(FuckNintendo)


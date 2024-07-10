
$device = Get-PnpDevice -class Bluetooth -FriendlyName "Lic Pro Controller" -ErrorAction SilentlyContinue
$command = Get-Command "btpair" -ErrorAction SilentlyContinue
$isBetterJoyRunning = Get-Process -Name "BetterJoyForCemu" -ErrorAction SilentlyContinue


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
    }
}
Function FuckNintendo {
    If ($command) { # does btpair exist
        If($device) {
            Write-Host "Removing Device"
            btpair -u -n"Lic Pro Controller"
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

    

#    [DllImport("BluetoothAPIs.dll", SetLastError = true, CallingConvention = CallingConvention.StdCall)]
#    [return: MarshalAs(UnmanagedType.U4)]
#    static extern UInt32 BluetoothRemoveDevice(IntPtr pAddress);
#    public static UInt32 Unpair(UInt64 BTAddress) {
#       GCHandle pinnedAddr = GCHandle.Alloc(BTAddress, GCHandleType.Pinned);
#       IntPtr pAddress     = pinnedAddr.AddrOfPinnedObject();
#       UInt32 result       = BluetoothRemoveDevice(pAddress);
#       pinnedAddr.Free();
#       return result;
#    }
# "@
# Function Get-BTDevice {
#     Get-PnpDevice -class Bluetooth |
#       ?{$_.HardwareID -match 'DEV_'} |
#          select Status, Class, FriendlyName, HardwareID,
#             # Extract device address from HardwareID
#             @{N='Address';E={[uInt64]('0x{0}' -f $_.HardwareID[0].Substring(12))}}
# }
# ################## Execution Begins Here ################
# $BTDevices = @(Get-BTDevice) # Force array if null or single item
# $BTR = Add-Type -MemberDefinition $Source -Name "BTRemover"  -Namespace "BStuff" -PassThru
# Do {
#    If ($BTDevices.Count) {
#       "`n******** Bluetooth Devices ********`n" | Write-Host
#       For ($i=0; $i -lt $BTDevices.Count; $i++) {
#          ('{0,5} - {1}' -f ($i+1), $BTDevices[$i].FriendlyName) | Write-Host
#       }
#       $selected = Read-Host "`nSelect a device to remove (0 to Exit)"
#       If ([int]$selected -in 1..$BTDevices.Count) {
#          'Removing device: {0}' -f $BTDevices[$Selected-1].FriendlyName | Write-Host
#          $Result = $BTR::Unpair($BTDevices[$Selected-1].Address)
#          If (!$Result) {"Device removed successfully." | Write-Host}
#          Else {"Sorry, an error occured." | Write-Host}
#       }
#    }
#    Else {
#       "`n********* No devices foundd ********" | Write-Host
#    }
# } While (($BTDevices = @(Get-BTDevice)) -and [int]$selected)
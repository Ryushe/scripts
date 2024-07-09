
$device = Get-PnpDevice -class Bluetooth -FriendlyName "Lic Pro Controller"
$command = Get-Command "btpair" -ErrorAction SilentlyContinue

Function FuckNintendo {
    Do {
        If ($command) { # does btpair exist
            If($device) {
                Write-Host "Removing Device"
                btpair -u -n"Lic Pro Controller"
                Write-Host "Device Removed Sucessfully"
                Write-Host "Starting Pairing... (hold the sync button now)"
                btpair -p -n"Lic Pro Controller"
                if($device) {
                    Write-Host "Device Paired"
                } Else {
                    Write-Host "Device Not Paired"
                }
            } Else {
                Write-Host "No Device Named Lic Pro Controller"
                Write-Host "Starting Pairing..."
                btpair -p -n"Lic Pro Controller"
                if($device) {
                    Write-Host "Device Paired"
                } Else {
                    Write-Host "Device Not Paired"
                }
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
    } while (True) 

}
@(FuckNintendo)
# $Source = @"
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
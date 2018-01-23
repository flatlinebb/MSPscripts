

#------------------------------------------------------------------------------
# THIS CODE AND ANY ASSOCIATED INFORMATION ARE provideD “AS IS” WITHOUT
# WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT
# LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
# FOR A PARTICULAR PURPOSE. THE ENTIRE RISK OF USE, INABILITY TO USE, OR 
# RESULTS FROM THE USE OF THIS CODE REMAINS WITH THE USER.
#
# AUTHOR(s):
#     Eyal Doron (o365info.com)
#------------------------------------------------------------------------------
# Hope that you enjoy it ! 
# And May the force of PowerShell will be with you   :-)
# 17-09-2015    
# Version WP- 001
#------------------------------------------------------------------------------



Function Disconnect-ExchangeOnline {Get-PSSession | Where-Object {$_.ConfigurationName -eq "MicrosoFT.Exchange"} | Remove-PSSession}
Function Validate-UserSelection
{
    Param(
        $AllowedAnswers,
        $ErrorMessage,
        $Selection
    )
    foreach($str in $AllowedAnswers.ToString().Split(","))
    {
        if($str -eq $Selection)
        {
            return $true
        }
    }
    Write-Host $ErrorMessage -ForegroundColor Red -BackgroundColor Black
    return $False

}

function Format-BytesInKiloBytes 
{
    param(
        $bytes
    )
    "{0:N0}" -f ($bytes/1000)
}

Function Set-AlternatingRows {
       <#
       
       #>
    [CmdletBinding()]
       Param(
             [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
        [string]$Line,
       
           [Parameter(Mandatory=$True)]
             [string]$CSSEvenClass,
       
        [Parameter(Mandatory=$True)]
           [string]$CSSOddClass
       )
       Begin {
             $ClassName = $CSSEvenClass
       }
       Process {
             If ($Line.Contains("<tr>"))
             {      $Line = $Line.Replace("<tr>","<tr class=""$ClassName"">")
                    If ($ClassName -eq $CSSEvenClass)
                    {      $ClassName = $CSSOddClass
                    }
                    Else
                    {      $ClassName = $CSSEvenClass
                    }
             }
             Return $Line
       }
}



Function Write-White($Message)
{
    Write-Host  $Message -ForegroundColor White 
}


$FormatEnumerationLimit = -1

$Date = Get-Date

#------------------------------------------------------------------------------
# PowerShell console window Style
#------------------------------------------------------------------------------

$pshost = get-host
$pswindow = $pshost.ui.rawui

	$newsize = $pswindow.buffersize
	
	if($newsize.height){
		$newsize.height = 3000
		$newsize.width = 150
		$pswindow.buffersize = $newsize
	}

	$newsize = $pswindow.windowsize
	if($newsize.height){
		$newsize.height = 50
		$newsize.width = 150
		$pswindow.windowsize = $newsize
	}

#------------------------------------------------------------------------------
# HTML Style start 
#------------------------------------------------------------------------------
$Header = @"
<style>
Body{font-family:segoe ui,arial;color:black; }
H1{ color: white; background-color:#1F4E79; font-weight:bold;width: 70%;margin-top:35px;margin-bottom:25px;font-size: 22px;padding:5px 15px 5px 10px; }
H2{ color: white; background-color:#385643; font-weight:bold;width: 70%;margin-top:35px;margin-bottom:25px;font-size: 22px;padding:5px 15px 5px 10px; }
TABLE {border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}
TH {border-width: 1px;padding: 5px;border-style: solid;border-color: #d1d3d4;background-color:#0072c6 ;color:white;}
TD {border-width: 1px;padding: 3px;border-style: solid;border-color: black;}
.odd  { background-color:#ffffff; }
.even { background-color:#dddddd; }
</style>

"@

#------------------------------------------------------------------------------
# HTML Style END
#------------------------------------------------------------------------------


$Loop = $true
While ($Loop)
{
    write-host 
    write-host +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    write-host   "Room (Resource) Mailbox Script menu"
    write-host +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    write-host
    write-host -ForegroundColor green  'Connect PowerShell session to AD Azure and Exchange Online' 
    write-host -ForegroundColor green  '--------------------------------------------------------------' 
    write-host -ForegroundColor Yellow ' 0)   Login in using your Office 365 Administrator credentials' 
    write-host
    write-host
    write-host -ForegroundColor green						' Section A: Information ' 
	write-host -ForegroundColor green  '--------------------------------------------------------------' 
	write-host 												'1)   General information about Resource Mailboxes '
	write-host
    write-host -ForegroundColor green						' Section B: Creating Resource Mailbox ' 
	write-host -ForegroundColor green  '--------------------------------------------------------------' 
	write-host 												'2)   Create NEW Room Mailbox'
	write-host 												'3)   Create NEW Equipment Mailbo'
	write-host
    write-host -ForegroundColor green						' Section C: Room Mailbox Management ' 
	write-host -ForegroundColor green  '--------------------------------------------------------------' 
	write-host 												'4)   Booking options: Enable Automatic Booking for Resource Mailbox'
	write-host 												'5)   Booking options: Enable Automatic Booking for all Resource Mailboxs (BULK Mode'
	write-host 												'6)   Booking options: Assign approving delegate for Room Mailbox calendar'
	write-host 												'7)   Assign Room MailBox Manager (Assigning Full Access + Send As permission)'
	write-host 												'8)   Assign Publishing Editor Permission to Resource Mailbox Calendar'
	write-host 												'9)   Set the Room Mailbox default calendar permission to: Publishing Editor'
    write-host
    write-host -ForegroundColor green						' Section D: Display Resource Mailbox information ' 
	write-host -ForegroundColor green  '--------------------------------------------------------------' 
	write-host 												'10)  Display list of Room + Equipment Mailboxes'
	write-host 												'11)  Display Room Mailbox Permissions and Calendar Settings'
	write-host
    write-host
    write-host -ForegroundColor green						' Section E: General settings for Resource Mailbox ' 
	write-host -ForegroundColor green  '--------------------------------------------------------------' 
	write-host 												'12)  Set the Room calendar to show‘Organiser’ and ‘Subject’ of the meeting'
	write-host 												'13)  Set the Room calendar to show‘limited details’ ( default)'
	write-host 												'14)  Set Booking Window Days Number'
	write-host 												'15)  Create a new Room list'
	write-host 												'16)  Allow conflict meetings when using the option of Automatic Booking'
    write-host
    write-host -ForegroundColor green						' Section F: Convert Mailbox ' 
	write-host -ForegroundColor green  '--------------------------------------------------------------' 
	write-host 												'17)   Convert Regular Mailbox to Room Mailbox'
	write-host 												'18)   Convert Room MailBox to Regular Mailbox '
	write-host
    write-host -ForegroundColor green						' Section G: All in one ' 
	write-host -ForegroundColor green  '--------------------------------------------------------------' 
	write-host 												'19)   Create new Room MB + Assign permissions and delegate'
	write-host
    write-host -ForegroundColor Red            "20)  Disconnect PowerShell session" 
    write-host
    write-host -ForegroundColor Red            "21)  Exit" 
    write-host

    $opt = Read-Host "Select an option [0-21]"
    write-host $opt
    switch ($opt) 


{


		
		#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		# Step -00 |  Create a Remote PowerShell session to AD Azure and Exchange Online
		#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


		0
        {

            # Specify your administrative user credentials on the line below 

            $user = “Admin@.....”

            # This will pop-up a dialogue and request your password
            

            #——– Import the Local Microsoft Online PowerShell Module Cmdlets and  Establish an Remote PowerShell Session to AD Azure  
            
            Import-Module MSOnline

            

            #———— Establish an Remote PowerShell Session to Exchange Online ———————

            $msoExchangeURL = “https://outlook.office365.com/powershell-liveid/”
			$connected = $false
			$i = 0
			while ( -not ($connected)) {
				$i++
				if($i -eq 4){
					
										
					Write-host
					Write-host -ForegroundColor White	ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
					Write-host
					Write-host -ForegroundColor Red    "Too many incorrect login attempts. Good bye."	
					Write-host
					Write-host -ForegroundColor White	ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
					Write-host
					
					
					exit
				}
				$cred = Get-Credential -Credential $user
				try 
				{
					$session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri $msoExchangeURL -Credential $cred -Authentication Basic -AllowRedirection  -ErrorAction stop
					Connect-MsolService -Credential $cred -ErrorAction stop
					Import-PSSession $session 
					$connected = $true 
				}
				catch 
				{
					Write-host
					Write-host -ForegroundColor Yellow	ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
					Write-host
					Write-host -ForegroundColor Red     "There is something wrong with the global administrator credentials"	
					Write-host
					Write-host -ForegroundColor Yellow	ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
					Write-host
				}

			}
            
			$host.ui.RawUI.WindowTitle = ("Windows Azure Active Directory |Connected to Office 365 using: " + $Cred.UserName.ToString()  ) 

            


        }




		
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# Section A: Information
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


1{

####################################################################################################
# information about Resource Mailboxes 
######################################################################################################

clear-host
	
write-host
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                            
write-host  -ForegroundColor white		Information                                                                                       
write-host  -ForegroundColor white		--------------------------------------------------------------------                                                           
write-host  -ForegroundColor white  	'Resource mailboxes are special mailboxes that are used  '                                                                    
write-host  -ForegroundColor white 		'to reserve conference Rooms and Equipment.    '                                                                
write-host  -ForegroundColor white 		'AFTer an administrator creates Resource Mailboxes '                                                         
write-host  -ForegroundColor white 		'users can easily reserve Rooms and Equipment by '                                                                                                  
write-host  -ForegroundColor white 		'including resource mailboxes in meeting requests. '                                                                              
write-host  -ForegroundColor white		'The following types of resource mailboxes are available: '                                                                        
write-host  -ForegroundColor white		'*Room Mailboxes: These mailboxes are assigned to'    
write-host  -ForegroundColor white 		'physical locations such as conference Rooms '                                                                               
write-host  -ForegroundColor white		'auditoriums, and training labs. '                                                                       
write-host  -ForegroundColor white		'Additionally you can create Room Mailboxes in the Exchange Control Panel. '
write-host  -ForegroundColor white		'The mailbox quota for conference rooms is 250 MB.   '
write-host  -ForegroundColor white 		'Conference rooms do not require a user subscription license   '                                                                              
write-host  -ForegroundColor white		'*Equipment Mailboxes: These mailboxes are assigned to resources that dont have a    '                                                                   
write-host  -ForegroundColor white		'specific locationsuch as portable computers, audio-visual equipment, or vehicles. ' 
write-host  -ForegroundColor white		'You can create equipment Mailboxes in Windows PowerShell only.  '        			
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                              
write-host
write-host

write-host
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                             
write-host  -ForegroundColor white		Tip – Assigning permission to Distribution group                                                                                          
write-host  -ForegroundColor white		--------------------------------------------------------------------                                                           
write-host  -ForegroundColor white  	'In case that you need the assign permission to Distribution group'                                                                     
write-host  -ForegroundColor white 		'You should configure the distribution group additionally as a Security Group. '                                                           
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                              
write-host
write-host

write-host
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                              
write-host  -ForegroundColor white		Tip – Testing the “New” Room Mailbox                                                                                          
write-host  -ForegroundColor white		--------------------------------------------------------------------                                                           
write-host  -ForegroundColor white  	'When using outlook client, aFTer creating a new Room Mailbox '                                                                     
write-host  -ForegroundColor white 		'the Room Mailbox will NOT appear in the recipient address list  '                                                                  
write-host  -ForegroundColor white 		'because by default"," outlook is using the “Off-line global address list” '                                                         
write-host  -ForegroundColor white 		'that is updated once in 24 hours. '                                                                                                  
write-host  -ForegroundColor white 		'To be able to see the new Room Mailbox  '                                                                            
write-host  -ForegroundColor white		'when using the “TO” option for displaying the Global address list '                                                                       
write-host  -ForegroundColor white		'use instead the option: “global address list”  '                                                                              
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                             
write-host
write-host


#Section 5: End the Command
write-host
write-host
Read-Host "Press Enter to continue..."
write-host
write-host


	
}


#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# Section B: Creating Resource Mailbox
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


2{


#####################################################################
#  Create NEW Room Mailbox
#####################################################################

# Section 1: information 

clear-host

write-host
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                         
write-host  -ForegroundColor white		Information                                                                                          
write-host  -ForegroundColor white		----------------------------------------------------------------------------                                                             
write-host  -ForegroundColor white  	'This option will: '
write-host  -ForegroundColor white  	'Create NEW Room Mailbox '
write-host  -ForegroundColor white		----------------------------------------------------------------------------  
write-host  -ForegroundColor white  	'The PowerShell command that we use is: '
write-host  -ForegroundColor Yellow  	'New-Mailbox -Name <room Nmae> -Room '
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                          
write-host
write-host


# Section 2: user input


write-host -ForegroundColor Yellow	"You will need to provide 1 parameter:"  
write-host
write-host -ForegroundColor Yellow	"1) Room Mailbox name"  
write-host -ForegroundColor Yellow	"   For example: FL01-ROOM3"
write-host
$ROOMMB = Read-Host "Type the Room Mailbox name  "
write-host



# Section 3: PowerShell Command

New-Mailbox -Name $ROOMMB -Room

# Section 4:  Indication 

write-host
write-host

if ($lastexitcode -eq 1)
{
	write-host "The command Failed :-(" -ForegroundColor red
}
else
{
write-host -------------------------------------------------------------
write-host -ForegroundColor Yellow	"The command complete successfully !" 
write-host
write-host -ForegroundColor Yellow	"A Room Mailbox named: " -nonewline; write-host "$ROOMMB".ToUpper() -ForegroundColor White -nonewline; write-host -ForegroundColor Yellow	" Was created"	 
write-host -------------------------------------------------------------
}

#———— End of Indication ———————

# Section 4: Display Information


#Section 5: End the Command
write-host
write-host
Read-Host "Press Enter to continue..."
write-host
write-host

}



3{

#####################################################################
#  Create NEW Equipment Mailbox
#####################################################################

# Section 1: information 

clear-host

write-host
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                         
write-host  -ForegroundColor white		Information                                                                                          
write-host  -ForegroundColor white		----------------------------------------------------------------------------                                                             
write-host  -ForegroundColor white  	'This option will: '
write-host  -ForegroundColor white  	'Create NEW Equipment Mailbox '
write-host  -ForegroundColor white		----------------------------------------------------------------------------  
write-host  -ForegroundColor white  	'The PowerShell command that we use is: '
write-host  -ForegroundColor Yellow  	'New-Mailbox -Name <room Nmae> -Equipment '
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                          
write-host
write-host


# Section 2: user input


write-host -ForegroundColor Yellow	"You will need to provide 1 parameter:"  
write-host
write-host -ForegroundColor Yellow	"1) Type the Equipment Mailbox name"  
write-host -ForegroundColor Yellow	"   For example: Projector "
write-host
$ROOMMB = Read-Host "Type the Equipment Mailbox name  "
write-host



# Section 3: PowerShell Command

New-Mailbox -Name $ROOMMB -Equipment

# Section 4:  Indication 

write-host
write-host

if ($lastexitcode -eq 1)
{
	write-host "The command Failed :-(" -ForegroundColor red
}
else
{
write-host -------------------------------------------------------------
write-host -ForegroundColor Yellow	"The command complete successfully !" 
write-host
write-host -ForegroundColor Yellow	"A Equipment Mailbox named: " -nonewline; write-host "$ROOMMB".ToUpper() -ForegroundColor White -nonewline; write-host -ForegroundColor Yellow	" Was created"	 
write-host -------------------------------------------------------------
}

#———— End of Indication ———————

# Section 4: Display Information



#Section 5: End the Command
write-host
write-host
Read-Host "Press Enter to continue..."
write-host
write-host

}



#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# Section C: Room Mailbox Management
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


4{

#####################################################################
#   Booking options: Enable Automatic Booking for Resource Mailbox
#####################################################################

# Section 1: information 

clear-host

write-host
write-host
write-host  -ForegroundColor Magenta	ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                        
write-host  -ForegroundColor white		Information                                                                                       
write-host  -ForegroundColor white		--------------------------------------------------------------------                                                           
write-host  -ForegroundColor white  	'By default all of the meeting request that sent to the Room Mailbox'                                                                       
write-host  -ForegroundColor white 		'will be saved as “Tentative” and the recipient that sent the meeting request'                                                                   
write-host  -ForegroundColor white 		'will NOT be informed ! '                                                          
write-host  -ForegroundColor white 		'Choosing this option will set the “Resource Booking Attendant” '                                                                                                   
write-host  -ForegroundColor white 		'to use the settings of: '                                                                               
write-host  -ForegroundColor white		'“Automatically accept or decline booking requests”.'                                                                         
write-host  -ForegroundColor white		'The meaning is: when a user sends a meeting request,'   
write-host  -ForegroundColor white 		'If the room is available, the request will be accepted automatically '                                                                              
write-host  -ForegroundColor white		'and approval message will be sent to the recipient.'                                                                        
write-host  -ForegroundColor white		'in case that the room is not available  '
write-host  -ForegroundColor white		'the meeting request will be consider as “Tentative”  '
write-host  -ForegroundColor white 		'and the information will be sent to the recipient.'                                                                              
write-host  -ForegroundColor white		----------------------------------------------------------------------------  
write-host  -ForegroundColor white  	'The PowerShell command that we use is: '
write-host  -ForegroundColor Yellow  	'Set-CalendarProcessing <Room> -AutomateProcessing AutoAccept '
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                          
write-host
write-host


# Section 2: user input


write-host -ForegroundColor Yellow	"You will need to provide 1 parameter:"  
write-host
write-host -ForegroundColor Yellow	"1) Room Mailbox name"  
write-host -ForegroundColor Yellow	"   For example: FL01-ROOM3"
write-host
$ROOMMB = Read-Host "Type the Room Mailbox name  "
write-host

# Section 3: PowerShell Command

Set-CalendarProcessing $ROOMMB -AutomateProcessing AutoAccept
# Set-CalendarProcessing <Room> -AutomateProcessing AutoAccept
# Section 4:  Indication 

write-host
write-host

if ($lastexitcode -eq 1)
{
	write-host "The command Failed :-(" -ForegroundColor red
}
else
{

write-host -------------------------------------------------------------
write-host -ForegroundColor Yellow	"The command complete successfully !" 
write-host
write-host -ForegroundColor Yellow	"Automatic Booking for Room Mailbox: " -nonewline; write-host "$ROOMMB".ToUpper() -ForegroundColor White -nonewline; write-host -ForegroundColor Yellow	" is Enabled"	 
write-host -------------------------------------------------------------
	
}

#———— End of Indication ———————

# Section 4: Display Information

write-host
write-host ---------------------------------------------------------------------------
write-host -ForegroundColor white	Display Calendar setting for  "$ROOMMB".ToUpper() Mailbox
write-host ---------------------------------------------------------------------------

Get-Mailbox $ROOMMB  | Get-CalendarProcessing | FL AutomateProcessing  | Out-String


#Section 5: End the Command
write-host
write-host
Read-Host "Press Enter to continue..."
write-host
write-host

}







5{

#####################################################################
#   Booking options: Enable Automatic Booking for all Resource Mailboxes (BULK Mode)
#####################################################################

# Section 1: information 

clear-host

write-host
write-host
write-host  -ForegroundColor Magenta	ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                        
write-host  -ForegroundColor white		Information                                                                                       
write-host  -ForegroundColor white		--------------------------------------------------------------------                                                           
write-host  -ForegroundColor white  	'By default all of the meeting request that sent to the Room Mailbox'                                                                       
write-host  -ForegroundColor white 		'Enable Automatic Booking for all Resource Mailboxs (BULK Mode)'                                                                   
write-host  -ForegroundColor white		----------------------------------------------------------------------------  
write-host  -ForegroundColor white  	'The PowerShell command that we use is: '
write-host  -ForegroundColor Yellow  	'Get-Mailbox | Where {$_.ResourceType -eq "Room"} | Set-CalendarProcessing -AutomateProcessing:AutoAccept '
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                          
write-host
write-host


# Section 2: user input




# Section 3: PowerShell Command

Get-Mailbox | Where {$_.ResourceType -eq "Room"} | Set-CalendarProcessing -AutomateProcessing:AutoAccept
# Section 4:  Indication 

write-host
write-host

if ($lastexitcode -eq 1)
{
	write-host "The command Failed :-(" -ForegroundColor red
}
else
{

write-host -------------------------------------------------------------
write-host -ForegroundColor Yellow	"The command complete successfully !" 
write-host
write-host -ForegroundColor Yellow	"Automatic Booking for ALL Room Mailbox is Enabled " 
write-host -------------------------------------------------------------
}

#———— End of Indication ———————

# Section 4: Display Information

write-host
write-host ---------------------------------------------------------------------------
write-host -ForegroundColor white	Display Calendar setting for ALL Room Mailboxes 
write-host ---------------------------------------------------------------------------

Get-Mailbox | Where {$_.ResourceType -eq "Room"} | Get-CalendarProcessing | FL Identity, AutomateProcessing  | Out-String


#Section 5: End the Command
write-host
write-host
Read-Host "Press Enter to continue..."
write-host
write-host

}





6{

#####################################################################
#  Booking options: Assign approving delegate for Room Mailbox calendar 
#####################################################################

# Section 1: information 

clear-host

write-host
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                         
write-host  -ForegroundColor white		Information                                                                                          
write-host  -ForegroundColor white		----------------------------------------------------------------------------                                                             
write-host  -ForegroundColor white  	'This option will: '
write-host  -ForegroundColor white  	'Assign approving delegate for Room Mailbox calendar  '
write-host  -ForegroundColor white		----------------------------------------------------------------------------  
write-host  -ForegroundColor white  	'The PowerShell command that we use is: '
write-host  -ForegroundColor Yellow  	'set-calendarprocessing <Room> –ResourceDelegates <Delegation user> '
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                          
write-host
write-host


# Section 2: user input


write-host -ForegroundColor Yellow	"You will need to provide 2 parameters:"  
write-host
write-host -ForegroundColor Yellow	"1) Room Mailbox name"  
write-host -ForegroundColor Yellow	"   For example: FL01-ROOM3"
write-host
$ROOMMB = Read-Host "Type the Room Mailbox name  "
write-host
write-host -ForegroundColor Yellow	"2) Delegation User name"  
write-host -ForegroundColor Yellow	"   For example: John"
write-host
$delMB  = Read-Host "Type the Room Mailbox Delegation user name  "
write-host


# Section 3: PowerShell Command

set-calendarprocessing $ROOMMB –ResourceDelegates $delMB

# Section 4:  Indication 

write-host
write-host

if ($lastexitcode -eq 1)
{
	write-host "The command Failed :-(" -ForegroundColor red
}
else
{

write-host -------------------------------------------------------------
write-host -ForegroundColor Yellow	"The command complete successfully !" 
write-host
write-host -ForegroundColor Yellow	"The User: " -nonewline; write-host "$delMB".ToUpper() -ForegroundColor White 
write-host -ForegroundColor Yellow	"Is the Delegated of the Room Mailbox: " -nonewline; write-host "$ROOMMB".ToUpper() -ForegroundColor White -nonewline; write-host -ForegroundColor Yellow	" Mailbox"	 	 
write-host -------------------------------------------------------------
}

#———— End of Indication ———————

# Section 4: Display Information

write-host
write-host ---------------------------------------------------------------------------
write-host -ForegroundColor white	Display Calendar setting for  "$ROOMMB".ToUpper() Mailbox
write-host ---------------------------------------------------------------------------

Get-Mailbox $ROOMMB  | Get-CalendarProcessing | FL Identity ,ResourceDelegates  | Out-String


#Section 5: End the Command
write-host
write-host
Read-Host "Press Enter to continue..."
write-host
write-host

}




7{

#####################################################################
# Assign Room MailBox Manager (Assigning Full Access + Send As permission) 
#####################################################################

# Section 1: information 

clear-host

write-host
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                         
write-host  -ForegroundColor white		Information                                                                                          
write-host  -ForegroundColor white		----------------------------------------------------------------------------                                                             
write-host  -ForegroundColor white  	'This option will: '
write-host  -ForegroundColor white  	'Assign FULL ACCESS + SEND AS Permissions to User    '
write-host  -ForegroundColor white  	'For a Room Mailbox    '
write-host  -ForegroundColor white  	'For example: Assign permission to Secretary    '
write-host  -ForegroundColor white  	'That will manage the  the Room Mailbox    '
write-host  -ForegroundColor white		----------------------------------------------------------------------------  
write-host  -ForegroundColor white  	'The PowerShell command that we use is: '
write-host  -ForegroundColor Yellow  	'Add-MailboxPermission <Room> -User <User> -AccessRights FullAccess '
write-host  -ForegroundColor Yellow  	'Add-RecipientPermission <Room> -Trustee <User> -AccessRights SendAs -Confirm:$False '
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                          
write-host
write-host


# Section 2: user input


write-host -ForegroundColor Yellow	"You will need to provide 2 parameters:"  
write-host
write-host -ForegroundColor Yellow	"1) Room Mailbox name"  
write-host -ForegroundColor Yellow	"   For example: FL01-ROOM3"
write-host
$ROOMMB = Read-Host "Type the Room Mailbox name  "
write-host
write-host -ForegroundColor Yellow	"2) Room Mailbox manager User name"  
write-host -ForegroundColor Yellow	"   For example: John"
write-host
$MailRecipient  = Read-Host "Type the Room Mailbox Delegation user name  "
write-host
write-host


# Section 3: PowerShell Command

Add-MailboxPermission $ROOMMB -User $MailRecipient -AccessRights FullAccess


Add-RecipientPermission $ROOMMB -Trustee $MailRecipient -AccessRights SendAs -Confirm:$False



# Section 4:  Indication 

write-host
write-host

if ($lastexitcode -eq 1)
{
	write-host "The command Failed :-(" -ForegroundColor red
}
else
{

write-host -------------------------------------------------------------
write-host -ForegroundColor Yellow	"The command complete successfully !" 
write-host
write-host -ForegroundColor Yellow	"The User: " -nonewline; write-host "$MailRecipient".ToUpper() -ForegroundColor White 
write-host -ForegroundColor Yellow	"Have FULL ACCESS + SEND AS Permissions to: " 
write-host  "$ROOMMB".ToUpper() -ForegroundColor White -nonewline; write-host -ForegroundColor Yellow	" Mailbox"	 	 
write-host -------------------------------------------------------------
	
}

#———— End of Indication ———————

# Section 4: Display Information

write-host
write-host
write-host ---------------------------------------------------------
write-host List of User/Distribution Groups                        -ForegroundColor White
write-host That have FULL ACCESS permissions for "$ROOMMB".ToUpper() Room Mailbox -ForegroundColor White
write-host ---------------------------------------------------------

Get-mailboxpermission $ROOMMB | Where { ($_.IsInherited -eq $False) -and -not ($_.User -like “NT AUTHORITY\SELF”) } |Select Identity, user, AccessRights | Out-String
write-host
write-host ---------------------------------------------------------
write-host
write-host
write-host 
write-host ---------------------------------------------------------
write-host List of User/Distribution Groups                        -ForegroundColor White
write-host That have SEND AS permissions for "$ROOMMB".ToUpper() Room Mailbox -ForegroundColor White
write-host ---------------------------------------------------------

Get-RecipientPermission  $ROOMMB | Where { ($_.IsInherited -eq $False) -and -not ($_.Trustee -like “NT AUTHORITY\SELF”) } | Select Trustee, AccessControlType, AccessRights | Out-String

write-host --------------------


#Section 5: End the Command
write-host
write-host
Read-Host "Press Enter to continue..."
write-host
write-host

}





8{

#####################################################################
#  Assign Publishing Editor Permission to Resource Mailbox Calendar
#####################################################################

# Section 1: information 

clear-host

write-host
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                         
write-host  -ForegroundColor white		Information                                                                                          
write-host  -ForegroundColor white		----------------------------------------------------------------------------                                                             
write-host  -ForegroundColor white  	'This option will: '
write-host  -ForegroundColor white  	'Assign  Publishing Editor Permission to Resource Mailbox Calendar   '
write-host  -ForegroundColor white		----------------------------------------------------------------------------  
write-host  -ForegroundColor white  	'The PowerShell command that we use is: '
write-host  -ForegroundColor Yellow  	'Add-MailboxFolderPermission –Identity <Room:\calendar> -AccessRight PublishingEditor -User <User> '
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                          
write-host
write-host


# Section 2: user input


write-host -ForegroundColor Yellow	"You will need to provide 2 parameters:"  
write-host
write-host -ForegroundColor Yellow	"1) Room Mailbox name"  
write-host -ForegroundColor Yellow	"   For example: FL01-ROOM3"
write-host
$ROOMMB = Read-Host "Type the Room Mailbox name  "
write-host
write-host -ForegroundColor Yellow	"2) User name"  
write-host -ForegroundColor Yellow	"   For example: John"
write-host
$MailRecipient  = Read-Host "Type the user name  "
write-host
write-host


# Section 3: PowerShell Command

$mbox = $ROOMMB+":\calendar"


Add-MailboxFolderPermission –Identity $mbox -AccessRight PublishingEditor -User $MailRecipient

# Add-MailboxFolderPermission –Identity <Room:\calendar> -AccessRight PublishingEditor -User <User>


# Section 4:  Indication 

write-host
write-host

if ($lastexitcode -eq 1)
{
	write-host "The command Failed :-(" -ForegroundColor red
}
else
{

write-host -------------------------------------------------------------
write-host -ForegroundColor Yellow	"The command complete successfully !" 
write-host
write-host -ForegroundColor Yellow	"The User: " -nonewline; write-host "$MailRecipient".ToUpper() -ForegroundColor White 
write-host -ForegroundColor Yellow	"Have  Publishing Editor Permission to: " 
write-host  "$ROOMMB".ToUpper() -ForegroundColor White -nonewline; write-host -ForegroundColor Yellow	" Room Mailbox"	 	 
write-host -------------------------------------------------------------
	
}





#Section 5: End the Command
write-host
write-host
Read-Host "Press Enter to continue..."
write-host
write-host




}


9{

#####################################################################
#  Set the Room Mailbox default calendar permission to: Publishing Editor 
#####################################################################

# Section 1: information 

clear-host

write-host
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                         
write-host  -ForegroundColor white		Information                                                                                          
write-host  -ForegroundColor white		----------------------------------------------------------------------------                                                             
write-host  -ForegroundColor white  	'This option will: '
write-host  -ForegroundColor white  	'Set the Room Mailbox default calendar permission to: Publishing Editor    '
write-host  -ForegroundColor white  	'(The meaning is that all of the users will have Publishing Editor permission to the user Calendar) '
write-host  -ForegroundColor white  	'This option is suitable for “Public Calendar” scenarios '
write-host  -ForegroundColor white  	'For example: We want to enable all of the users to access the Room Calendar   '
write-host  -ForegroundColor white		----------------------------------------------------------------------------  
write-host  -ForegroundColor white  	'The PowerShell command that we use is: '
write-host  -ForegroundColor Yellow  	'Add-MailboxFolderPermission –Identity <Room:\calendar> –User default –AccessRights PublishingEditor   '
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                          
write-host
write-host

# Section 2: user input

write-host -ForegroundColor Yellow	"You will need to provide 1 parameter:"  
write-host
write-host -ForegroundColor Yellow	"1) Room Mailbox name"  
write-host -ForegroundColor Yellow	"   For example: FL01-ROOM3"
write-host
$ROOMMB = Read-Host "Type the Room Mailbox name  "
write-host

# Section 3: PowerShell Command

$mbox = $ROOMMB+":\calendar"
Set-MailboxFolderPermission –Identity $mbox –User default –AccessRights PublishingEditor   

# Section 4:  Indication 

write-host
write-host

if ($lastexitcode -eq 1)
{
	write-host "The command Failed :-(" -ForegroundColor red
}
else
{

write-host -------------------------------------------------------------
write-host -ForegroundColor Yellow	"The command complete successfully !" 
write-host
write-host -ForegroundColor Yellow	"ALL Users: " -nonewline; write-host "$MailRecipient".ToUpper() -ForegroundColor White 
write-host -ForegroundColor Yellow	"Have  Publishing Editor Permission to: " 
write-host  "$ROOMMB".ToUpper() -ForegroundColor White -nonewline; write-host -ForegroundColor Yellow	" Room Mailbox"	 	 
write-host -------------------------------------------------------------

	
}

#———— End of Indication ———————

# Section 4: Display Information

#Section 5: End the Command
write-host
write-host
Read-Host "Press Enter to continue..."
write-host
write-host

}

#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# Section D: Display Resource Mailbox information
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


10{

#####################################################################
# Display list of Room + Equipment Mailboxes
#####################################################################

# Section 1: information 

clear-host

write-host
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                         
write-host  -ForegroundColor white		Information                                                                                          
write-host  -ForegroundColor white		----------------------------------------------------------------------------                                                             
write-host  -ForegroundColor white  	'This option will: '
write-host  -ForegroundColor white  	'Display list of Room + Equipment Mailboxes    '
write-host  -ForegroundColor white		----------------------------------------------------------------------------  
write-host  -ForegroundColor white  	'The PowerShell command that we use is: '
write-host  -ForegroundColor Yellow  	'Get-Mailbox -Filter "(RecipientTypeDetails -eq "RoomMailbox")" | Select Name, Alias    '
write-host  -ForegroundColor Yellow  	'Get-Mailbox -Filter "(RecipientTypeDetails -eq "EquipmentMailbox")" | Select Name, Alias   '
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                          
write-host
write-host

# Section 2: user input
# Section 3: PowerShell Command
# Section 4: Display Information

write-host

write-host ------------------------------------------------------
write-host List of Existing Room Mailboxs -ForegroundColor White
write-host -------------------------------------------------------

Get-Mailbox -Filter '(RecipientTypeDetails -eq "RoomMailbox")' | Select Name, Alias | Out-String

write-host -------------------------------------------------------
write-host
write-host


write-host

write-host ------------------------------------------------------
write-host List of existing Equipment Mailboxs -ForegroundColor White
write-host -------------------------------------------------------

Get-Mailbox -Filter '(RecipientTypeDetails -eq "EquipmentMailbox")' | Select Name, Alias | Out-String

write-host -------------------------------------------------------
write-host
write-host


#Section 5: End the Command
write-host
write-host
Read-Host "Press Enter to continue..."
write-host
write-host

}








11{

#####################################################################
# Display Room Mailbox Permissions and Calendar Settings
#####################################################################

# Section 1: information 

clear-host

write-host
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                         
write-host  -ForegroundColor white		Information                                                                                          
write-host  -ForegroundColor white		----------------------------------------------------------------------------                                                             
write-host  -ForegroundColor white  	'This option will: '
write-host  -ForegroundColor white  	'Display list of Room + Equipment Mailboxes    '
write-host  -ForegroundColor white		----------------------------------------------------------------------------  
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                          
write-host
write-host


# Section 2: user input


write-host -ForegroundColor Yellow	"You will need to provide 1 parameter:"  
write-host
write-host -ForegroundColor Yellow	"1) Room Mailbox name"  
write-host -ForegroundColor Yellow	"   For example: FL01-ROOM3"
write-host
$ROOMMB = Read-Host "Type the Room Mailbox name  "
write-host


# Section 3: PowerShell Command



# Section 4: Display Information

write-host ------------------------------------------------------
write-host -ForegroundColor White   Calendar Settings for: "$ROOMMB".ToUpper() Room Mailbox 
write-host -------------------------------------------------------



Get-Mailbox $ROOMMB  | Select ResourceType, RejectMessagesFrom,RejectMessagesFromDLMembers,`
RejectMessagesFromSendersOrMembers,SendModerationNotifications  | Out-String

write-host -------------------------------------------------------
write-host
write-host

write-host
write-host ------------------------------------------------------
write-host -ForegroundColor White Calendar Processing Settings for: "$ROOMMB".ToUpper() Room Mailbox 
write-host -------------------------------------------------------

Get-Mailbox $ROOMMB  | Get-CalendarProcessing | FL | Out-String

write-host -------------------------------------------------------
write-host
write-host
write-host

write-host ------------------------------------------------------
write-host -ForegroundColor White  Moderated By Settings for: "$ROOMMB".ToUpper() Room Mailbox   
write-host -------------------------------------------------------


Get-Mailbox $ROOMMB  | FT  -Property ModerationEnabled ,ModeratedBy ,GrantSendOnBehalFTo -autosize | Out-String


write-host -------------------------------------------------------
write-host
write-host


$mbox = $ROOMMB +":\calendar"


write-host ------------------------------------------------------
write-host -ForegroundColor White Calendar Permission for: "$ROOMMB".ToUpper() Room Mailbox 
write-host -------------------------------------------------------

Get-MailboxFolderPermission -identity $mbox | Select FolderName, user, AccessRights | Out-String

write-host -------------------------------------------------------
write-host
write-host
write-host


#Section 5: End the Command
write-host
write-host
Read-Host "Press Enter to continue..."
write-host
write-host

}


#------------------------------#


#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# Section E: General settings for Resource Mailbox
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<



12{


#####################################################################
# Set the Room calendar to show‘Organiser’ and ‘Subject’ of the meeting
#####################################################################

# Section 1: information 

clear-host

write-host
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                         
write-host  -ForegroundColor white		Information                                                                                          
write-host  -ForegroundColor white		----------------------------------------------------------------------------                                                             
write-host  -ForegroundColor white  	'This option will: '
write-host  -ForegroundColor white  	'Set the Room calendar to show‘Organiser’ and ‘Subject’ of the meeting '
write-host  -ForegroundColor white		----------------------------------------------------------------------------  
write-host  -ForegroundColor white  	'The PowerShell command that we use is: '
write-host  -ForegroundColor Yellow  	'Set-CalendarProcessing -Identity <Room> -AddOrganizerToSubject $true -DeleteComments $False -DeleteSubject $False '
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                          
write-host
write-host


# Section 2: user input


write-host -ForegroundColor Yellow	"You will need to provide 1 parameter:"  
write-host
write-host -ForegroundColor Yellow	"1) Room Mailbox name"  
write-host -ForegroundColor Yellow	"   For example: FL01-ROOM3"
write-host
$ROOMMB = Read-Host "Type the Room Mailbox name  "
write-host



# Section 3: PowerShell Command


Set-CalendarProcessing -Identity $ROOMMB -AddOrganizerToSubject $true -DeleteComments $False -DeleteSubject $False


# Section 4:  Indication 

write-host
write-host

if ($lastexitcode -eq 1)
{
	write-host "The command Failed :-(" -ForegroundColor red
}
else
{
write-host -------------------------------------------------------------
write-host -ForegroundColor Yellow	"The command complete successfully !" 
write-host
write-host -ForegroundColor Yellow	"The Room Mailbox Named: " -nonewline; write-host "$ROOMMB".ToUpper() -ForegroundColor White -nonewline; write-host -ForegroundColor Yellow	" will show"	 
write-host -ForegroundColor Yellow  "The ‘Organiser’ and ‘Subject’ of the meeting " 
write-host -------------------------------------------------------------
}

#———— End of Indication ———————

# Section 4: Display Information

write-host
write-host ---------------------------------------------------------------------------
write-host -ForegroundColor white	Display ‘Organiser’ and ‘Subject’ of the meeting setting for  "$ROOMMB".ToUpper() Mailbox
write-host ---------------------------------------------------------------------------

Get-Mailbox $ROOMMB  | Get-CalendarProcessing | FL Identity ,AddOrganizerToSubject  | Out-String



#Section 5: End the Command
write-host
write-host
Read-Host "Press Enter to continue..."
write-host
write-host

}



13{


#####################################################################
# Set the Room calendar to show ‘Limited details ( default)
#####################################################################

# Section 1: information 

clear-host

write-host
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                         
write-host  -ForegroundColor white		Information                                                                                          
write-host  -ForegroundColor white		----------------------------------------------------------------------------                                                             
write-host  -ForegroundColor white  	'This option will: '
write-host  -ForegroundColor white  	'Set the Room calendar to show‘limited details’ ( default) '
write-host  -ForegroundColor white		----------------------------------------------------------------------------  
write-host  -ForegroundColor white  	'The PowerShell command that we use is: '
write-host  -ForegroundColor Yellow  	'Set-MailboxFolderPermission -AccessRights LimitedDetails -Identity <room>:\calendar -User default '
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                          
write-host
write-host


# Section 2: user input


write-host -ForegroundColor Yellow	"You will need to provide 1 parameter:"  
write-host
write-host -ForegroundColor Yellow	"1) Room Mailbox name"  
write-host -ForegroundColor Yellow	"   For example: FL01-ROOM3"
write-host
$ROOMMB = Read-Host "Type the Room Mailbox name  "
write-host



# Section 3: PowerShell Command


$mbox = $ROOMMB+":\calendar"


Set-MailboxFolderPermission -AccessRights LimitedDetails -Identity $mbox -User default

# Section 4:  Indication 

write-host
write-host

if ($lastexitcode -eq 1)
{
	write-host "The command Failed :-(" -ForegroundColor red
}
else
{
write-host -------------------------------------------------------------
write-host -ForegroundColor Yellow	"The command complete successfully !" 
write-host
write-host -ForegroundColor Yellow	"The Room Mailbox Named: " -nonewline; write-host "$ROOMMB".ToUpper() -ForegroundColor White -nonewline; write-host -ForegroundColor Yellow	" will show"	 
write-host -ForegroundColor Yellow  "‘limited details’ " 
write-host -------------------------------------------------------------
}

#———— End of Indication ———————

# Section 4: Display Information



#Section 5: End the Command
write-host
write-host
Read-Host "Press Enter to continue..."
write-host
write-host

}


14{


#####################################################################
# Set Booking Window Days Number
#####################################################################

# Section 1: information 

clear-host

write-host
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                         
write-host  -ForegroundColor white		Information                                                                                          
write-host  -ForegroundColor white		----------------------------------------------------------------------------                                                             
write-host  -ForegroundColor white  	'This option will: '
write-host  -ForegroundColor white  	'Set Booking Window Days Number '
write-host  -ForegroundColor white		----------------------------------------------------------------------------  
write-host  -ForegroundColor white  	'The PowerShell command that we use is: '
write-host  -ForegroundColor Yellow  	'Get-Mailbox <Room> | Set-CalendarProcessing -BookingWindowInDays <days> '
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                          
write-host
write-host


# Section 2: user input


write-host -ForegroundColor Yellow	"You will need to provide 2 parameters:"  
write-host
write-host -ForegroundColor Yellow	"1) Room Mailbox name"  
write-host -ForegroundColor Yellow	"   For example: FL01-ROOM3"
write-host
$ROOMMB = Read-Host "Type the Room Mailbox name  "
write-host
write-host -ForegroundColor Yellow	"2) Number of days"  
write-host -ForegroundColor Yellow	"   For example: 180"
write-host
$days =  Read-Host "Type the number of days"
write-host
write-host


# Section 3: PowerShell Command


Get-Mailbox $ROOMMB | Set-CalendarProcessing -BookingWindowInDays $days


# Section 4:  Indication 

write-host
write-host

if ($lastexitcode -eq 1)
{
	write-host "The command Failed :-(" -ForegroundColor red
}
else
{
write-host -------------------------------------------------------------
write-host -ForegroundColor Yellow	"The command complete successfully !" 
write-host
write-host -ForegroundColor Yellow	"The Room Mailbox Named: " -nonewline; write-host "$ROOMMB".ToUpper() -ForegroundColor White	 
write-host -ForegroundColor Yellow  "‘Number of days Value is " -nonewline; write-host "$days".ToUpper() -ForegroundColor White
write-host -------------------------------------------------------------
}

#———— End of Indication ———————

# Section 4: Display Information



write-host
write-host ---------------------------------------------------------------------------
write-host -ForegroundColor white	Display of Booking Window In Days Settings for "$ROOMMB".ToUpper() Room Mailbox
write-host ---------------------------------------------------------------------------

Get-Mailbox $ROOMMB  | Get-CalendarProcessing | FL Identity,BookingWindowInDays | Out-String


#Section 5: End the Command
write-host
write-host
Read-Host "Press Enter to continue..."
write-host
write-host

}




15{


#####################################################################
#Create a new Room list
#####################################################################

# Section 1: information 

clear-host

write-host
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                         
write-host  -ForegroundColor white		Information                                                                                          
write-host  -ForegroundColor white		----------------------------------------------------------------------------                                                             
write-host  -ForegroundColor white  	'This option will: '
write-host  -ForegroundColor white  	'Create a new Room list '
write-host  -ForegroundColor white		----------------------------------------------------------------------------  
write-host  -ForegroundColor white  	'The PowerShell command that we use is: '
write-host  -ForegroundColor Yellow  	'Set-MailboxFolderPermission -AccessRights LimitedDetails -Identity <room>:\calendar -User default '
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                          
write-host
write-host


# Section 2: user input


write-host -ForegroundColor Yellow	"You will need to provide 1 parameter:"  
write-host
write-host -ForegroundColor Yellow	"1) Room Mailbox list name"  
write-host -ForegroundColor Yellow	"   For example: FLoor 1 Meeting Rooms"
write-host
$DLNAME = Read-Host "Type the Room Mailbox list name  "
write-host



# Section 3: PowerShell Command


New-DistributionGroup -Name $DLNAME -RoomList


# Section 4:  Indication 

write-host
write-host

if ($lastexitcode -eq 1)
{
	write-host "The command Failed :-(" -ForegroundColor red
}
else
{
write-host -------------------------------------------------------------
write-host -ForegroundColor Yellow	"The command complete successfully !" 
write-host
write-host -ForegroundColor Yellow	"The Room Mailbox Named: " -nonewline; write-host "$DLNAME".ToUpper() -ForegroundColor White -nonewline; write-host -ForegroundColor Yellow	"Was created"	 
write-host -------------------------------------------------------------
}

#———— End of Indication ———————

# Section 4: Display Information

#Section 5: End the Command
write-host
write-host
Read-Host "Press Enter to continue..."
write-host
write-host

}







16{


#####################################################################
#  Allow conflict meetings when using the option of Automatic Booking
#####################################################################

# Section 1: information 

clear-host

write-host
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                         
write-host  -ForegroundColor white		Information                                                                                          
write-host  -ForegroundColor white		----------------------------------------------------------------------------                                                             
write-host  -ForegroundColor white  	'This option will: '
write-host  -ForegroundColor white  	'Allow conflict meetings when using the option of Automatic Booking '
write-host  -ForegroundColor white		----------------------------------------------------------------------------  
write-host  -ForegroundColor white  	'The PowerShell command that we use is: '
write-host  -ForegroundColor Yellow  	'Set-CalendarProcessing <Room Name> -AllowConflicts $True '
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                          
write-host
write-host


# Section 2: user input


write-host -ForegroundColor Yellow	"You will need to provide 1 parameter:"  
write-host
write-host -ForegroundColor Yellow	"1) Room Mailbox name"  
write-host -ForegroundColor Yellow	"   For example: FL01-ROOM3"
write-host
$ROOMMB = Read-Host "Type the Room Mailbox name  "
write-host



# Section 3: PowerShell Command

Set-CalendarProcessing $ROOMMB -AllowConflicts $True

# Section 4:  Indication 

write-host
write-host

if ($lastexitcode -eq 1)
{
	write-host "The command Failed :-(" -ForegroundColor red
}
else
{
write-host -------------------------------------------------------------
write-host -ForegroundColor Yellow	"The command complete successfully !" 
write-host
write-host -------------------------------------------------------------
}

#———— End of Indication ———————

# Section 4: Display Information

write-host -------------------------------------------------------------
write-host -ForegroundColor Yellow	"Display information about $ROOMMB CalendarProcessing " 
write-host -------------------------------------------------------------
write-host
Get-CalendarProcessing $ROOMMB |FL


write-host -------------------------------------------------------------
#Section 5: End the Command
write-host
write-host
Read-Host "Press Enter to continue..."
write-host
write-host

}





#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# Section F: Convert Mailbox
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<



17{


####################################################################################################
# Convert Regular Mailbox to Room Mailbox
######################################################################################################

# Section 1: information 

clear-host

write-host
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                         
write-host  -ForegroundColor white		Information                                                                                          
write-host  -ForegroundColor white		----------------------------------------------------------------------------                                                             
write-host  -ForegroundColor white  	'The following option will: '
write-host  -ForegroundColor white  	'Convert Regular Mailbox to Room Mailbox'
write-host  -ForegroundColor white		----------------------------------------------------------------------------  
write-host  -ForegroundColor white  	'The PowerShell command that we use is: '
write-host  -ForegroundColor Yellow  	'Set-Mailbox -Identity <room> -Type Room '
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                          
write-host
write-host

# Section 2: user input


write-host -ForegroundColor Yellow	"You will need to provide 1 parameter"  
write-host
write-host -ForegroundColor Yellow	"1) The Regular Mailbox name"  
write-host -ForegroundColor Yellow	"   For example: user01"
write-host
$ROOMMB = Read-Host "Type the name of the Mailbox  "
write-host

# Section 3: PowerShell Command


Set-Mailbox -Identity $ROOMMB -Type Room

# Section 4:  Indication 

write-host
write-host

if ($lastexitcode -eq 1)
{
	write-host "The command Failed :-(" -ForegroundColor red
}
else
{

write-host -------------------------------------------------------------
write-host -ForegroundColor Yellow	"The command complete successfully !" 
write-host
write-host -ForegroundColor Yellow	"The Regular Mailbox named: " -nonewline; write-host "$ROOMMB".ToUpper() -ForegroundColor White 
write-host -ForegroundColor Yellow	" Was converted to: Room Mailbox " 
write-host
write-host
write-host -------------------------------------------------------------

	
}

#———— End of Indication ———————

# Section 4: Display Information

write-host
write-host
write-host ------------------------------------------------------------------
write-host -ForegroundColor white information about $ROOMMB.ToUpper()  Mailbox  
write-host ------------------------------------------------------------------

get-mailbox $ROOMMB | FL DisplayName , RecipientTypeDetails |Out-String


#Section 5: End the Command
write-host
write-host
Read-Host "Press Enter to continue..."
write-host
write-host

}


18{


####################################################################################################
# Convert Room Mailbox to Regular Mailbox
######################################################################################################

# Section 1: information 

clear-host

write-host
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                         
write-host  -ForegroundColor white		Information                                                                                          
write-host  -ForegroundColor white		----------------------------------------------------------------------------                                                             
write-host  -ForegroundColor white  	'The following option will: '
write-host  -ForegroundColor white  	'Convert Room Mailbox to: Regular Mailbox'
write-host  -ForegroundColor white		----------------------------------------------------------------------------  
write-host  -ForegroundColor white  	'The PowerShell command that we use is: '
write-host  -ForegroundColor Yellow  	'Set-Mailbox -Identity <room> -Type Room '
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                          
write-host
write-host


# Section 2: user input


write-host -ForegroundColor Yellow	"You will need to provide 1 parameter"  
write-host
write-host -ForegroundColor Yellow	"1) The Room Mailbox name"  
write-host -ForegroundColor Yellow	"   For example: Room-05"
write-host
$ROOMMB = Read-Host "Type the name of the Room Mailbox  "
write-host

# Section 3: PowerShell Command


Get-mailbox -identity $ROOMMB | Set-Mailbox -type regular

# Set-Mailbox -Identity <room> -Type Room

# Section 4:  Indication 

write-host
write-host

if ($lastexitcode -eq 1)
{
	write-host "The command Failed :-(" -ForegroundColor red
}
else
{

write-host -------------------------------------------------------------
write-host -ForegroundColor Yellow	"The command complete successfully !" 
write-host
write-host -ForegroundColor Yellow	"The Room Mailbox named: " -nonewline; write-host "$ROOMMB".ToUpper() -ForegroundColor White 
write-host -ForegroundColor Yellow	" Was converted to: Regular Mailbox " 
write-host
write-host
write-host -------------------------------------------------------------

	
}

#———— End of Indication ———————

# Section 4: Display Information

write-host
write-host
write-host ------------------------------------------------------------------
write-host -ForegroundColor white information about $ROOMMB.ToUpper()  Mailbox  
write-host ------------------------------------------------------------------

get-mailbox $ROOMMB | FL DisplayName , RecipientTypeDetails |Out-String


#Section 5: End the Command
write-host
write-host
Read-Host "Press Enter to continue..."
write-host
write-host

}


#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# Section G: All in one
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

19{


#####################################################################
#  Create NEW Room Mailbox
#####################################################################

# Section 1: information 

clear-host

write-host
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                         
write-host  -ForegroundColor white		Information                                                                                          
write-host  -ForegroundColor white		----------------------------------------------------------------------------                                                             
write-host  -ForegroundColor white  	'This option will: '
write-host  -ForegroundColor white  	'1. Create NEW Room Mailbox '
write-host  -ForegroundColor white  	'2. Assign approving delegate for Room Mailbox calendar '
write-host  -ForegroundColor white  	'3. Assign FULL ACCESS + SEND AS Permissions to User    '
write-host  -ForegroundColor white  	'4. Set the Room calendar to show‘Organiser’ and ‘Subject’ of the meeting '
write-host  -ForegroundColor white		----------------------------------------------------------------------------  
write-host  -ForegroundColor white  	'The PowerShell command that we use is: '
write-host  -ForegroundColor Yellow  	'New-Mailbox -Name <Room name> -Room '
write-host  -ForegroundColor Yellow  	'Set-calendarprocessing <Room name> –ResourceDelegates <Delegation user> '
write-host  -ForegroundColor Yellow  	'Set-CalendarProcessing -Identity <Room> -AddOrganizerToSubject $true -DeleteComments $False -DeleteSubject $False '
write-host  -ForegroundColor Yellow  	'Add-MailboxPermission <Room> -User <User> -AccessRights FullAccess'
write-host  -ForegroundColor Yellow  	'Add-RecipientPermission <Room> -Trustee <User> -AccessRights SendAs -Confirm:$False'
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                          
write-host
write-host


# Section 2: user input


write-host -ForegroundColor Yellow	"You will need to provide 2 parameter:"  
write-host
write-host -ForegroundColor Yellow	"1) Room Mailbox name"  
write-host -ForegroundColor Yellow	"   For example: FL01-ROOM3"
write-host
$ROOMMB = Read-Host "Type the Room Mailbox name  "
write-host
write-host -ForegroundColor Yellow	"2) Delegation User name"  
write-host -ForegroundColor Yellow	"   For example: John"
write-host
$delMB  = Read-Host "Type the Room Mailbox Delegation user name  "
write-host


# Section 3: PowerShell Command
# Create NEW Room Mailbox
New-Mailbox -Name $ROOMMB -Room

# Assign approving delegate for Room Mailbox calendar

set-calendarprocessing $ROOMMB –ResourceDelegates $delMB

# Assign FULL ACCESS + SEND AS Permissions to User 

Add-MailboxPermission $ROOMMB -User $delMB -AccessRights FullAccess
Add-RecipientPermission $ROOMMB -Trustee $delMB -AccessRights SendAs -Confirm:$False


# Set the Room calendar to show‘Organiser’ and ‘Subject’ of the meeting

Set-CalendarProcessing -Identity $ROOMMB -AddOrganizerToSubject $true -DeleteComments $False -DeleteSubject $False


# Section 4:  Indication 

write-host
write-host

if ($lastexitcode -eq 1)
{
	write-host "The command Failed :-(" -ForegroundColor red
}
else
{
write-host -------------------------------------------------------------
write-host -ForegroundColor Yellow	"The command complete successfully !" 
write-host
write-host -ForegroundColor Yellow	"A Room Mailbox named: " -nonewline; write-host "$ROOMMB".ToUpper() -ForegroundColor White -nonewline; write-host -ForegroundColor Yellow	" Was created"	 
write-host -------------------------------------------------------------
}

#———— End of Indication ———————

# Section 4: Display Information


#Section 5: End the Command
write-host
write-host
Read-Host "Press Enter to continue..."
write-host
write-host

}




 
#+++++++++++++++++++
#  Finish  
##++++++++++++++++++
 
 
20{

##########################################
# Disconnect PowerShell session  
##########################################


Get-PSsession | Remove-PSsession



#———— Indication ———————
write-host 
if ($lastexitcode -eq 1)
{
	
	
	write-host "The command Failed :-(" -ForegroundColor red
	
	
}
else

{
	write-host "The command complete successfully !" -ForegroundColor Yellow
	write-host "The remote PowerShell session to Exchange Online was disconnected" -ForegroundColor Yellow
	
}

#———— End of Indication ———————



}

21{

##########################################
# Exit 
##########################################


$Loop = $true
Exit
}

}


}



		
		
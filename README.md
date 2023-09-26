# Custom Windows 11

## _Manuale in Italiano_

### Preparazione postazione
Macchina virtuale:  
RAM: 4GB  
HDD1: 60Gb (minimo)  
HDD2: 30Gb

1. Installazione pulita di Windows 11 (Account Microsoft offline)
2. Attivazione di Windows
3. Aggiornamento del sistema
4. Formattare HDD2
5. Entrare in modalità Amministratore tramite CMD:

```
%windir%\system32\sysprep\sysprep.exe
```
(Passare alla modalità di controllo del sistema - Riavvia)

**⚠ ATTENZIONE! ⚠**  
AL RIAVVIO LA FINESTRA DI SYSPREP DEVE RIMANERE APERTA!

6. Eliminare tutti gli utenti, no Amministratore (Pannello di controllo -> Account utente -> Rimuovi account utente)
7. Rimuovere cartelle in C:\Utenti, no Amministratore
8. Pulizia del sistema con i seguenti comandi sempre da CMD:

```
sc delete DiagTrack
sc delete dmwappushservice
echo ““ > C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-DiagTrack-Listener.etl
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
```

9. Ora impostiamo Sysprep su "Passare alla Configurazione guidata", mettiamo la [x]spunta su Generalizza e su Opzioni di arresto del sistema mettiamo "Arresta il sistema" e OK.
10. Riavviamo il sistema e facciamo le installazioni dei software tramite Chocolatey usando il terminale PowerShell come Amministratore
```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

```

## Comandi Chocolatey
| Comando | Descrizione |
| ------ | ------ |
| choco upgrade chocolatey | Aggiornare Chocolatey |
| choco search [software] | Ricerca del software |
| choco install [software] | Installazione del software |
| choco upgrade [software] | Aggiornamento del software |

⭕ Altri sistemi di rimozione pacchetti: manuale: CustomWindows11/list/ oppure 🔗 [ChrisTitusTech](https://github.com/ChrisTitusTech/winutil)

11. Scarichiamo la patch e le trasferiamo in C:\
12. Il file oscdimg.exe invece lo spostiamo in D:\ (nella seconda unità) e spegnere
13. Impostiamo sulla macchina virtuale il boot con la iso di Windows e avviamo la macchina
14. Alla prima schermata di configurazione premiamo i tasti SHIFT+F10 e si aprirà il prompt dei comandi e scriviamo:

**⚠ ATTENZIONE! ⚠**  
LE UNITA' POSSONO ESSERE DIFFERENTI, CONTROLLATE CON IL PRIMO COMANDO!

```
diskpart
list disk
select disk 0 #Partizione di Windows
list partition
select partition 3 #PRIMARIA
assign letter=A
list disk
select disk 1 #Partizione HDD vuota
list partition
select partition 2 #PRIMARIA
assign letter=B
exit
Dism /Capture-Image /ImageFile:"B:\install.wim" /CaptureDir:A:\ /Name:CustomWindows /compress:maximum /checkintegrity /verify /bootable
```
- il file install può avere anche estensione .esd
15. Chiudiamo l'installazione di Windows e riavviare
16. Se abbiamo fatto tutto bene nel disco secondario ci troveremo il file install.esd
17. Nella stessa unità creiamo una cartella es. files e ci copiamo tutti i files del CD-ROM di Windows
18. Copiamo il file install.wim (o .esd) dentro alla cartella \files\sources\ e sovrascriviamo (alcune versioni hanno il file install.win, controllare all'interno di sources)
19. Ultimo passaggio eseguiamo il seguente comando per generare la nostra bella ISO:

```
oscdimg.exe -m -o -u2 -udfver102 -bootdata:2#p0,e,bD:\files\boot\etfsboot.com#pEF,e,bD:\files\efi\microsoft\boot\efisys.bin D:\files D:\CustomWindows.iso
```

**⚠ ATTENZIONE! ⚠**  
Unità D:\ sopraccitata è l'unità HDD secondaria!


## ISTRUZIONI PATCH POST INSTALLAZIONE WINDOWS 11

**⚠ ATTENZIONE! ⚠**  
Il file devono essere eseguiti tutti come Amministratore

**ABILITIAMO L'ACCOUNT AMMINISTRATORE:**  
Avviamolo il file patch.bat e selezionare l'opzione 1


**ENTRARE NELL'ACCOUNT AMMINISTRATORE:**  
Avviare di nuovo il file patch.bat e selezionare l'opzione 2


**RITORNIAMO NEL NOSTRO ACCOUNT UTENTE:**  
Per l'ultima volta avviamo il file patch.bat e selezioniamo l'opzione 3


<br>
<br>
<br>

---

<br>
<br>
<br>

## _Manual in English_

### Work station preparation
Virtual machine:  
RAM: 4GB  
HDD 1: 60Gb (minimum)  
HDD 2: 30Gb

1. Clean install of Windows 11 (Account Microsoft offline)
2. Windows activation
3. System update
4. Formattare HDD2
5. Enter Administrator mode via CMD:

```
%windir%\system32\sysprep\sysprep.exe
```
(Enter System Audit Mode - Reboot)

**⚠ ATTENTION! ⚠**  
THE SYSPREP WINDOW MUST REMAIN OPEN ON REBOOT!

6. Delete all users, no Administrator (Control Panel -> User Accounts -> Remove User Account)
7. Remove folders in C:\Users, no Administrator
8. System cleaning with the following commands always from CMD:

```
sc delete DiagTrack
sc delete dmwappushservice
echo ““ > C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-DiagTrack-Listener.etl
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
```

9. Now let's set Sysprep to "Enter System Out-of-Box Experience (OOBE)", put the [x]tick on Generalize and on Shutdown Options put "Shut down" and OK.
10. We restart the system and install the software via Chocolatey using the PowerShell terminal as Administrator
```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

```

## Chocolatey commands
| Comand | Description |
| ------ | ------ |
| choco upgrade chocolatey | Update Chocolatey |
| choco search [software] | Software search |
| choco install [software] | Software installation |
| choco upgrade [software] | Software update |

⭕ Other ways to remove packages: manual: CustomWindows/list/ or 🔗 [ChrisTitusTech](https://github.com/ChrisTitusTech/winutil)

11. We download the patches and transfer them to C:\
12. The oscdimg.exe file instead we move it to D:\ (in the second drive) and turn off
13. We set the boot with the Windows ISO on the virtual machine and start the machine
14. At the first configuration screen, press the SHIFT + F10 keys and the command prompt will open and write:

**⚠ ATTENTION!⚠**  
THE UNITS MAY BE DIFFERENT, CONTROLLED WITH THE FIRST COMMAND!

```
diskpart
list disk
select disk 0 # Windows Partition
list partition
select partition 3 #PRIMARY
assign letter=A
list disk
select disk 1 #Empty Disk
list partition
select partition 2 #PRIMARY
assign letter=B
exit
Dism /Capture-Image /ImageFile:"B:\install.wim" /CaptureDir:A:\ /Name:CustomWindows /compress:maximum /checkintegrity /verify /bootable
```
- the install file can also have the extension .esd  
15. We close the Windows installation and reboot  
16. If we have done everything right in the secondary we will find the file install.esd  
17. In the same drive we create a folder eg. files and we copy all the files from the Windows CD-ROM  
18. Copy the install.esd file inside the \files\sources\ folder and overwrite it (some versions have the install.wim (or .esd) file, check inside sources)  
19. Last step we run the following command to generate our beautiful ISO:

```
oscdimg.exe -m -o -u2 -udfver102 -bootdata:2#p0,e,bD:\files\boot\etfsboot.com#pEF,e,bD:\files\efi\microsoft\boot\efisys.bin D:\files D:\CustomWindows.iso
```

**⚠ ATTENTION! ⚠**  
Drive D:\ above is the secondary HDD drive!


## WINDOWS 11 POST INSTALLATION PATCH INSTRUCTION

**⚠ ATTENTION! ⚠**  
The files must all be run as Administrator

**WE ENABLE THE ADMINISTRATOR ACCOUNT:**  
Run the patch.bat file and select option 1


**LOG IN TO THE ADMINISTRATOR ACCOUNT:**  
Run the patch.bat file again and select option 2


**WE RETURN TO OUR USER ACCOUNT:**  
For the last time we run the patch.bat file and select option 3



---

# rob kurze Beschreibung wie das alles funktioniert

1. download aktuelle version von vrep (edu) http://www.coppeliarobotics.com/downloads.html
2. installieren
3. Matlab installieren
4. dieses Verzeichnis öffnen (alle dlls die man braucht sind hier dabei... sonst aus dem runtergeladenen vrep ordner die richtige raussuchen unter vrep/programming/remoteApiBindings/lib/Windows/$richtige version wählen$, in das Arbeitsverzeichnis kopieren)
5. vrep ausführen -> szene laden (ownRobot1.ttt), Simulation starten
6. GANZ WICHTIG die szene, die dll und das matlab script was ausgeführt werden soll MÜSSEN im gleichen ordner liegen (also quasi das projekt hier pullen und dann diesen ordner als workspace bei matlab angeben)
7. test.m ausführen lassen
<br>
<br>
Beschreibung für das übungstemplate:
1. Anleitung wie oben befolgen (alle Dateien sollten vorhanden sein)
3. Darauf achten, dass alles im gleichen Ordner ist
2. dann Simulation starten mit szene ownRobot1.ttt und dann das main.m skript ausfuehren



# useful links
api funktionen für matlab: http://www.coppeliarobotics.com/helpFiles/en/remoteApiFunctionsMatlab.htm  <br>
tutorial fürs setup: https://www.youtube.com/watch?v=piI5wYEXUms

# für mac OS
bei mac hatte ich den fehler das models nicht geladen wurde -> in den ordner gehen und im terminal ausführen:
sudo xattr -r -d com.apple.quarantine *

# für windows
also bei mir hat alles direkt funktioniert. 


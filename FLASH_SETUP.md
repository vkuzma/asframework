Aufsetzten Flash-Projekt
========================
     
Voraussetzung
------------
Django sollte nach der Anleitung: 
https://github.com/allink/toolbox/blob/master/django.md
bereits aufgesetzt sein

1. Order für Flashdateien erstellen:

        mkdir media/flash
        mkdir media/flash/debug                                      
        
2. .gitignore Datei hinzufügen
                                                                     
        cp path/to/asframework/django_includes/flash/flash\_gitignore media/flash/.gitignore
        
3. ActionScript Projekt im Flashbuilder erstellen. Projekt in projekt-name/flash abspeichern.
4. Im Flashprojekt einen Bibliotheksordner erstellen:
        
        mkdir ../flash/lib
        
5. In den Projekteinstellung den "Output folder" auf projekt-name/projekt_name/media/flash/debug setzen.
6. In den "Export Release Build" -Einstellungen den "Export to folder" auf projekt-name/projekt_name/media/flash setzen.  
7. projekt\_name\_assets.fla erstellen und im Flashprojekt unter src abspeichern.
8. Einen Ordner für die swc-Compilat erstellen:

        mkdir ../flash/bin
        cp path/to/asframework/django_includes/flash/bin\_ignore ..flash/.gitignore

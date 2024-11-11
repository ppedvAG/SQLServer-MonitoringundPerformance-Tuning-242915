--> für SQL 2014 und früher empfiehlt sich statt Wartungsplan
--das Script von Ola Hallengren zu verwenden
--hier werden Fragmentierungen berücksichtigt

-- > 30 % --> Rebuild
-- < 10 %       kein Defrag notwendig
-- 10 bis 30  ---> Reorg


/*

zu einer Wartung gehört auch das Aktualisieren von Statistiken.
Statistiken: SQL prüft  -vor Ausführung von Abfragen - wieviele Zeilen zurückkommen.
Diese Anzahl wird aus einem Histogramm gebildet, das der SQL Server automatisch erstellt.

Histogramm: Verteilung der Daten innerhalb einer Spalte (oder auch mehr Spalten)
Werden nicht bei jedem I U D aktualisiert und können somit im Laufe der Zeit falsch sein..

--Plan muss aber aufgrund der zu erwartenden Menge für SEEK oder SCAN entscheiden...


Je "korrekter" diese sind, desto exakter kann ein Ausführungsplan eingeschätzt werden...


Tools.. Datenbankoptimierungsassistent
Finden einer geeigneten IX Strategie


Einstellungen: 

Indizes und Indizierte Sichten
Partitionierung oder Columnstore wählen
Keine pyhs. Entwurfsstrukturen beibehalten
Erweiterte Optionen
Zeitlich beschränkt--> unter erweiterten Optionen. 
Max Speicher Wert übernehmen und anklicken
Wenn möglich Online

Evtl Online mit sortieren in Tempdb
	


---Tool Perfmon und Profiler

Daten des Perfmon könne in Profiler geladen werden
--Aufzeichnung neu öffnen
--Datei--> Import der Perfmon Daten

die Aufzeichnung des Profiler kann auch für den Datenbankoptimierungsratgeber verwendet werden.-- IX finden und Löschen auf der Basis eines typischen Workload
(oder über QueryStore)

Profiler unbedingt gut filtern, sonst zeichnen wir jede Aktion jedes users auf (auch Klicks im SSMS)
TSQL Start und Completet

Stored Procedures
SP:RPC Completet und SP:StmtCompletet
Messdaten: Dauer / CPU / Lesen / Reads / Apllication / Login / Textdata / Host /Dauer
Filter: Kann nur erstellt werden, wenn auch die Soalte zu sehen ist.. 
	zB: Databasename like 'northwind' , Login='Domäne\User', CPU > 1000ms



--Wartungsplan
-- Statistiken aktualisieren, Indizes Rebuilden und Reorg
--am besten täglich
--Indizes könne fragemntieren--> unter 10% nichts zu tun
							  --> zw 10 bis 30 % Reorg
							  -- > ab 30% Rebuild
--der Wartungsplan deckt dies ab (aber erst seit SQL 2016)








*/

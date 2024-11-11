dbcc showcontig('ku') --veraltet
--- Gescannte Seiten.............................: 39656
--- Mittlere Seitendichte (voll).....................: 98.27%

set statistics io, time on

select * from ku where id = 117

set statistics io, time off

select forwarded_record_count --sollte immer 0 oder NULL sein
from sys.dm_db_index_physical_stats(db_id(),object_id('ku'),NULL,NULL,'detailed')

--Gr IX erstellen und evtl wieder löschen, wenn man das will
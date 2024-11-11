Wichtige Katalogsichten des Query Stores:
sys.query_store_query: Enth�lt Informationen �ber die Abfragen, die vom Query Store erfasst wurden.
sys.query_store_plan: Beinhaltet Informationen zu den Ausf�hrungspl�nen der Abfragen.
sys.query_store_runtime_stats: Liefert Leistungsdaten (Laufzeitstatistiken) der Abfragen.
sys.query_store_runtime_stats_interval: Zeigt die Zeitintervalle, in denen die Leistungsdaten aggregiert werden.
sys.query_store_query_text: Speichert den tats�chlichen Text der Abfragen.
Beispiele f�r T-SQL-Abfragen:

1. Abfragen der am meisten verwendeten SQL-Abfragen
Diese Abfrage gibt eine Liste der Abfragen mit der h�chsten Ausf�hrungszeit zur�ck:

SELECT 
    qt.query_sql_text, 
    qs.execution_count,
    qs.total_elapsed_time / 1000 AS total_elapsed_time_ms,
    qs.total_logical_reads,
    qs.total_logical_writes,
    qs.total_worker_time / 1000 AS total_worker_time_ms
FROM 
    sys.query_store_query_text AS qt
JOIN 
    sys.query_store_query AS q ON qt.query_text_id = q.query_text_id
JOIN 
    sys.query_store_plan AS p ON q.query_id = p.query_id
JOIN 
    sys.query_store_runtime_stats AS qs ON p.plan_id = qs.plan_id
ORDER BY 
    qs.total_elapsed_time DESC;


Ja, der Query Store kann mithilfe von T-SQL-Abfragen genutzt werden, um Informationen �ber Abfragen, Ausf�hrungspl�ne und Leistungsdaten abzurufen. Der SQL Server speichert diese Informationen in speziellen Query Store-Katalogsichten, die f�r Abfragen zur Verf�gung stehen.

Wichtige Katalogsichten des Query Stores:
sys.query_store_query: Enth�lt Informationen �ber die Abfragen, die vom Query Store erfasst wurden.
sys.query_store_plan: Beinhaltet Informationen zu den Ausf�hrungspl�nen der Abfragen.
sys.query_store_runtime_stats: Liefert Leistungsdaten (Laufzeitstatistiken) der Abfragen.
sys.query_store_runtime_stats_interval: Zeigt die Zeitintervalle, in denen die Leistungsdaten aggregiert werden.
sys.query_store_query_text: Speichert den tats�chlichen Text der Abfragen.
Beispiele f�r T-SQL-Abfragen:

--1. Abfragen der am meisten verwendeten SQL-Abfragen
--Diese Abfrage gibt eine Liste der Abfragen mit der h�chsten Ausf�hrungszeit zur�ck:


SELECT 
    qt.query_sql_text, 
    qs.execution_count,
    qs.total_elapsed_time / 1000 AS total_elapsed_time_ms,
    qs.total_logical_reads,
    qs.total_logical_writes,
    qs.total_worker_time / 1000 AS total_worker_time_ms
FROM 
    sys.query_store_query_text AS qt
JOIN 
    sys.query_store_query AS q ON qt.query_text_id = q.query_text_id
JOIN 
    sys.query_store_plan AS p ON q.query_id = p.query_id
JOIN 
    sys.query_store_runtime_stats AS qs ON p.plan_id = qs.plan_id
ORDER BY 
    qs.total_elapsed_time DESC;

--2. Abfrage der regressiven Pl�ne
--Diese Abfrage zeigt, welche Abfragen einen schlechteren Plan bekommen haben:

	SELECT 
    q.query_id,
    qt.query_sql_text,
    p.plan_id,
    rs.avg_duration AS aktuelle_Laufzeit,
    p.forced_plan
FROM 
    sys.query_store_query AS q
JOIN 
    sys.query_store_query_text AS qt ON q.query_text_id = qt.query_text_id
JOIN 
    sys.query_store_plan AS p ON q.query_id = p.query_id
JOIN 
    sys.query_store_runtime_stats AS rs ON p.plan_id = rs.plan_id
WHERE 
    p.forced_plan = 0 -- Keine erzwungenen Pl�ne
ORDER BY 
    rs.avg_duration DESC;


--3. Ausf�hrungspl�ne anzeigen
--Diese Abfrage zeigt die Ausf�hrungspl�ne f�r eine bestimmte Abfrage basierend auf ihrer Query-ID:

SELECT 
    p.query_id,
    p.plan_id,
    q.query_sql_text,
    p.query_plan
FROM 
    sys.query_store_plan AS p
JOIN 
    sys.query_store_query AS q ON p.query_id = q.query_id
JOIN 
    sys.query_store_query_text AS qt ON q.query_text_id = qt.query_text_id
WHERE 
    p.query_id = @QueryID;  -- @QueryID durch die tats�chliche Query-ID ersetzen


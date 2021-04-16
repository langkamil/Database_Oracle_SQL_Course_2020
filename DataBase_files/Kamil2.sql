drop table pracownicy_kopia;
---1---
CREATE TABLE pracownicy_kopia
(id,nr_prac,imie,nazwisko,pesel,pensja,data_zatr,data_zw)
AS SELECT 
id,nr_prac,imie,nazwisko,pesel,pensja,data_zatr,data_zw
FROM pracownicy; 

select * from pracownicy_kopia;

---2---
ALTER TABLE pracownicy_kopia ADD (dodatek NUMBER(6,2));

select * from pracownicy_kopia;

---3---
UPDATE pracownicy_kopia
SET dodatek=COALESCE(100*trunc(months_between(sysdate,data_zatr)/12), 0);

select * from pracownicy_kopia;


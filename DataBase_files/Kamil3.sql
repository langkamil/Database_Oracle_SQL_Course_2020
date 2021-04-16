drop table pracownicy_kopia1;
drop table pracownicy2;
---1---
CREATE TABLE pracownicy_kopia1
(id,nr_prac,imie,nazwisko,pesel,pensja,data_zatr,data_zw)
AS SELECT 
id,nr_prac,imie,nazwisko,pesel,pensja,data_zatr,data_zw
FROM pracownicy; 

select * from pracownicy_kopia1;

---2---
ALTER TABLE pracownicy_kopia1 ADD (dodatek NUMBER(6,2));

select * from pracownicy_kopia1;

---3---
UPDATE pracownicy_kopia1
SET dodatek = CASE WHEN 100*trunc(months_between(sysdate,data_zatr)/12) IS NOT NULL AND data_zw is null 
then 100*trunc(months_between(sysdate,data_zatr)/12) else 0 end;

select * from pracownicy_kopia1;

---4---
DELETE FROM pracownicy_kopia1
WHERE trunc(months_between(sysdate,data_zatr)/12)>10 or trunc(months_between(sysdate,data_zatr)/12)<5;

select * from pracownicy_kopia1;

---5---
ALTER TABLE pracownicy_kopia1 DROP COLUMN nr_prac;

select * from pracownicy_kopia1;

---6---
RENAME pracownicy_kopia1 TO pracownicy2; 

select * from pracownicy2;


---7---
ALTER TABLE pracownicy2 ADD (imie2 INT);

select * from pracownicy2;

---8---
ALTER TABLE pracownicy2 MODIFY (imie2 VARCHAR2(15));

select * from pracownicy2;

---9---
ALTER TABLE pracownicy2 RENAME COLUMN imie2 TO drugie_imie;

select * from pracownicy2;
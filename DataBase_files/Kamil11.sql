--Zadanie 6
--funkcja generujaca numery tablic rejestracyjnych w powiecie koœcierskim
create or replace function gen_numer return varchar2 as
begin
return replace ('GKS' || '_' || to_char(trunc(dbms_random.value(0,999)),'009') 
|| dbms_random.string(1,2),' '); 
end gen_numer;
 
 select
 gen_numer() as tablica1,
 gen_numer() as tablica2,
 gen_numer() as tablica3,
 gen_numer() as tablica04
from dual;

--funkcja generujaca liczbe miesiecy od losowego czasu zarejestrowania w ostatnim 20-leciu do dzisiaj
create or replace function gen_data (
 data_1 date:=to_date('2000-01-01','yyyy-mm-dd'),
 data_2 date:=to_date('2019-12-31','yyyy-mm-dd')
) return int as
begin
 return trunc(months_between(sysdate, data_1+trunc(dbms_random.value(0,data_2-data_1))));
end gen_data;
/ 
alter session set nls_date_format = 'yyyy-mm-dd';
select
 gen_data() as czas1,
 gen_data(to_date('2012-01-01','yyyy-mm-dd'),to_date('2012-12-31','yyyy-mm-dd'))
as czas2
from dual;
/

--Zadanie 7
--procedura uzupelniajaca tablice pojazdy podana iloscia rekordow

create table pojazdy (id int , nr_tablicy varchar2(15), miesiace_zarej int , miesiace_ubezp int );  

create or replace procedure dodaj_pojazdy (ilosc int) as
begin 
    for idx in 1..ilosc loop
        insert into pojazdy (id, nr_tablicy, miesiace_zarej, miesiace_ubezp)
        values (idx ,gen_numer(), gen_data(), gen_data(to_date('2018-01-01','yyyy-mm-dd')
        ,to_date('2019-12-31','yyyy-mm-dd')));
            end loop;
end;            
EXECUTE dodaj_pojazdy (100);
select * from pojazdy;












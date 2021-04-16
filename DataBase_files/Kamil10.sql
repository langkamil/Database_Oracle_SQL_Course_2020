
insert into "176553_stanowiska" values('1','kierownik','6123,32','zarzadza sklepem i pracownikami');
insert into "176553_stanowiska" values('2','kasjer','4032,28','obsluguje kase');
insert into "176553_stanowiska" values('3','opiekun','3992,94','zajmuje sie zwierzetami');
insert into "176553_stanowiska" values('4','ksiegowy','5031,00',null);

insert into "176553_adresy_pracownikow" values('1','biala','21','11-211','Plock');
insert into "176553_adresy_pracownikow" values('2','czarna','31','12-233','Kloc');
insert into "176553_adresy_pracownikow" values('3','rozowa','34','13-322','Bug');
insert into "176553_adresy_pracownikow" values('4','niebieska','45','14-321','Rog');
insert into "176553_adresy_pracownikow" values('5','pomaranczowa','56','15-324','Gar');
insert into "176553_adresy_pracownikow" values('6','zlota','56','16-423','Pila');
insert into "176553_adresy_pracownikow" values('7','zolta','86','17-235','Lodz');
insert into "176553_adresy_pracownikow" values('8','fioletowa','51','18-543','Romb');

insert into "176553_pracownicy" values('1','Jan','Koc','12345678912','213456179','jankoc@wp.pl',null,'1','8');
insert into "176553_pracownicy" values('2','Jakub','Kot','32463528492','231312321','jakubkot@wp.pl',to_date('02/07/13','RR/MM/DD'),'2','7');
insert into "176553_pracownicy" values('3','Anna','Kloc','34324234234','642123546','annakloc@wp.pl',to_date('07/12/15','RR/MM/DD'),'2','6');
insert into "176553_pracownicy" values('4','Krystyna','Las','94242357568','768543251','krystynalas@wp.pl',null,'2','5');
insert into "176553_pracownicy" values('5','Robert','Dom','85686865666','783908765','robertdom@wp.pl',to_date('12/03/14','RR/MM/DD'),'3','4');
insert into "176553_pracownicy" values('6','Kamil','Kwarc','75686795975','737546287','kamilkwarc@wp.pl',null,'3','3');
insert into "176553_pracownicy" values('7','Szymon','Lit','85799797679','840321465','szymonlit@wp.pl',to_date('19/01/18','RR/MM/DD'),'3','2');
insert into "176553_pracownicy" values('8','Henryka','Hel','96737536360','849626584','henrykahel@wp.pl',null,'4','1');

insert into "176553_platnosci" values('1','gotowka');
insert into "176553_platnosci" values('2','karta');

insert into "176553_kategorie" values('1','ssaki','psy i koty','standardowe');
insert into "176553_kategorie" values('2','gryzonie','chomiki, myszy i szczury',null);
insert into "176553_kategorie" values('3','gady','zolwie, jaszczurki i weze',null);
insert into "176553_kategorie" values('4','ptaki',null,null);


insert into "176553_adresy_hodowli" values('1','53','ciepla','19-231','Wroclaw');
insert into "176553_adresy_hodowli" values('2','78','zimna ','20-123','Szczecin');
insert into "176553_adresy_hodowli" values('3','92','goraca','32-322','Krakow');
insert into "176553_adresy_hodowli" values('4','134','cicha','33-242','Rzeszow');
insert into "176553_adresy_hodowli" values('5','675','spokojna','35-863','Bialogora');
insert into "176553_adresy_hodowli" values('6','62','mila','36-641','Poznan');
insert into "176553_adresy_hodowli" values('7','83','dolna','37-786','Kutno');
insert into "176553_adresy_hodowli" values('8','2','walna','38-932','Grodno');

insert into "176553_hodowle" values('1','Jarex','hodowla psow','1');
insert into "176553_hodowle" values('2','Polex','hodowla kotow ','2');
insert into "176553_hodowle" values('3','Januszex','hodowla myszy','3');
insert into "176553_hodowle" values('4','Drutex','hodowla szczurow','4');
insert into "176553_hodowle" values('5','Amica','hodowla chomikow','5');
insert into "176553_hodowle" values('6','Lenowos','hodwla zolwi','6');
insert into "176553_hodowle" values('7','Adamantex','hodowla jaszczurek','7');
insert into "176553_hodowle" values('8','Rio','hodowla wezy','8');

insert into "176553_zwierzeta" values('1','pies ','232,43','15','1');
insert into "176553_zwierzeta" values('2','kot','158,16','15','2');
insert into "176553_zwierzeta" values('3','mysz','12,43','30','3');
insert into "176553_zwierzeta" values('4','szczur','25,86','34','4');
insert into "176553_zwierzeta" values('5','chomik','15,47','22','5');
insert into "176553_zwierzeta" values('6','zolw','70,48','7','6');
insert into "176553_zwierzeta" values('7','jaszczurka','185,52','27','7');
insert into "176553_zwierzeta" values('8','waz','384,54','8','8');

insert into "176553_przypisanie" values('1','1');
insert into "176553_przypisanie" values('2','1');
insert into "176553_przypisanie" values('3','2');
insert into "176553_przypisanie" values('4','2');
insert into "176553_przypisanie" values('5','2');
insert into "176553_przypisanie" values('6','3');
insert into "176553_przypisanie" values('7','3');
insert into "176553_przypisanie" values('8','3');

insert into "176553_opieka" values('5','1');
insert into "176553_opieka" values('5','2');
insert into "176553_opieka" values('5','3');
insert into "176553_opieka" values('6','4');
insert into "176553_opieka" values('6','5');
insert into "176553_opieka" values('6','6');
insert into "176553_opieka" values('7','7');
insert into "176553_opieka" values('7','8');

insert into "176553_transakcje_szczegoly" values('1',to_date('19/07/13','RR/MM/DD'),to_date('08:00','HH24:MI'),'2','1');
insert into "176553_transakcje_szczegoly" values('2',to_date('19/03/23','RR/MM/DD'),to_date('09:00','HH24:MI'),'2','1');
insert into "176553_transakcje_szczegoly" values('3',to_date('19/10/28','RR/MM/DD'),to_date('10:00','HH24:MI'),'2','1');
insert into "176553_transakcje_szczegoly" values('4',to_date('19/09/16','RR/MM/DD'),to_date('11:00','HH24:MI'),'3','1');
insert into "176553_transakcje_szczegoly" values('5',to_date('19/02/03','RR/MM/DD'),to_date('12:00','HH24:MI'),'3','2');
insert into "176553_transakcje_szczegoly" values('6',to_date('19/07/03','RR/MM/DD'),to_date('13:00','HH24:MI'),'3','2');
insert into "176553_transakcje_szczegoly" values('7',to_date('19/01/22','RR/MM/DD'),to_date('14:00','HH24:MI'),'4','2');
insert into "176553_transakcje_szczegoly" values('8',to_date('19/06/30','RR/MM/DD'),to_date('15:00','HH24:MI'),'4','2');

insert into "176553_transakcje" values('1','2','232,43','1');
insert into "176553_transakcje" values('2','2','316,32','2');
insert into "176553_transakcje" values('3','2','24,86','2');
insert into "176553_transakcje" values('4','3','25,86','1');
insert into "176553_transakcje" values('5','3','46,41','3');
insert into "176553_transakcje" values('6','3','281,92','4');
insert into "176553_transakcje" values('7','4','371,04','2');
insert into "176553_transakcje" values('8','4','1538,16','4');


select
 (select count(*) from "176553_stanowiska") as "176553_stanowiska",
 (select count(*) from "176553_adresy_pracownikow") as "176553_adresy_pracownikow",
 (select count(*) from "176553_pracownicy") as "176553_pracownicy",
 (select count(*) from "176553_platnosci") as "176553_platnosci",
 (select count(*) from "176553_kategorie") as "176553_kategorie",
 (select count(*) from "176553_adresy_hodowli") as "176553_adresy_hodowli",
 (select count(*) from "176553_hodowle") as "176553_hodowle",
 (select count(*) from "176553_zwierzeta") as "176553_zwierzeta",
 (select count(*) from "176553_przypisanie") as "176553_przypisanie",
 (select count(*) from "176553_opieka") as "176553_opieka",
 (select count(*) from "176553_transakcje_szczegoly") as "176553_transakcje_szczegoly",
 (select count(*) from "176553_transakcje") as "176553_transakcje"
from dual;


CREATE VIEW brakujace_zwierzeta AS
SELECT nazwa , ilosc from "176553_zwierzeta"
where ilosc < 20;

CREATE VIEW staz_pracy AS
SELECT imie, nazwisko, trunc(months_between(sysdate, "data zatrudnienia")/12) as lata from "176553_pracownicy";

CREATE VIEW placa as
select nazwa as stanowisko,  coalesce(pensja,0) as "pensja [PLN]" from "176553_stanowiska";

CREATE VIEW zakupy as
select "176553_transakcje_id" as numer_transakcji, cena_laczna from "176553_transakcje";

CREATE VIEW pracownicy_szczegoly as
SELECT imie, nazwisko,nazwa as stanowisko, pensja, miejscowosc  from "176553_pracownicy" p 
left join "176553_stanowiska" s on p.stanowiska_id=s.id 
left join "176553_adresy_pracownikow" a on p.adresy_pracownikow_id=a.id ;
 
Create View sprzedaz_w_miesiacach as
select sztuk , nazwa as zwierze, extract(month from data_sprzedazy) as miesiac_sprzedazy 
from "176553_transakcje" t 
left join "176553_zwierzeta" z on t."176553_transakcje_id"=z.nr left join "176553_transakcje_szczegoly" s on t."176553_transakcje_id"=s.id
ORDER BY sztuk, miesiac_sprzedazy;
 
CREATE VIEW pochodzenie_zwierzat as
select z.nazwa as zwierze ,miejscowosc from "176553_zwierzeta" z 
left join "176553_hodowle" h on z."176553_hodowle_id" = h.id 
left join "176553_adresy_hodowli" a on h."176553_adresy_hodowli_id"= a.id
order by z.ilosc;

CREATE VIEW kontakt_z_opiekunem as
select z.nazwa as zwierze ,p.nazwisko, p.nr_telefonu from "176553_zwierzeta"  z 
right join "176553_opieka" o on z.nr = o."176553_zwierzeta_nr" 
left join "176553_pracownicy" p on o."176553_pracownicy_id"= p.id
order by p.nazwisko;
 

select * from brakujace_zwierzeta;
select * from staz_pracy;
select * from placa;
select * from zakupy;
select * from pracownicy_szczegoly;
select * from pochodzenie_zwierzat;
select * from kontakt_z_opiekunem;
select * from sprzedaz_w_miesiacach;





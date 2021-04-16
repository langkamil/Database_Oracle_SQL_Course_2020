--zad. 7 
--Dana jest tabela zamowieni(id, przedmiot, kwota, rabat, koszt)
--Stwórz wyzwalacz, który:
--a) automatycznie zdefiniuje kolejne numery id dodanych przedmiotow,
--b) przypisze odpowiednie rabaty dla zakupow (10% ponizej 50zl, 20% od 50 do 100zl, 30% od 100 do 200zl, 
--                                            40% od 200 do 500zl, 50% od 500 do 1000 zl, 0% powyzej 1000zl)
--c) obliczy koszt po uwzglednieniu rabatu
--d) odpowiednie dane wpisze do odpowiednich kolumn

create table zamowienia(id int primary key, przedmiot varchar2(30), kwota numeric(6,2), rabat numeric(6), koszt numeric(6,2));

create sequence zamowienie_seq_id start with 1 increment by 1 nomaxvalue;

create or replace trigger dodaj_zamowienie before insert on zamowienia for each row
declare 
kwota_n numeric(6,2):=:new.kwota;
rabat_n numeric(6,2);
koszt_n numeric(6,2);
begin
if kwota_n<50 then rabat_n:=kwota_n*0.1;
elsif (50<kwota_n and kwota_n<=100) then rabat_n:=kwota_n*0.2;
elsif (100<kwota_n and kwota_n<=200) then rabat_n:=kwota_n*0.3;
elsif(200<kwota_n and kwota_n<=500) then rabat_n:=kwota_n*0.4;
elsif (500<kwota_n and kwota_n<=1000) then rabat_n:=kwota_n*0.5;
elsif (kwota_n>1000) then rabat_n:=0;
end if;
koszt_n:=kwota_n-rabat_n;
:new.id:=zamowienie_seq_id.nextval;
:new.rabat:=rabat_n;
:new.koszt:=koszt_n;
end;

insert into zamowienia(przedmiot, kwota) values ('rower', 2000);
insert into zamowienia(przedmiot, kwota) values ('kask', 600);
insert into zamowienia(przedmiot, kwota) values ('lampka', 150);
insert into zamowienia(przedmiot, kwota) values ('ochraniacze', 250);
insert into zamowienia(przedmiot, kwota) values ('bidon', 90);
insert into zamowienia(przedmiot, kwota) values ('dzwonek', 30);

select * from zamowienia;
--------------------------------------------------------------------------------------------------------------------------------
--Zad.  8
--Tworzymy tabele pracownicy(id,imie, nazwisko, pensja)
--Tworzymy tabele pracownicy_awanse (id,nazwisko, pensja_brutto_s, pensja_brutto_n, pensja_netto_n, roznica, stosunek, data_modyfikacji)
--Stworz wyzwalacz, ktory:
--a) przy aktualizowaniu pensji brutto ustali roznice pomiedzy nowa a stara pensja (brutto)
--b) okresli pensje netto (wg wlasnej inwencji)
--c) wyznaczy stosunek do sredniej krajowej 
--d) wpisze do kolumny data_modyfikacji date systemowa zmiany
create table pracownicy (id int primary key, imie varchar2(20), nazwisko varchar2(20), pensja number(7,2));
insert into pracownicy (id,imie,nazwisko,pensja) values (1, 'Adam', 'Kot',5567.32);
insert into pracownicy (id,imie,nazwisko,pensja) values (2, 'Ala', 'Dom',3235.32);
insert into pracownicy (id,imie,nazwisko,pensja) values (3, 'Jerzy', 'Las',9324.94);
insert into pracownicy (id,imie,nazwisko,pensja) values (4, 'Stefan', 'Ul', 15543.32);

select * from pracownicy;

create table pracownicy_roznice (id int primary key, nazwisko varchar2(20), pensja_brutto_s number(7,2), pensja_brutto_n number(7,2),   
pensja_netto_n number(7,2), roznica number(7,2), stosunek number (7,2), data_modyfikacji date);

create or replace trigger pracownicy_modyfikacja before update on pracownicy for each row 
declare
pensja_b_n_v number (7,2):=:new.pensja;
pensja_n_n_v number (7,2);
roznica_v    number (7,2);
stosunek_v   number (7,2);
begin 
if pensja_b_n_v >=10000.00 then pensja_n_n_v := 0.7 * pensja_b_n_v;
elsif (pensja_b_n_v < 10000.00 and pensja_b_n_v >=  5000.00) then  pensja_n_n_v := 0.8 * pensja_b_n_v;
else pensja_n_n_v := 0.9 * pensja_b_n_v;
end if;
roznica_v := pensja_b_n_v - :old.pensja;
stosunek_v := (pensja_b_n_v /5489.21)*100;
if updating then
insert into pracownicy_roznice (id, nazwisko , pensja_brutto_s, pensja_brutto_n, pensja_netto_n , roznica, stosunek , data_modyfikacji ) 
values (:old.id, :old.nazwisko, :old.pensja, pensja_b_n_v, pensja_n_n_v, roznica_v, stosunek_v, sysdate );
end if;
end;

update pracownicy set pensja=1000 where id=1;
update pracownicy set pensja=10100 where id=2;
update pracownicy set pensja=6100 where id=3;
update pracownicy set pensja=20000 where id=4;

select * from pracownicy_roznice;

--------------------------------------------------------------------------------------------------------------------------------
--Zad. 9
--Tworzymy tabele zamowienia_zmiany (id, przedmiot, kwota_stara, kwota_nowa, rabat_stary, rabat_nowy, koszt_stary, koszt_nowy, roznica, opis)
--Stworz wyzwalacz, ktory:
--a) ustali nowe rabaty zgodnie z ustaleniami z zadania 7;
--b) wskaze roznice miedzy starym kosztem a nowym kosztem;
--c) sprawdzi czy koszt wzrosl, spadl czy pozostal neutralny;
--d) ukaze wszystkie zmiany w tabeli zamowienia_zmiany
create table zamowienia_zmiany (id int primary key,przedmiot varchar2(15), kwota_stara numeric(6,2), 
kwota_nowa numeric(6,2), rabat_stary numeric(6,2), rabat_nowy numeric(6,2), koszt_stary numeric(6,2), 
koszt_nowy numeric(6,2), roznica numeric(6,2), opis varchar2(10));

create or replace trigger zamowienia_zmien after update on zamowienia for each row
declare 
kwota_n numeric(6,2):=:new.kwota;
rabat_n numeric(6,2);
koszt_n numeric(6,2);
roznica_v numeric(6,2);
opis_v varchar2(15);
begin
if kwota_n<50 then rabat_n:=kwota_n*0.1;
elsif (50<kwota_n and kwota_n<=100) then rabat_n:=kwota_n*0.2;
elsif (100<kwota_n and kwota_n<=200) then rabat_n:=kwota_n*0.3;
elsif(200<kwota_n and kwota_n<=500) then rabat_n:=kwota_n*0.4;
elsif (500<kwota_n and kwota_n<=1000) then rabat_n:=kwota_n*0.5;
elsif (kwota_n>1000) then rabat_n:=0;
end if; 
koszt_n:=kwota_n-rabat_n;
roznica_v:=koszt_n-:old.koszt;
if roznica_v<0 then opis_v:='spadek';
elsif roznica_v=0 then opis_v:='neutralny';
else opis_v:='wzrost';
end if;
if updating then insert into zamowienia_zmiany(id,przedmiot, kwota_stara, kwota_nowa, rabat_stary, rabat_nowy,
koszt_stary, koszt_nowy, roznica, opis) values (:old.id, :old.przedmiot, :old.kwota, kwota_n, :old.rabat, rabat_n,
:old.koszt, koszt_n, roznica_v, opis_v);
end if;
end;

update zamowienia set kwota=999 where przedmiot='rower';
update zamowienia set kwota=499 where przedmiot='kask';
update zamowienia set kwota=90 where przedmiot='lampka';
update zamowienia set kwota=400 where przedmiot='ochraniacze';
update zamowienia set kwota=49 where przedmiot='bidon';
update zamowienia set kwota=20 where przedmiot='dzwonek';

select * from zamowienia_zmiany;
--------------------------------------------------------------------------------------------------------------------------------
--Zadanie 10
--Na podstawie tabeli pracownicy_awanse z zadania 8
--Stworz wyzwalacz, ktory:
--po usunieciu pracownika doda do nowej tabeli usunieci nastepujace dane:
--a) czas w miesiacach od zmiany pensji  do usuniecia
--b) nazwisko pracownika
--c) srednia z wynagrodzenia starego i nowego
--d) w zaleznosci od roznicy wpisze czy pracownik byl zdegradowany czy awansowany

create table usunieci (id int primary key, nazwisko varchar2(20), srednia number(7,2), rodzaj_zmiany varchar(20), czas int);

create or replace trigger usuwanie_pracownikow after delete on pracownicy_roznice for each row declare
srednia_v number(7,2);
rodzaj_zmiany_v varchar2 (20);
czas_v int;
begin
srednia_v := (:old.pensja_brutto_s + :old.pensja_brutto_n)/2;
if :old.roznica > 0 then rodzaj_zmiany_v := 'awans';
elsif :old.roznica < 0 then rodzaj_zmiany_v := 'degradacja';
else raise_application_error(-20501,'nie nastapila zmiana');
end if;
czas_v := (months_between(trunc(sysdate), :old.data_modyfikacji));
if deleting then 
insert into usunieci (id, nazwisko, srednia, rodzaj_zmiany, czas) 
VALUES (:old.id, :old.nazwisko, srednia_v, rodzaj_zmiany_v, czas_v);
end if;
end;

delete pracownicy_roznice where id = 1;
delete pracownicy_roznice where id = 2;
delete pracownicy_roznice where id = 3;
delete pracownicy_roznice where id = 4;

select * from usunieci;

--------------------------------------------------------------------------------------------------------------------------------
--Zadanie 11
--Dana jest tabela samochody(kategoria, marka, model, km, rok), gdzie kat=1 to BMW, 2 to AUDI, 3 to SEAT, 4 to VOLKSWAGEN
--Dany jest widok pokazujacy kategorie, model, ilosc km, rok pojazdu
--Stworz wyzwalacz, ktory podczas dodania rekordu do widoku automatycznie doda rekord do tabeli samochody
--z odpowiednio dopasowanym modelem zaleznie od podanej kategorii pojazdu.

create table samochody (kategoria int,marka varchar2(15), model varchar2(10), KM numeric(3), rok char(4));

insert into samochody (kategoria, marka, model, km, rok) values (1,'BMW', 'X5', 230, '2016');
insert into samochody (kategoria, marka, model, km, rok) values (1,'BMW', 'X3', 250, '2017');
insert into samochody (kategoria, marka, model, km, rok) values (2,'AUDI', 'A3', 230, '2016');
insert into samochody (kategoria, marka, model, km, rok) values (2,'AUDI', 'A3', 190, '2015');
insert into samochody (kategoria, marka, model, km, rok) values (3,'SEAT', 'LEON', 140, '2001');
insert into samochody (kategoria, marka, model, km, rok) values (3,'SEAT', 'LEON', 90, '2001');
insert into samochody (kategoria, marka, model, km, rok) values (4,'VOLKSWAGEN', 'BORA', 90, '2003');

select * from samochody;

create or replace view sr_marka as select kategoria, model, km, rok from samochody;


create or replace trigger dodaj_samochod instead of insert on sr_marka for each row
begin 
if :new.kategoria=1  then 
   insert into samochody (kategoria, marka, model, km, rok) values (:new.kategoria,'BMW',:new.model,:new.km, :new.rok);
elsif :new.kategoria=2 then 
   insert into samochody (kategoria, marka, model, km, rok) values (:new.kategoria,'AUDI', :new.model, :new.km, :new.rok);
elsif :new.kategoria=3 then 
   insert into samochody (kategoria, marka, model, km, rok) values (:new.kategoria, 'SEAT', :new.model, :new.km, :new.rok);
elsif :new.kategoria=4 then 
   insert into samochody (kategoria, marka, model, km, rok) values (:new.kategoria,'VOLKSWAGEN', :new.model, :new.km, :new.rok);
end if;
end;

insert into sr_marka(kategoria, model, km, rok) values (1, 'E36', 140, '1999');
insert into sr_marka(kategoria, model, km, rok) values (2, 'A4', 190, '2015');
insert into sr_marka(kategoria, model, km, rok) values (1, 'E39', 150, '2002');
insert into sr_marka(kategoria, model, km, rok) values (1, 'E39', 200, '2002');
insert into sr_marka(kategoria, model, km, rok) values (4, 'PASSAT', 90, '2001');

select * from samochody;
--------------------------------------------------------------------------------------------------------------------------------
--Zadanie 12
--Tworzymy tabele terminy przechowujace dane o zaplanowanych spotkaniach o spotkaniach 
--tworzymy widok zawierajacy id, nazwisko i date spotkania
--tworzymy tabele terminy_przelozone zawierajaca informacje o przelozonych terminach 
--Stworz wyzywalacz, ktory zamiast zmieniac date w widoku doda nowa do tabeli


create table terminy (id int primary key, imie varchar2(20), nazwisko varchar2(20), data_spotkania date);
insert into terminy (id, imie, nazwisko, data_spotkania) values (1, 'Jan', 'Juk', TO_DATE('2020/04/12','YYYY/MM/DD'));
insert into terminy (id, imie, nazwisko, data_spotkania) values (2, 'Ala', 'Rok', TO_DATE('2021/06/22','YYYY/MM/DD'));
insert into terminy (id, imie, nazwisko, data_spotkania) values (3, 'Marek', 'Sok', TO_DATE('2022/08/01','YYYY/MM/DD'));
insert into terminy (id, imie, nazwisko, data_spotkania) values (4, 'Henryk', 'Szok', TO_DATE('2020/12/12','YYYY/MM/DD'));

create view terminy_widok as select id, nazwisko, data_spotkania from terminy;

select * from terminy_widok;

create table terminy_przelozone (id int primary key,  nazwisko varchar2(20), data_spotkania_przelozona date, data_spotkania_poczatkowa date,
czas_przelozenia int, opis varchar2(20));

create or replace trigger przelozenie instead of update on terminy_widok for each row 
begin 
if (months_between(trunc(:new.data_spotkania), :old.data_spotkania)) > 0 then 
insert into terminy_przelozone (id, nazwisko, data_spotkania_przelozona, data_spotkania_poczatkowa, czas_przelozenia, opis)
values (:old.id, :old.nazwisko, :new.data_spotkania,:old.data_spotkania, (months_between(trunc(:new.data_spotkania), :old.data_spotkania)),
'termin pozniejszy');
elsif (months_between(trunc(:new.data_spotkania), :old.data_spotkania)) < 0  and :new.data_spotkania > sysdate then 
insert into terminy_przelozone (id, nazwisko, data_spotkania_przelozona, data_spotkania_poczatkowa, czas_przelozenia, opis)
values (:old.id, :old.nazwisko, :new.data_spotkania,:old.data_spotkania, (months_between(trunc(:new.data_spotkania), :old.data_spotkania)),
'termin wczesniejszy');
elsif :new.data_spotkania < sysdate then  raise_application_error(-20501,'podano bledna date');
end if;
end;

update terminy_widok SET data_spotkania = to_date('2023/05/12','YYYY/MM/DD') where id = 1;
update terminy_widok SET data_spotkania = to_date('2020/09/16','YYYY/MM/DD') where id = 2;
update terminy_widok SET data_spotkania = to_date('2021/12/12','YYYY/MM/DD') where id = 3;
update terminy_widok SET data_spotkania = to_date('2028/11/29','YYYY/MM/DD') where id = 4;

select * from terminy_przelozone;




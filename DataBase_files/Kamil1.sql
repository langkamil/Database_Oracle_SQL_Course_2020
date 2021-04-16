

-- usuwamy wszystkie tabele
begin
  for rek in (select table_name from user_tables)
  loop
    execute immediate 'drop table '||rek.table_name||' cascade constraints';
  end loop;
end;
/ 
-- usuwamy wszystkie sekwencje
begin
  for rek in (select sequence_name from  user_sequences)
  loop
    execute immediate 'drop sequence '||rek.sequence_name;
  end loop;
end;
/
-- tworzymy tabele, sekwencje i wyzwalacze do autoinkrementacji
create table adres (
  id integer primary key,
  ulica varchar2(50) not null,
  numer varchar2(10) not null,
  kod char(6) not null,
  miejscowosc varchar2(30) not null
);
/
create sequence adres_sekwencja start with 1 increment by 1 nomaxvalue;
/
create trigger adres_insert
before insert on adres
for each row
begin
  select adres_sekwencja.nextval into :new.id from dual;
end;
/
create table klient (
  id integer primary key,
  adres_id integer not null unique,
  imie varchar2(25) not null,
  nazwisko varchar2(30) not null,
  pesel char(11) not null unique,
  telefon varchar2(20) not null,
  email varchar2(50) not null,
  haslo varchar2(30) not null,
  rabat integer default 0 not null,
  data_dodania timestamp default sysdate not null,
  usuniety number(1) default 0 not null
);
/
alter table klient add foreign key(adres_id) references adres(id);
/
create sequence klient_sekwencja start with 1 increment by 1 nomaxvalue;
/
create trigger klient_insert
before insert on klient
for each row
begin
  select klient_sekwencja.nextval into :new.id from dual;
end;
/
create table kategoria (
  id integer primary key,
  nazwa varchar2(30) not null unique
);
/
create sequence kategoria_sekwencja start with 1 increment by 1 nomaxvalue;
/
create trigger kategoria_insert
before insert on kategoria
for each row
begin
  select kategoria_sekwencja.nextval into :new.id from dual;
end;
/
create table podkategoria (
  id integer primary key,
  kategoria_id integer not null,
  nazwa varchar2(30) not null unique
);
/
alter table podkategoria add foreign key(kategoria_id) references kategoria(id);
/
create sequence podkategoria_sekwencja start with 1 increment by 1 nomaxvalue;
/
create trigger podkategoria_insert
before insert on podkategoria
for each row
begin
  select podkategoria_sekwencja.nextval into :new.id from dual;
end;
/
create table pracownik (
  id integer primary key,
  adres_id integer not null unique,
  imie varchar2(25) not null,
  nazwisko varchar2(30) not null,
  data_zatrudnienia date default sysdate not null,
  pensja number(8,2) not null check(pensja>0),
  dodatek number (8,2) null,
  stanowisko varchar2(30) not null,
  usuniety number(1) default 0 not null 
);
/
alter table pracownik add foreign key(adres_id) references adres(id);
/
create sequence pracownik_sekwencja start with 1 increment by 1 nomaxvalue;
/
create trigger pracownik_insert
before insert on pracownik
for each row
begin
  select pracownik_sekwencja.nextval into :new.id from dual;
end;
/
create table producent (
  id integer primary key,
  adres_id integer not null unique,
  nazwa varchar2(30) not null unique
);
/
alter table producent add foreign key(adres_id) references adres(id);
/
create sequence producent_sekwencja start with 1 increment by 1 nomaxvalue;
/
create trigger producent_insert
before insert on producent
for each row
begin
  select producent_sekwencja.nextval into :new.id from dual;
end;
/
create table produkt (
  id integer primary key,
  producent_id integer not null,
  podkategoria_id integer not null,
  nazwa varchar2(30) not null,
  opis varchar2(50) not null,
  cena_netto number(10,2) not null check(cena_netto>0),
  podatek integer default 23 not null,
  ilosc_sztuk_magazyn integer default 0 not null check(ilosc_sztuk_magazyn>=0)
);
/
alter table produkt add foreign key(producent_id) references producent(id);
alter table produkt add foreign key(podkategoria_id) references podkategoria(id);
/
create sequence produkt_sekwencja start with 1 increment by 1 nomaxvalue;
/
create trigger produkt_insert
before insert on produkt
for each row
begin
  select produkt_sekwencja.nextval into :new.id from dual;
end;
/
create table status (
  id integer primary key,
  nazwa varchar2(50) not null,
  opis varchar2(50) not null
);
/
create sequence status_sekwencja start with 1 increment by 1 nomaxvalue;
/
create trigger status_insert
before insert on status
for each row
begin
  select status_sekwencja.nextval into :new.id from dual;
end;
/
create table zamowienie (
  id integer primary key,
  pracownik_id integer not null,
  klient_id integer not null,
  data_zamowienia timestamp not null,
  cena_netto_dostawy number(8,2) default 0 not null,
  podatek integer default 23 not null 
);
/
alter table zamowienie add foreign key(pracownik_id) references pracownik(id);
alter table zamowienie add foreign key(klient_id) references klient(id);
/
create sequence zamowienie_sekwencja start with 1 increment by 1 nomaxvalue;
/
create trigger zamowienie_insert
before insert on zamowienie
for each row
begin
  select zamowienie_sekwencja.nextval into :new.id from dual;
end;
/
create table koszyk (
  zamowienie_id integer not null,
  produkt_id integer not null,
  cena_netto number(8,2) not null check(cena_netto>0),
  podatek integer default 23 not null,
  ilosc_sztuk integer default 0 not null check(ilosc_sztuk>=0),
  primary key(zamowienie_id, produkt_id)
);
/
alter table koszyk add foreign key(zamowienie_id) references zamowienie(id);
alter table koszyk add foreign key(produkt_id) references produkt(id);
/
create table zamowienie_status (
  zamowienie_id integer not null,
  status_id integer not null,
  data_zmiany_statusu timestamp default sysdate not null,
  uwagi varchar2(100) null,
  primary key(zamowienie_id, status_id)
);
/
alter table zamowienie_status add foreign key(zamowienie_id) references zamowienie(id);
alter table zamowienie_status add foreign key(status_id) references status(id);
/
create table faktura (
  id integer primary key,
  zamowienie_id integer not null,
  klient_id integer not null,
  pracownik_id integer not null,
  nr_faktury varchar2(20) not null,
  data_wystawienia timestamp default sysdate not null,
  data_platnosci timestamp default sysdate not null,
  czy_oplacona number(1) default 0 not null
);
/
alter table faktura add foreign key(zamowienie_id) references zamowienie(id);
alter table faktura add foreign key(klient_id) references klient(id);
alter table faktura add foreign key(pracownik_id) references pracownik(id);
/
create sequence faktura_sekwencja start with 1 increment by 1 nomaxvalue;
/
create trigger faktura_insert
before insert on faktura
for each row
begin
  select faktura_sekwencja.nextval into :new.id from dual;
end;
/
-- dodanie przykladowych rekordow
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
insert into adres(id,ulica,numer,kod,miejscowosc) values (1,'Brzeszczynskiego','4/4','11-200','Bartoszyce');
insert into adres(id,ulica,numer,kod,miejscowosc) values (2,'23 Marca','10','81-820','Sopot');
insert into adres(id,ulica,numer,kod,miejscowosc) values (3,'11 Listopada','95b','80-180','Gdansk');
insert into adres(id,ulica,numer,kod,miejscowosc) values (4,'Afrodyty','45','80-299','Gdansk');
insert into adres(id,ulica,numer,kod,miejscowosc) values (5,'Biologiczna','68/3','80-298','Gdansk');
insert into adres(id,ulica,numer,kod,miejscowosc) values (6,'Czajki','73a/3','80-680','Bartoszyce');
insert into adres(id,ulica,numer,kod,miejscowosc) values (7,'Architektow','22','81-528','Gdynia');
insert into adres(id,ulica,numer,kod,miejscowosc) values (8,'Dworcowa','44','81-362','Gdynia');
insert into adres(id,ulica,numer,kod,miejscowosc) values (9,'Pilsudkiego','55','11-200','Bartoszyce');
insert into adres(id,ulica,numer,kod,miejscowosc) values (10,'Bartoszycka','69/3','11-100','Lidzbark Warminski');
insert into adres(id,ulica,numer,kod,miejscowosc) values (11,'Zwyciestwa','92','11-040','Dobre Miasto');
insert into adres(id,ulica,numer,kod,miejscowosc) values (12,'Marianska','34','10-052','Olsztyn');
insert into adres(id,ulica,numer,kod,miejscowosc) values (13,'Pocztowa','65','11-400','Ketrzyn');
insert into adres(id,ulica,numer,kod,miejscowosc) values (14,'Piaskowa','2a/3','11-700','Mragowo');
insert into adres(id,ulica,numer,kod,miejscowosc) values (15,'Targowy Plac','44a','11-504','Gizycko');
insert into adres(id,ulica,numer,kod,miejscowosc) values (16,'Saperow','7','82-300','Elblag');
insert into adres(id,ulica,numer,kod,miejscowosc) values (17,'Niepodleglosci','32','83-000','Pruszcz Gdanski');
insert into adres(id,ulica,numer,kod,miejscowosc) values (18,'Aleja Zwyciestwa','3c/34','83-102','Tczew');
insert into adres(id,ulica,numer,kod,miejscowosc) values (19,'Grunwaldzka','63','81-759','Sopot');
insert into adres(id,ulica,numer,kod,miejscowosc) values (20,'Armii Krajowej','13','83-330','zukowo');
insert into adres(id,ulica,numer,kod,miejscowosc) values (21,'Jachtowa','2','80-680','Sobieszewo');
insert into adres(id,ulica,numer,kod,miejscowosc) values (22,'Marksa','4/10','11-200','Bartoszyce');
insert into adres(id,ulica,numer,kod,miejscowosc) values (23,'Kosciuszki','22a','14-104','Ostroda');
insert into adres(id,ulica,numer,kod,miejscowosc) values (24,'Zamkowa','2','13-100','Nidzica');
insert into adres(id,ulica,numer,kod,miejscowosc) values (25,'11 Listopada','7','14-300','Morag');
insert into adres(id,ulica,numer,kod,miejscowosc) values (26,'PCK','4','14-502','Braniewo');
insert into adres(id,ulica,numer,kod,miejscowosc) values (27,'Pilsudskiego','10','83-330','Kartuzy');
insert into adres(id,ulica,numer,kod,miejscowosc) values (28,'Wejherowska','4a/9','84-240','Reda');
insert into adres(id,ulica,numer,kod,miejscowosc) values (29,'Zawiszy Czarnego','7/4','14-104','Ostroda');
insert into adres(id,ulica,numer,kod,miejscowosc) values (30,'Modra','12','84-200','Wejherowo');
insert into adres(id,ulica,numer,kod,miejscowosc) values (31,'Marcinkowskiego','1','84-310','Lebork');
insert into adres(id,ulica,numer,kod,miejscowosc) values (32,'Portowa','5','76-200','Slupsk');
insert into adres(id,ulica,numer,kod,miejscowosc) values (33,'Mlynska','37','75-420','Koszalin');
insert into adres(id,ulica,numer,kod,miejscowosc) values (34,'Arkonska','4','71-455','Kartuzy');
insert into adres(id,ulica,numer,kod,miejscowosc) values (35,'Walowa','15','80-980','Kartuzy');
insert into adres(id,ulica,numer,kod,miejscowosc) values (36,'Wroblewskiego','17','14-300','Morag');
insert into adres(id,ulica,numer,kod,miejscowosc) values (37,'Wzgorze Wolnosci','3','83-300','Kartuzy');
insert into adres(id,ulica,numer,kod,miejscowosc) values (38,'Piwna','50/51','80-831','Gdansk');
insert into adres(id,ulica,numer,kod,miejscowosc) values (39,'Kolobrzeska','49','80-391','Gdansk');
insert into adres(id,ulica,numer,kod,miejscowosc) values (40,'Robotnicza','39','70-953','Szczecin');
insert into adres(id,ulica,numer,kod,miejscowosc) values (41,'Gnieznienska','8','75-736','Koszalin');
insert into adres(id,ulica,numer,kod,miejscowosc) values (42,'Sikorskiego','39','11-200','Bartoszyce');
insert into adres(id,ulica,numer,kod,miejscowosc) values (43,'23 Marca','8/13','81-820','Sopot');
insert into adres(id,ulica,numer,kod,miejscowosc) values (44,'Szeroka','1/1','80-800','Gdansk');
insert into adres(id,ulica,numer,kod,miejscowosc) values (45,'Nowomiejska','3/2','81-111','Torun');
insert into adres(id,ulica,numer,kod,miejscowosc) values (46,'Krakowskie Przedmiescia','121/1','00-120','Warszawa');
insert into adres(id,ulica,numer,kod,miejscowosc) values (47,'Main Lane','3/3','W5 6XJ','London');
insert into adres(id,ulica,numer,kod,miejscowosc) values (48,'Zelka','35','32-332','Bukowno');
insert into adres(id,ulica,numer,kod,miejscowosc) values (49,'Aleje Jerozolimskie','11','00-090','Warszawa');
insert into adres(id,ulica,numer,kod,miejscowosc) values (50,'Aleja Jana Pawla II','123/11','80-010','Gdansk');
insert into adres(id,ulica,numer,kod,miejscowosc) values (51,'Aleja Niepodlegosci','341/23','82-102','Sopot');
insert into adres(id,ulica,numer,kod,miejscowosc) values (52,'Batorego','11A/3','81-111','Gdansk');
insert into adres(id,ulica,numer,kod,miejscowosc) values (53,'Obroncow Wybrzeza','29A/5','82-222','Gdansk');
insert into adres(id,ulica,numer,kod,miejscowosc) values (54,'Marszalkowska','12','00-950','Warszawa');

insert into klient(id,adres_id,imie,nazwisko,pesel,telefon,email,haslo,rabat,data_dodania) values (1,10,'Jan','Drzewo','7824682853','587428964','jandrzewo@gmail.com','sadzonka',5,to_date('2018-05-15 08:00','YYYY-MM-DD HH24:MI'));
insert into klient(id,adres_id,imie,nazwisko,pesel,telefon,email,haslo,rabat,data_dodania) values (2,9,'Mateusz','Kowalski','7891234568','147963357','mateuszkowalski@gmail.com','kowal',5,to_date('2020-11-02 09:35','YYYY-MM-DD HH24:MI'));
insert into klient(id,adres_id,imie,nazwisko,pesel,telefon,email,haslo,rabat,data_dodania) values (3,8,'Franciszek','Tusk','7539518526','851964785','fracniszektusk@gmail.com','kaczynski',5,to_date('2020-06-22 14:35','YYYY-MM-DD HH24:MI'));
insert into klient(id,adres_id,imie,nazwisko,pesel,telefon,email,haslo,rabat,data_dodania) values (4,7,'lukasz','Podolski','7538462785','823657425','lukaszpodolski@gmail.com','goool',5,to_date('2019-09-06 18:25','YYYY-MM-DD HH24:MI'));
insert into klient(id,adres_id,imie,nazwisko,pesel,telefon,email,haslo,rabat,data_dodania) values (5,6,'Cristiano','Ronaldo','8369997578','692710158','cristianoronaldo@gmail.com','lubiezel',10,to_date('2019-02-02 12:25','YYYY-MM-DD HH24:MI'));
insert into klient(id,adres_id,imie,nazwisko,pesel,telefon,email,haslo,rabat,data_dodania) values (6,5,'Robert','Lewandowski','8796235425','134679825','robertlewandowski@gmail.com','niestrzelamdlapolski',10,to_date('2018-05-22 17:25','YYYY-MM-DD HH24:MI'));
insert into klient(id,adres_id,imie,nazwisko,pesel,telefon,email,haslo,rabat,data_dodania) values (7,4,'Adam','Malysz','5374029857','463280196','adammalysz@gmail.com','lubiewiatr',10,to_date('2020-03-10 11:02','YYYY-MM-DD HH24:MI'));
insert into klient(id,adres_id,imie,nazwisko,pesel,telefon,email,haslo,rabat,data_dodania) values (8,3,'Piotr','zyla','5750987461','490159426','piotrzyla@gmail.com','narty',10,to_date('2018-12-22 10:45','YYYY-MM-DD HH24:MI'));
insert into klient(id,adres_id,imie,nazwisko,pesel,telefon,email,haslo,rabat,data_dodania) values (9,2,'Bill','Gates','5648064816','380684523','billgates@gmail.com','haslo123',1,to_date('2018-12-06 11:18','YYYY-MM-DD HH24:MI'));
insert into klient(id,adres_id,imie,nazwisko,pesel,telefon,email,haslo,rabat,data_dodania) values (10,1,'Anna','Wrobel','5736984800','624004636','annawrobel@gmail.com','najpierwmasa',2,to_date('2018-07-23 12:11','YYYY-MM-DD HH24:MI'));
insert into klient(id,adres_id,imie,nazwisko,pesel,telefon,email,haslo,rabat,data_dodania) values (11,20,'Roman','Buk','1112233344','664623837','romanbuk@o2.pl','password',3,to_date('2018-01-01 00:00','YYYY-MM-DD HH24:MI'));
insert into klient(id,adres_id,imie,nazwisko,pesel,telefon,email,haslo,rabat,data_dodania) values (12,19,'Tomasz','Skowronek','2923744355','692431884','tomaszskowronek@o2.pl','password',0,to_date('2019-11-02 22:25','YYYY-MM-DD HH24:MI'));
insert into klient(id,adres_id,imie,nazwisko,pesel,telefon,email,haslo,rabat,data_dodania) values (13,18,'Krzysztof','Gonciarz','3734425506','730010121','krzysztofgonciarz@o2.pl','123456',0,to_date('2020-10-02 21:35','YYYY-MM-DD HH24:MI'));
insert into klient(id,adres_id,imie,nazwisko,pesel,telefon,email,haslo,rabat,data_dodania) values (14,17,'Robert','Zielinski','6570067138','503366813','robertzielinski@wp.pl','password!',1,to_date('2014-08-02 15:25','YYYY-MM-DD HH24:MI'));
insert into klient(id,adres_id,imie,nazwisko,pesel,telefon,email,haslo,rabat,data_dodania) values (15,16,'Grzegorz','Paszczak','8890977788','692710158','grzegorzpaszczak@wp.pl','secret',0,to_date('2018-09-02 16:25','YYYY-MM-DD HH24:MI'));
insert into klient(id,adres_id,imie,nazwisko,pesel,telefon,email,haslo,rabat,data_dodania) values (16,15,'Marek','Podolski','2295318645','586924587','marekpodolski@wp.pl','secret!!',0,to_date('2018-07-02 17:25','YYYY-MM-DD HH24:MI'));
insert into klient(id,adres_id,imie,nazwisko,pesel,telefon,email,haslo,rabat,data_dodania) values (17,14,'Filip','Kanciarz','6037194725','369258147','filipkanciarz@wp.pl','3wh36pb9',1,to_date('2018-05-02 21:45','YYYY-MM-DD HH24:MI'));
insert into klient(id,adres_id,imie,nazwisko,pesel,telefon,email,haslo,rabat,data_dodania) values (18,13,'Agata','Gmin','9163729103','123457896','agatagmin@gmail.com','n6gshct9',0,to_date('2018-03-02 21:55','YYYY-MM-DD HH24:MI'));
insert into klient(id,adres_id,imie,nazwisko,pesel,telefon,email,haslo,rabat,data_dodania) values (19,21,'Monika','Len','7412586322','753951654','monikalen@gmail.com','gh567hgj',0,to_date('2018-04-02 21:35','YYYY-MM-DD HH24:MI'));
insert into klient(id,adres_id,imie,nazwisko,pesel,telefon,email,haslo,rabat,data_dodania) values (20,22,'Aleksandra','Potocka','7539145688','456789123','aleksandrapotocka@gmail.com','xxxxx',1,to_date('2019-05-02 21:05','YYYY-MM-DD HH24:MI'));
insert into klient(id,adres_id,imie,nazwisko,pesel,telefon,email,haslo,rabat,data_dodania) values (21,12,'Karolina','Kanigowska','7437589122','888254986','karola123@gmail.com','qazrfv',2,to_date('2018-05-08 22:35','YYYY-MM-DD HH24:MI'));
insert into klient(id,adres_id,imie,nazwisko,pesel,telefon,email,haslo,rabat,data_dodania) values (22,11,'Tomasz','Radzewicz','7748021588','517534765','radzetom68@o2.pl','1qaz4rfv',3,to_date('2019-08-13 21:27','YYYY-MM-DD HH24:MI'));
insert into klient(id,adres_id,imie,nazwisko,pesel,telefon,email,haslo,rabat,data_dodania) values (23,52,'Juliusz','Machulski','71031201823','555333555','julius@o2.pl','123asd',3,to_date('2019-08-13 21:27','YYYY-MM-DD HH24:MI'));
insert into klient(id,adres_id,imie,nazwisko,pesel,telefon,email,haslo,rabat,data_dodania) values (24,53,'Kazimierz','Jagiellonczyk','22018005321','587210309','brak','qwe321',4,to_date('2019-08-13 21:27','YYYY-MM-DD HH24:MI'));

insert into kategoria(id,nazwa)values (1,'Obuwie');
insert into kategoria(id,nazwa)values (2,'Odziez');
insert into kategoria(id,nazwa)values (3,'Alkohole');
insert into kategoria(id,nazwa)values (4,'Artykuly szkolne');
insert into kategoria(id,nazwa)values (5,'Prasa');
insert into kategoria(id,nazwa)values (6,'Ksiazki');
insert into kategoria(id,nazwa)values (7,'Komputery');
insert into kategoria(id,nazwa)values (8,'Kosmetyki');
insert into kategoria(id,nazwa)values (9,'Ogrod');
insert into kategoria(id,nazwa)values (10,'Mieso');
insert into kategoria(id,nazwa)values (11,'Nabial');
insert into kategoria(id,nazwa)values (12,'Pieczywo');
insert into kategoria(id,nazwa)values (13,'Sprzet AGD');
insert into kategoria(id,nazwa)values (14,'Tyton');
insert into kategoria(id,nazwa)values (15,'Lekarstwa');
insert into kategoria(id,nazwa)values (16,'Meble');
insert into kategoria(id,nazwa)values (17,'Sztuka');
insert into kategoria(id,nazwa)values (18,'Warzywa');
insert into kategoria(id,nazwa)values (19,'Owoce');
insert into kategoria(id,nazwa)values (20,'Sprzet RTV');

insert into podkategoria(id,kategoria_id,nazwa) values (1,1,'Kapcie');
insert into podkategoria(id,kategoria_id,nazwa) values (2,1,'Sportowe');
insert into podkategoria(id,kategoria_id,nazwa) values (3,2,'Kurtki');
insert into podkategoria(id,kategoria_id,nazwa) values (4,2,'Spodnie');
insert into podkategoria(id,kategoria_id,nazwa) values (5,2,'Koszulki');
insert into podkategoria(id,kategoria_id,nazwa) values (6,3,'Whisky');
insert into podkategoria(id,kategoria_id,nazwa) values (7,3,'Wino');
insert into podkategoria(id,kategoria_id,nazwa) values (8,3,'Wodka');
insert into podkategoria(id,kategoria_id,nazwa) values (9,4,'Dlugopisy');
insert into podkategoria(id,kategoria_id,nazwa) values (10,4,'Zeszyty');
insert into podkategoria(id,kategoria_id,nazwa) values (11,5,'Tygodniki');
insert into podkategoria(id,kategoria_id,nazwa) values (12,5,'Miesieczniki');
insert into podkategoria(id,kategoria_id,nazwa) values (13,6,'Komiksy');
insert into podkategoria(id,kategoria_id,nazwa) values (14,6,'Przygodowe');
insert into podkategoria(id,kategoria_id,nazwa) values (15,6,'Horrory');
insert into podkategoria(id,kategoria_id,nazwa) values (16,7,'Laptopy');
insert into podkategoria(id,kategoria_id,nazwa) values (17,7,'Komputery stacjonarne');
insert into podkategoria(id,kategoria_id,nazwa) values (18,8,'Szminki');
insert into podkategoria(id,kategoria_id,nazwa) values (19,8,'Lakiery do paznokci');
insert into podkategoria(id,kategoria_id,nazwa) values (20,10,'Wieprzowina');
insert into podkategoria(id,kategoria_id,nazwa) values (21,10,'Drob');
insert into podkategoria(id,kategoria_id,nazwa) values (23,9,'Kwiaty');
insert into podkategoria(id,kategoria_id,nazwa) values (24,14,'Papierosy');
insert into podkategoria(id,kategoria_id,nazwa) values (25,8,'Perfumy');
insert into podkategoria(id,kategoria_id,nazwa) values (26,9,'Sprzet ogrodowy');
insert into podkategoria(id,kategoria_id,nazwa) values (27,12,'Bulki');
insert into podkategoria(id,kategoria_id,nazwa) values (28,11,'Jaja');
insert into podkategoria(id,kategoria_id,nazwa) values (29,14,'Cygara');
insert into podkategoria(id,kategoria_id,nazwa) values (30,15,'Przeciwbolowe');
insert into podkategoria(id,kategoria_id,nazwa) values (31,7,'Ram');
insert into podkategoria(id,kategoria_id,nazwa) values (32,16,'Krzesla');
insert into podkategoria(id,kategoria_id,nazwa) values (33,13,'Pralki');
insert into podkategoria(id,kategoria_id,nazwa) values (34,18,'Bulwiaste');
insert into podkategoria(id,kategoria_id,nazwa) values (35,17,'Obrazy');
insert into podkategoria(id,kategoria_id,nazwa) values (36,19,'Cytrusy');
insert into podkategoria(id,kategoria_id,nazwa) values (37,20,'Telewizory');
insert into podkategoria(id,kategoria_id,nazwa) values (38,20,'Radia');
insert into podkategoria(id,kategoria_id,nazwa) values (39,16,'Drzwi');
insert into podkategoria(id,kategoria_id,nazwa) values (40,16,'Stoly');

insert into producent(id,adres_id,nazwa) values (1,21,'Adidas');
insert into producent(id,adres_id,nazwa) values (2,22,'Diverse');
insert into producent(id,adres_id,nazwa) values (3,23,'Lee');
insert into producent(id,adres_id,nazwa) values (4,24,'Johny Walker');
insert into producent(id,adres_id,nazwa) values (5,25,'Nike');
insert into producent(id,adres_id,nazwa) values (6,26,'LM');
insert into producent(id,adres_id,nazwa) values (7,27,'Oxford');
insert into producent(id,adres_id,nazwa) values (8,28,'PC Format');
insert into producent(id,adres_id,nazwa) values (9,29,'Literkowy szal');
insert into producent(id,adres_id,nazwa) values (10,30,'Dell');
insert into producent(id,adres_id,nazwa) values (11,31,'Lacoste');
insert into producent(id,adres_id,nazwa) values (12,32,'Altrad');
insert into producent(id,adres_id,nazwa) values (13,33,'Mroz');
insert into producent(id,adres_id,nazwa) values (14,34,'Eko-Wital');
insert into producent(id,adres_id,nazwa) values (15,35,'Multico');
insert into producent(id,adres_id,nazwa) values (16,36,'Kiepenkerl');
insert into producent(id,adres_id,nazwa) values (17,37,'Bolivar');
insert into producent(id,adres_id,nazwa) values (18,38,'US Farmacja');
insert into producent(id,adres_id,nazwa) values (19,39,'Goodram');
insert into producent(id,adres_id,nazwa) values (20,40,'Grospol');
insert into producent(id,adres_id,nazwa) values (21,41,'Carlo Rossi');
insert into producent(id,adres_id,nazwa) values (22,42,'Astor');
insert into producent(id,adres_id,nazwa) values (23,44,'Absolwent');
insert into producent(id,adres_id,nazwa) values (24,43,'BIC');
insert into producent(id,adres_id,nazwa) values (25,45,'Lenovo');
insert into producent(id,adres_id,nazwa) values (26,46,'Essie');
insert into producent(id,adres_id,nazwa) values (27,47,'Oficyna Naukowa');
insert into producent(id,adres_id,nazwa) values (28,48,'Bosch');
insert into producent(id,adres_id,nazwa) values (29,49,'Jan Matejko Company');
insert into producent(id,adres_id,nazwa) values (30,52,'ABC AGD');

insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(1,1,2,'F5 TRX FG','Pilkarskie korki',229,23,1000);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(2,2,3,'Kurtka Rastrum Ir','Ciepla zimowa kurtka',480,23,50);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(3,3,4,'Lynn Skinny','Dopasowane spodnie jeansowe',259,23,9100);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(4,4,6,'Black Label','Najlepsza 12-nasto letnia whisky',67,23,1250);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(5,5,2,'Dual Fusion','Buty do biegania',269,23,1000);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(6,6,24,'Link Menthol','Delikatne mentolowe',12.90,23,2110);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(7,7,10,'Zeszyt w linie','60 kartkowy',3,8,10000);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(8,8,12,'Czasopismo komputerowe','Najnowsze wydanie',5.99,8,100);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(9,9,13,'Komiks o Kaczor Donald','Lakierowane strony',19,8,1150);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(10,10,16,'Dell Latitude','i7-4900MQ AMD RADEON HD 8790M',6690,23,80);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(11,11,25,'Elegance','Dla mezczyzn',169,23,150);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(12,12,26,'Taczka stalowa spawana','wytrzymala',199,23,110);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(13,13,20,'Karkowka bez kosci','1kg',15.90,8,110);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(14,14,28,'Jaja swieze','BIO',11,8,1000);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(15,5,27,'Kajzerka','Dzisiejsza',1,8,250);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(16,16,23,'Pelargonia cytrynowa','Balkonowa',7,23,650);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(17,17,29,'Cygara kubanskie','Oryginalne',45,23,950);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(18,18,30,'Ibuprom','Tabletki na bol glowy',10,23,2018);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(19,19,31,'RAM','1024MB 1333MHz CL9',46,23,50);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(20,20,32,'Fotel Opimal','Gwarancja 3 lata',280,23,80);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(21,21,7,'Wino','Polwytrawne rozowe',23,23,520);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(22,22,18,'Szminka','VIP Heidi Klu',29,23,820);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(23,23,8,'Wodka Absolwent','0.7l',32,23,111);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(24,24,9,'Dlugopis czarny','8cm',1,23,1000);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(25,25,17,'Lenovo H520','500GB HDD, Intel Celeron Dual-Core G1610',800,23,32);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(26,26,19,'Essie Madison Ave-Hue no. 821','Kolor z najnowszej kolekcji Spring 2020.',9,23,121);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(27,27,14,'Winnetou','Tom 1',16,23,10);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(28,27,15,'Carrie','Pierwsza powazna powiesc autora.',18,23,20);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(29,13,21,'Skrzydelka','1kg',7,23,30);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(30,13,21,'Piers','1kg',13,23,20);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(31,2,5,'T-Shirt I am God','zielony z bialym napisem',33,23,9);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(32,8,11,'Tygodnik Komputerowy','Najnowsze wydanie',4,23,99);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(33,28,33,'Bosch KX1120','Beben 5kg',1300,23,5);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(34,14,34,'Ziemniak','1kg',1,23,105);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(35,29,35,'NUMBER(1)wa pod Grunwaldem','Mistrzowska kopia!',5000,8,1);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(36,28,37,'Telewizor 37 cali','LED',1200,23,40);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(37,14,36,'Pomarancza','1kg',3,23,200);
insert into produkt(id,producent_id,podkategoria_id,nazwa,opis,cena_netto,podatek,ilosc_sztuk_magazyn) values(38,2,1,'Kapcie z welny owczej','100% naturalnej welny',18,23,50);

insert into pracownik(id,adres_id,imie,nazwisko,data_zatrudnienia,pensja,dodatek,stanowisko) values (1,31,'Adam','Baran',to_date('2018-09-07','yyyy-mm-dd'),4000,200,'sprzedawca');
insert into pracownik(id,adres_id,imie,nazwisko,data_zatrudnienia,pensja,dodatek,stanowisko) values (2,32,'Karol','Walentynowicz',to_date('2018-01-03','yyyy-mm-dd'),5000,null,'kierownik');
insert into pracownik(id,adres_id,imie,nazwisko,data_zatrudnienia,pensja,dodatek,stanowisko) values (3,33,'Maciej','Piast',to_date('2018-11-11','yyyy-mm-dd'),6000,100,'sprzedawca');
insert into pracownik(id,adres_id,imie,nazwisko,data_zatrudnienia,pensja,dodatek,stanowisko) values (4,34,'Sebastian','Sowa',to_date('2018-05-12','yyyy-mm-dd'),3500,null,'manager');
insert into pracownik(id,adres_id,imie,nazwisko,data_zatrudnienia,pensja,dodatek,stanowisko) values (5,35,'Piotr','Filipek',to_date('2018-10-11','yyyy-mm-dd'),3500,300,'sprzedawca');
insert into pracownik(id,adres_id,imie,nazwisko,data_zatrudnienia,pensja,dodatek,stanowisko) values (6,36,'Szymon','Kaczmarek',to_date('2019-03-10','yyyy-mm-dd'),4100,50,'ksiegowy');
insert into pracownik(id,adres_id,imie,nazwisko,data_zatrudnienia,pensja,dodatek,stanowisko) values (7,37,'Jaroslaw','Nadolski',to_date('2020-04-04','yyyy-mm-dd'),2900,null,'sprzedawca');
insert into pracownik(id,adres_id,imie,nazwisko,data_zatrudnienia,pensja,dodatek,stanowisko) values (8,38,'Dawid','Mach',to_date('2019-08-09','yyyy-mm-dd'),2600,300,'ksiegowy');
insert into pracownik(id,adres_id,imie,nazwisko,data_zatrudnienia,pensja,dodatek,stanowisko) values (9,39,'Darek','Bizewski',to_date('2018-09-01','yyyy-mm-dd'),3800,500,'sprzedawca');
insert into pracownik(id,adres_id,imie,nazwisko,data_zatrudnienia,pensja,dodatek,stanowisko) values (10,40,'Patryk','Lachs',to_date('2018-03-04','yyyy-mm-dd'),9000,null,'dyrektor');
insert into pracownik(id,adres_id,imie,nazwisko,data_zatrudnienia,pensja,dodatek,stanowisko)values (11,41,'Mariusz','Marzec',to_date('2019-02-12','yyyy-mm-dd'),4000,200,'sprzedawca');
insert into pracownik(id,adres_id,imie,nazwisko,data_zatrudnienia,pensja,dodatek,stanowisko)values (12,42,'Robert','Marciniak',to_date('2018-10-08','yyyy-mm-dd'),8500,500,'kierownik');
insert into pracownik(id,adres_id,imie,nazwisko,data_zatrudnienia,pensja,dodatek,stanowisko)values (13,50,'Jan','Dlugobrody',to_date('2020-01-12','yyyy-mm-dd'),4200,null,'manager');
insert into pracownik(id,adres_id,imie,nazwisko,data_zatrudnienia,pensja,dodatek,stanowisko)values (14,51,'Julia','Kowalska',to_date('2020-08-11','yyyy-mm-dd'),3400,100,'manager');

insert into zamowienie(id,pracownik_id,klient_id,data_zamowienia,cena_netto_dostawy,podatek) values (1,1,10,to_date('2018-03-06 11:35','yyyy-mm-dd hh24:mi'),100,23);
insert into zamowienie(id,pracownik_id,klient_id,data_zamowienia,cena_netto_dostawy,podatek) values (2,2,9,to_date('2018-12-17 13:23','yyyy-mm-dd hh24:mi'),100,23);
insert into zamowienie(id,pracownik_id,klient_id,data_zamowienia,cena_netto_dostawy,podatek) values (3,3,8,to_date('2019-03-12 12:15','yyyy-mm-dd hh24:mi'),100,23);
insert into zamowienie(id,pracownik_id,klient_id,data_zamowienia,cena_netto_dostawy,podatek) values (4,4,7,to_date('2019-04-17 09:56','yyyy-mm-dd hh24:mi'),100,23);
insert into zamowienie(id,pracownik_id,klient_id,data_zamowienia,cena_netto_dostawy,podatek) values (5,6,5,to_date('2019-07-10 10:45','yyyy-mm-dd hh24:mi'),100,23);
insert into zamowienie(id,pracownik_id,klient_id,data_zamowienia,cena_netto_dostawy,podatek) values (6,6,5,to_date('2019-09-01 08:38','yyyy-mm-dd hh24:mi'),100,23);
insert into zamowienie(id,pracownik_id,klient_id,data_zamowienia,cena_netto_dostawy,podatek) values (7,6,4,to_date('2019-11-12 09:56','yyyy-mm-dd hh24:mi'),100,23);
insert into zamowienie(id,pracownik_id,klient_id,data_zamowienia,cena_netto_dostawy,podatek) values (8,8,3,to_date('2019-11-14 11:54','yyyy-mm-dd hh24:mi'),100,23);
insert into zamowienie(id,pracownik_id,klient_id,data_zamowienia,cena_netto_dostawy,podatek) values (9,9,2,to_date('2019-11-16 13:59','yyyy-mm-dd hh24:mi'),100,23);
insert into zamowienie(id,pracownik_id,klient_id,data_zamowienia,cena_netto_dostawy,podatek) values (10,10,1,to_date('2020-02-14 10:16','yyyy-mm-dd hh24:mi'),100,23);
insert into zamowienie(id,pracownik_id,klient_id,data_zamowienia,cena_netto_dostawy,podatek) values (11,1,10,to_date('2020-02-16 09:35','yyyy-mm-dd hh24:mi'),100,23);
insert into zamowienie(id,pracownik_id,klient_id,data_zamowienia,cena_netto_dostawy,podatek) values (12,2,9,to_date('2020-03-14 08:55','yyyy-mm-dd hh24:mi'),100,23);
insert into zamowienie(id,pracownik_id,klient_id,data_zamowienia,cena_netto_dostawy,podatek) values (13,3,2,to_date('2020-03-19 12:45','yyyy-mm-dd hh24:mi'),100,23);
insert into zamowienie(id,pracownik_id,klient_id,data_zamowienia,cena_netto_dostawy,podatek) values (14,4,7,to_date('2020-04-08 07:25','yyyy-mm-dd hh24:mi'),100,23);
insert into zamowienie(id,pracownik_id,klient_id,data_zamowienia,cena_netto_dostawy,podatek) values (15,5,6,to_date('2020-05-22 10:35','yyyy-mm-dd hh24:mi'),100,23);
insert into zamowienie(id,pracownik_id,klient_id,data_zamowienia,cena_netto_dostawy,podatek) values (16,5,5,to_date('2020-06-01 12:25','yyyy-mm-dd hh24:mi'),100,23);
insert into zamowienie(id,pracownik_id,klient_id,data_zamowienia,cena_netto_dostawy,podatek) values (17,5,4,to_date('2020-07-26 11:25','yyyy-mm-dd hh24:mi'),60,23);
insert into zamowienie(id,pracownik_id,klient_id,data_zamowienia,cena_netto_dostawy,podatek) values (18,6,5,to_date('2020-08-17 09:25','yyyy-mm-dd hh24:mi'),10,23);
insert into zamowienie(id,pracownik_id,klient_id,data_zamowienia,cena_netto_dostawy,podatek) values (19,9,2,to_date('2020-09-02 08:25','yyyy-mm-dd hh24:mi'),70,23);
insert into zamowienie(id,pracownik_id,klient_id,data_zamowienia,cena_netto_dostawy,podatek) values (20,10,2,to_date('2019-05-02 11:05','yyyy-mm-dd hh24:mi'),60,23);
insert into zamowienie(id,pracownik_id,klient_id,data_zamowienia,cena_netto_dostawy,podatek) values (21,5,19,to_date('2020-11-23 12:05','yyyy-mm-dd hh24:mi'),40,23);
insert into zamowienie(id,pracownik_id,klient_id,data_zamowienia,cena_netto_dostawy,podatek) values (22,12,20,to_date('2019-10-08 13:45','yyyy-mm-dd hh24:mi'),70,23);
insert into zamowienie(id,pracownik_id,klient_id,data_zamowienia,cena_netto_dostawy,podatek) values (23,13,23,to_date('2020-09-11 11:05','yyyy-mm-dd hh24:mi'),50,23);
insert into zamowienie(id,pracownik_id,klient_id,data_zamowienia,cena_netto_dostawy,podatek) values (24,14,24,to_date('2020-10-11 16:45','yyyy-mm-dd hh24:mi'),50,23);
insert into zamowienie(id,pracownik_id,klient_id,data_zamowienia,cena_netto_dostawy,podatek) values (25,14,24,to_date('2020-10-12 16:46','yyyy-mm-dd hh24:mi'),50,123);

insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (1,1,229,23,1100);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (1,38,18,23,1);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (1,2,480,23,4);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (1,7,3,23,10);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (1,4,67,23,2);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (2,5,269,23,13);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (2,6,12.90,23,3);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (3,7,3,8,4);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (3,8,5.99,8,2);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (3,23,32,23,2);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (4,9,19,8,1);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (4,10,6690,23,1);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (4,11,169,23,1);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (5,12,199,23,1);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (5,13,15.90,8,2);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (5,14,11,8,20);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (5,15,1,8,5);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (5,16,7,23,1);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (6,16,7,23,1);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (6,24,1,23,10);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (7,17,45,23,6);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (8,18,10,23,2);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (9,19,46,23,1);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (9,20,280,23,4);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (9,1,229,23,11);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (10,2,480,23,4);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (10,3,259,23,100);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (10,4,67,23,2018);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (10,5,269,23,1000);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (11,6,12.90,23,300);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (11,7,3,8,4);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (12,8,5.99,8,2);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (12,9,19,8,10);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (12,10,6690,23,2);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (13,11,169,23,11);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (13,12,199,8,4);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (13,13,15.9,8,10);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (13,14,11,8,2);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (14,15,1,8,13);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (14,16,7,23,3);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (14,17,45,23,4);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (15,18,10,23,2);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (15,19,46,23,1);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (16,20,280,23,4);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (16,1,229,23,1);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (16,2,480,23,1);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (17,3,259,23,2);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (18,4,67,23,20);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (19,5,269,23,5);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (20,6,12.90,23,1);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (20,7,3,8,6);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (20,8,5.99,8,2);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (20,9,19,8,1);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (20,10,6690,23,2);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (21,21,23,13,1);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (22,22,29,23,2);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (9,25,800,23,1);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (22,26,9,23,3);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (12,27,16,23,1);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (12,28,18,23,1);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (5,29,7,23,2);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (5,30,13,23,1);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (10,31,33,23,1);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (3,32,4,23,1);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (20,33,1300,23,1);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (13,34,1,23,20);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (18,35,5000,8,1);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (23,1,229,23,1);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (24,3,259,23,1);
insert into koszyk(zamowienie_id,produkt_id,cena_netto,podatek,ilosc_sztuk) values (25,3,259,23,1);

insert into status(id,nazwa,opis) values ('1','zlozenie zamowienia','zamowienie zostalo zlozone');
insert into status(id,nazwa,opis) values ('2','oczekiwanie na zaplate','oczekiwanie na zaplate klienta');
insert into status(id,nazwa,opis) values ('3','otrzymano zaplate','zaplata zostala przyjeta');
insert into status(id,nazwa,opis) values ('4','przygotowanie przesylki','towar zostaje przygotowywany do wysylki');
insert into status(id,nazwa,opis) values ('5','wyslanie przesylki','towar zostal wyslany');
insert into status(id,nazwa,opis) values ('6','dostarczenie przesylki','przesylka zostala dostarczona');
insert into status(id,nazwa,opis) values ('7','zagubienie przesylki','przesylka zostala zgubiona');
insert into status(id,nazwa,opis) values ('8','odeslanie przesylki','klient nie przyjal przesylki');
insert into status(id,nazwa,opis) values ('9','uszkodzenie przesylki','przesylka zostala uszkodzona');

insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (1,1,to_date('2018-03-07 11:35','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (1,2,to_date('2018-03-08 12:55','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (1,3,to_date('2018-03-09 13:45','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (1,4,to_date('2018-03-10 16:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (1,5,to_date('2018-03-11 09:45','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (1,6,to_date('2018-03-12 16:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (1,8,to_date('2018-12-23 16:25','yyyy-mm-dd hh24:mi'),'Klient twierdzi, ze nie skladal zamowienia.');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (2,1,to_date('2018-12-17 21:35','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (2,2,to_date('2018-12-18 22:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (2,3,to_date('2018-12-19 16:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (2,4,to_date('2018-12-20 16:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (2,5,to_date('2018-12-21 16:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (2,6,to_date('2018-12-22 16:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (2,8,to_date('2018-12-23 16:25','yyyy-mm-dd hh24:mi'),'Klient twierdzi, ze nie skladal zamowienia.');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (3,1,to_date('2019-03-12 17:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (3,2,to_date('2019-03-14 17:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (3,3,to_date('2019-03-15 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (3,4,to_date('2019-03-17 21:35','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (3,5,to_date('2019-03-19 21:35','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (3,6,to_date('2019-03-23 21:35','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (4,1,to_date('2019-04-17 21:55','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (4,2,to_date('2019-04-18 21:45','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (4,3,to_date('2019-04-19 16:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (4,4,to_date('2019-04-21 16:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (4,5,to_date('2019-04-22 16:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (4,6,to_date('2019-04-23 16:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (5,1,to_date('2019-07-10 21:35','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (5,2,to_date('2019-07-13 22:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (5,3,to_date('2019-07-14 22:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (5,4,to_date('2019-07-15 22:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (5,5,to_date('2019-07-17 22:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (5,6,to_date('2019-07-19 22:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (6,1,to_date('2019-09-01 16:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (6,2,to_date('2019-09-03 16:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (6,3,to_date('2019-09-06 16:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (6,4,to_date('2019-09-08 16:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (6,5,to_date('2019-09-09 16:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (6,6,to_date('2019-09-13 16:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (7,1,to_date('2019-11-12 17:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (7,2,to_date('2019-11-14 17:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (7,3,to_date('2019-11-16 17:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (7,4,to_date('2019-11-18 17:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (7,5,to_date('2019-11-19 17:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (7,6,to_date('2019-11-23 17:25','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (8,1,to_date('2019-11-14 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (8,2,to_date('2019-11-15 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (8,3,to_date('2019-11-16 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (8,4,to_date('2019-11-17 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (8,5,to_date('2019-11-18 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (8,6,to_date('2019-11-19 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (9,1,to_date('2019-11-16 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (9,2,to_date('2019-11-17 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (9,3,to_date('2019-11-19 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (9,4,to_date('2019-11-20 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (9,5,to_date('2019-11-22 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (9,6,to_date('2019-11-24 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (10,1,to_date('2020-02-14 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (10,2,to_date('2020-02-15 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (10,3,to_date('2020-02-16 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (10,4,to_date('2020-02-17 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (10,5,to_date('2020-02-18 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (10,6,to_date('2020-02-19 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (11,1,to_date('2020-02-16 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (11,2,to_date('2020-02-17 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (11,3,to_date('2020-02-18 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (11,4,to_date('2020-02-19 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (11,5,to_date('2020-02-22 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (12,1,to_date('2020-03-14 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (12,2,to_date('2020-03-18 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (12,3,to_date('2020-03-24 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (12,4,to_date('2020-03-26 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (13,1,to_date('2020-03-19 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (13,2,to_date('2020-03-25 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (13,3,to_date('2020-03-28 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (14,1,to_date('2020-04-08 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (14,2,to_date('2020-04-09 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (14,3,to_date('2020-04-11 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (15,1,to_date('2020-05-22 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (15,2,to_date('2020-05-26 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (16,1,to_date('2020-06-01 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (16,2,to_date('2020-06-02 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (17,1,to_date('2020-07-26 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (17,2,to_date('2020-07-29 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (18,1,to_date('2020-08-17 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (19,1,to_date('2020-09-02 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (20,1,to_date('2020-05-03 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (21,1,to_date('2020-11-23 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (22,1,to_date('2020-10-09 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (22,2,to_date('2020-10-10 21:05','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (22,3,to_date('2020-10-12 11:11','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (23,1,to_date('2020-09-11 11:11','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (23,2,to_date('2020-09-12 12:11','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (23,3,to_date('2020-09-13 13:11','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (23,4,to_date('2020-09-14 14:11','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (23,5,to_date('2020-09-15 15:11','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (23,6,to_date('2020-09-16 16:11','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (24,1,to_date('2020-10-11 17:11','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (24,2,to_date('2020-10-12 12:11','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (24,3,to_date('2020-10-13 17:13','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (24,4,to_date('2020-10-14 12:22','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (24,5,to_date('2020-10-15 13:31','yyyy-mm-dd hh24:mi'),'brak');
insert into zamowienie_status(zamowienie_id,status_id,data_zmiany_statusu,uwagi) values (24,9,to_date('2020-10-16 09:22','yyyy-mm-dd hh24:mi'),'brak');

insert into faktura(id,zamowienie_id,klient_id,pracownik_id,nr_faktury,data_wystawienia,data_platnosci,czy_oplacona) values (1,1,1,1,'01',to_date('2018-06-23 12:12','yyyy-mm-dd hh24:mi'),to_date('2018-06-30 22:32','yyyy-mm-dd hh24:mi'),1);
insert into faktura(id,zamowienie_id,klient_id,pracownik_id,nr_faktury,data_wystawienia,data_platnosci,czy_oplacona) values (2,2,2,2,'01',to_date('2020-08-08 22:54','yyyy-mm-dd hh24:mi'),to_date('2020-08-10 13:00','yyyy-mm-dd hh24:mi'),1);
insert into faktura(id,zamowienie_id,klient_id,pracownik_id,nr_faktury,data_wystawienia,data_platnosci,czy_oplacona) values (3,3,3,3,'03',to_date('2019-07-14 10:22','yyyy-mm-dd hh24:mi'),to_date('2019-07-16 04:01','yyyy-mm-dd hh24:mi'),0);
insert into faktura(id,zamowienie_id,klient_id,pracownik_id,nr_faktury,data_wystawienia,data_platnosci,czy_oplacona) values (4,4,4,4,'04',to_date('2018-12-12 12:37','yyyy-mm-dd hh24:mi'),to_date('2018-12-14 08:08','yyyy-mm-dd hh24:mi'),1);
insert into faktura(id,zamowienie_id,klient_id,pracownik_id,nr_faktury,data_wystawienia,data_platnosci,czy_oplacona) values (5,5,5,5,'05',to_date('2018-10-01 14:15','yyyy-mm-dd hh24:mi'),to_date('2018-10-04 09:22','yyyy-mm-dd hh24:mi'),1);
insert into faktura(id,zamowienie_id,klient_id,pracownik_id,nr_faktury,data_wystawienia,data_platnosci,czy_oplacona) values (6,6,6,6,'66',to_date('2018-01-31 22:15','yyyy-mm-dd hh24:mi'),to_date('2018-02-05 22:34','yyyy-mm-dd hh24:mi'),0);
insert into faktura(id,zamowienie_id,klient_id,pracownik_id,nr_faktury,data_wystawienia,data_platnosci,czy_oplacona) values (7,7,7,7,'07',to_date('2018-10-21 16:08','yyyy-mm-dd hh24:mi'),to_date('2018-10-29 14:56','yyyy-mm-dd hh24:mi'),1);
insert into faktura(id,zamowienie_id,klient_id,pracownik_id,nr_faktury,data_wystawienia,data_platnosci,czy_oplacona) values (8,8,8,8,'08',to_date('2018-02-21 17:19','yyyy-mm-dd hh24:mi'),to_date('2018-03-31 13:12','yyyy-mm-dd hh24:mi'),1);
insert into faktura(id,zamowienie_id,klient_id,pracownik_id,nr_faktury,data_wystawienia,data_platnosci,czy_oplacona) values (9,9,9,9,'09',to_date('2018-04-17 17:01','yyyy-mm-dd hh24:mi'),to_date('2018-04-18 11:09','yyyy-mm-dd hh24:mi'),1);
insert into faktura(id,zamowienie_id,klient_id,pracownik_id,nr_faktury,data_wystawienia,data_platnosci,czy_oplacona) values (10,10,10,10,'110',to_date('2018-05-02 07:55','yyyy-mm-dd hh24:mi'),to_date('2018-05-11 21:15','yyyy-mm-dd hh24:mi'),0);
insert into faktura(id,zamowienie_id,klient_id,pracownik_id,nr_faktury,data_wystawienia,data_platnosci,czy_oplacona) values (11,11,19,11,'111',to_date('2018-11-08 13:21','yyyy-mm-dd hh24:mi'),to_date('2018-11-18 21:39','yyyy-mm-dd hh24:mi'),1);
insert into faktura(id,zamowienie_id,klient_id,pracownik_id,nr_faktury,data_wystawienia,data_platnosci,czy_oplacona) values (12,12,20,12,'112',to_date('2018-12-09 17:35','yyyy-mm-dd hh24:mi'),to_date('2018-12-11 20:05','yyyy-mm-dd hh24:mi'),0);
insert into faktura(id,zamowienie_id,klient_id,pracownik_id,nr_faktury,data_wystawienia,data_platnosci,czy_oplacona) values (13,23,23,13,'12/2020',to_date('2020-09-09 13:21','yyyy-mm-dd hh24:mi'),to_date('2020-09-10 21:39','yyyy-mm-dd hh24:mi'),1);
insert into faktura(id,zamowienie_id,klient_id,pracownik_id,nr_faktury,data_wystawienia,data_platnosci,czy_oplacona) values (14,10,1,10,'03/2020',to_date('2020-02-14 17:35','yyyy-mm-dd hh24:mi'),to_date('2020-02-15 20:05','yyyy-mm-dd hh24:mi'),1);

-- podwyzka cen wybranych produktow
update produkt set cena_netto=cena_netto*1.1 where ilosc_sztuk_magazyn<100;

-- wyswietlenie ilosci dodanych rekordow
select 
  (select count(*) from adres) as "adres",
  (select count(*) from klient) as "klient",
  (select count(*) from pracownik) as "pracownik",
  (select count(*) from kategoria) as "kategoria",
  (select count(*) from podkategoria) as "podkategoria",
  (select count(*) from producent) as "producent",
  (select count(*) from produkt) as "produkt"
from dual;
select 
  (select count(*) from status) as "status",
  (select count(*) from zamowienie) as "zamowienie",
  (select count(*) from zamowienie_status) as "zamowienie_status",
  (select count(*) from koszyk) as "koszyk",
  (select count(*) from faktura) as "faktura"
from dual;


select * from adres;
select * from faktura;
select * from kategoria;
select * from klient;
select * from koszyk;
select * from podkategoria;
select * from pracownik;
select * from producent;
select * from produkt;
select * from status;
select * from zamowienie;
select * from zamowienie_status;

select MIN(cena_netto_dostawy) as "Najmniejsza cena netto dostawy" 
from zamowienie;

select trunc(STDDEV(rabat) as "odchylenie standardowe rabatu" 
from klient ;

select trunc(AVG(sum(cena_netto)),2) as "srednia z sumy ceny netto" 
from produkt 
group by ilosc_sztuk_magazyn 
order by id ;

select stanowisko, count(*) as "liczba stanowisk" 
from pracownik 
group by stanowisko 
order by "liczba stanowisk" desc;

select sum(cena_netto) as "suma cen netto w koszyku" 
from koszyk  
group by ilosc_sztuk 
having sum(cena_netto)>10
order by "suma cen netto w koszyku" asc;

select trunc (VARIANCE (cena_netto),2) as "wariancja ceny netto", 
trunc(STDDEV(cena_netto),2) as "odchylenie stand ceny netto"  
from koszyk 
group by ilosc_sztuk 
having VARIANCE (cena_netto)> 500
order by STDDEV(cena_netto) desc;

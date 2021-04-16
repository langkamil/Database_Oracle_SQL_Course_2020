select * from "176553_kategoria"order by id;
select * from "176553_klient" order by id;
select * from "176553_pracownik"order by id;
select * from "176553_pozycje";
select * from "176553_wypozyczenie"order by id;
select * from "176553_sprzet"order by id;
select * from "176553_naprawa"order by id;
select * from "176553_stanowisko"order by id;
select * from "176553_producent"order by id;
select * from "176553_klasyfikacja";


INSERT INTO "176553_klient" (id, imie, nazwisko, telefon, email, rabat, ulica, numer, kod, miasto) VALUES (1, 'Michal', 'Blok', '123456789', 'michalblock@wp.pl', 2, 'Kolorowa', '2', '83-123', 'Luban');
INSERT INTO "176553_klient" (id, imie, nazwisko, telefon, email, rabat, ulica, numer, kod, miasto) VALUES (2, 'Jakub', 'Hinc', '111111111', 'jakubhinc@wp.pl', 4, 'Szkolna', '7', '23-132', 'Kartuzy');
INSERT INTO "176553_klient" (id, imie, nazwisko, telefon, email, rabat, ulica, numer, kod, miasto) VALUES (3, 'Marlena', 'Bobrowska', '323232121', 'marlenabobr@o2.pl', 1, 'Cicha', '24', '42-532', 'Lublin');
INSERT INTO "176553_klient" (id, imie, nazwisko, telefon, email, rabat, ulica, numer, kod, miasto) VALUES (4, 'Adriana', 'Boczek', '122121121', 'adrianaboczek@gmail.com', 0, 'Wiejska', '87', '22-909','Krakow');
INSERT INTO "176553_klient" (id, imie, nazwisko, telefon, email, rabat, ulica, numer, kod, miasto) VALUES (5, 'Anna', 'Rubik', '345980765', 'annarubik@gmail.com', 0, 'Sokratesa', '43', '83-400', 'Koscierzyna');
INSERT INTO "176553_klient" (id, imie, nazwisko, telefon, email, rabat, ulica, numer, kod, miasto) VALUES (6, 'Jerzy', 'Walaszek', '216543985', 'jerzwal@o2.pl', 8, 'Czaplowa' , '85', '32-643', 'Mieszkowice');
INSERT INTO "176553_klient" (id, imie, nazwisko, telefon, email, rabat, ulica, numer, kod, miasto) VALUES (7, 'Grzegorz', 'Rabin', '222666444', 'grzerabin@wp.pl', 7, 'Srebrna', '75', '53-854', 'Piechowice');
INSERT INTO "176553_klient" (id, imie, nazwisko, telefon, email, rabat, ulica, numer, kod, miasto) VALUES (8, 'Alina', 'Grzyb', '665234978', 'alinagrzyb@o2.pl', 0, 'Robocza', '35', '65-214', 'Konstantynopol');
INSERT INTO "176553_klient" (id, imie, nazwisko, telefon, email, rabat, ulica, numer, kod, miasto) VALUES (9, 'Agata', 'Pawlak', '235786564' , 'agatapawlak@wp.pl', 4, 'Orla', '3', '51-632', 'Ornata');
INSERT INTO "176553_klient" (id, imie, nazwisko, telefon, email, rabat, ulica, numer, kod, miasto) VALUES (10, 'Lech', 'Roch', '562875354', 'lechroch@wp.pl', 2, 'Diademowa', '67', '78-564', 'Brzeg');


INSERT INTO "176553_pracownik" (id, imie, nazwisko, "176553_stanowisko_id") VALUES (1, 'Jerzy', 'Gleba', 1);
INSERT INTO "176553_pracownik" (id, imie, nazwisko, "176553_stanowisko_id") VALUES (2, 'Adam', 'Szmit', 1);
INSERT INTO "176553_pracownik" (id, imie, nazwisko, "176553_stanowisko_id") VALUES (3, 'Anna', 'Rola', 2);
INSERT INTO "176553_pracownik" (id, imie, nazwisko, "176553_stanowisko_id") VALUES (4, 'Krystyna', 'Ropa', 1);
INSERT INTO "176553_pracownik" (id, imie, nazwisko, "176553_stanowisko_id") VALUES (5, 'Walerian', 'Kos', 3);
INSERT INTO "176553_pracownik" (id, imie, nazwisko, "176553_stanowisko_id") VALUES (6, 'Joanna', 'Dobra', 3);
INSERT INTO "176553_pracownik" (id, imie, nazwisko, "176553_stanowisko_id") VALUES (7, 'Damian', 'Rok', 4);
INSERT INTO "176553_pracownik" (id, imie, nazwisko, "176553_stanowisko_id") VALUES (8, 'Artur', 'Konan', 3);
INSERT INTO "176553_pracownik" (id, imie, nazwisko, "176553_stanowisko_id") VALUES (9, 'Szymon', 'Brew', 2);
INSERT INTO "176553_pracownik" (id, imie, nazwisko, "176553_stanowisko_id") VALUES (10, 'Robert', 'Rak', 1);

INSERT INTO "176553_producent" (id, nazwa, telefon, ulica, numer, kod, miasto) VALUES (3, 'Robus', '456435980', 'Jasna', '4b','43-432', 'Rybaki');
INSERT INTO "176553_producent" (id, nazwa, telefon, ulica, numer, kod, miasto) VALUES (4, 'Bemax', '672541635', 'Wojenna', '19','72-563', 'Cyna');


INSERT INTO "176553_sprzet" (id, nazwa, opis, nr_inwentarzony, cena_dzien, cena_godzina, dostepnosc, "176553_producent_id") VALUES (1,'kajak', 'dwuosobowy','32fs', 50, 10,'N', 3);
INSERT INTO "176553_sprzet" (id, nazwa, opis, nr_inwentarzony, cena_dzien, cena_godzina, dostepnosc, "176553_producent_id") VALUES (5,'plywaczki',NULL,'3rw0s', 20, 5,'T', 2);
INSERT INTO "176553_sprzet" (id, nazwa, opis, nr_inwentarzony, cena_dzien, cena_godzina, dostepnosc, "176553_producent_id") VALUES (6,'pletwy', null,'ew2s',  15,5,'N', 3);
INSERT INTO "176553_sprzet" (id, nazwa, opis, nr_inwentarzony, cena_dzien, cena_godzina, dostepnosc, "176553_producent_id") VALUES (7,'lodka', 'czteroosobowa','rwe4', 100, 25,'N', 4);
INSERT INTO "176553_sprzet" (id, nazwa, opis, nr_inwentarzony, cena_dzien, cena_godzina, dostepnosc, "176553_producent_id") VALUES (8,'rower wodny', 'dwuosobowa','43g6', 50, 15,'T', 4);
INSERT INTO "176553_sprzet" (id, nazwa, opis, nr_inwentarzony, cena_dzien, cena_godzina, dostepnosc, "176553_producent_id") VALUES (9,'boja SP', NULL,'908d', 0, 0,'N', 4);
INSERT INTO "176553_sprzet" (id, nazwa, opis, nr_inwentarzony, cena_dzien, cena_godzina, dostepnosc, "176553_producent_id") VALUES (10,'gogle', NUlL,'97le', 15, 5,'T', 2);

INSERT INTO "176553_kategoria" (id, nazwa, opis) VALUES (101, 'duze', null);
INSERT INTO "176553_kategoria" (id, nazwa, opis) VALUES (102, 'rozrywka', 'sprzet sluzacy rozrywce');
INSERT INTO "176553_kategoria" (id, nazwa, opis) VALUES (103, 'nauka', 'sprzet sluzacy do nauki');
INSERT INTO "176553_kategoria" (id, nazwa, opis) VALUES (104, 'inne', NULL);

INSERT INTO "176553_klasyfikacja" ("176553_kategoria_id", "176553_sprzet_id") VALUES (101,8);
INSERT INTO "176553_klasyfikacja" ("176553_kategoria_id", "176553_sprzet_id") VALUES (101,1);
INSERT INTO "176553_klasyfikacja" ("176553_kategoria_id", "176553_sprzet_id") VALUES (101,7);
INSERT INTO "176553_klasyfikacja" ("176553_kategoria_id", "176553_sprzet_id") VALUES (102,2);
INSERT INTO "176553_klasyfikacja" ("176553_kategoria_id", "176553_sprzet_id") VALUES (102,3);
INSERT INTO "176553_klasyfikacja" ("176553_kategoria_id", "176553_sprzet_id") VALUES (102,4);
INSERT INTO "176553_klasyfikacja" ("176553_kategoria_id", "176553_sprzet_id") VALUES (103,5);
INSERT INTO "176553_klasyfikacja" ("176553_kategoria_id", "176553_sprzet_id") VALUES (103,6);
INSERT INTO "176553_klasyfikacja" ("176553_kategoria_id", "176553_sprzet_id") VALUES (104,9);
INSERT INTO "176553_klasyfikacja" ("176553_kategoria_id", "176553_sprzet_id") VALUES (104,10);

INSERT INTO "176553_naprawa" (id, "176553_pracownik_id", "176553_sprzet_id", data_zlecenia, opis_usterki, data_naprawy,opis_naprawy ) VALUES (100,5,7, TO_DATE('2019/07/16','YYYY/MM/DD'), 'wygiete dulki', TO_DATE('2019/07/17','YYYY/MM/DD'),'dulki wyprostowano');
INSERT INTO "176553_naprawa" (id, "176553_pracownik_id", "176553_sprzet_id", data_zlecenia, opis_usterki, data_naprawy,opis_naprawy ) VALUES (200,7,1, TO_DATE('2019/07/18','YYYY/MM/DD'), 'dziura', TO_DATE('2019/07/20','YYYY/MM/DD'),'dziurê zalatano');
INSERT INTO "176553_naprawa" (id, "176553_pracownik_id", "176553_sprzet_id", data_zlecenia, opis_usterki, data_naprawy,opis_naprawy ) VALUES (300,5,8, TO_DATE('2019/07/25','YYYY/MM/DD'), 'zepsute pedaly', TO_DATE('2019/07/29','YYYY/MM/DD'),null);

INSERT INTO "176553_wypozyczenie" (id,data_wyp, godzina_wyp, kaucja, "176553_klient_id", "176553_pracownik_id") VALUES ( 1, TO_DATE('2019/07/01','YYYY/MM/DD'), TO_DATE('09:00','HH24:MI'),15.15, 1,1);
INSERT INTO "176553_wypozyczenie" (id,data_wyp, godzina_wyp, kaucja, "176553_klient_id", "176553_pracownik_id") VALUES ( 2, TO_DATE('2019/07/01','YYYY/MM/DD'), TO_DATE('09:53','HH24:MI'),10.23, 2,2);
INSERT INTO "176553_wypozyczenie" (id,data_wyp, godzina_wyp, kaucja, "176553_klient_id", "176553_pracownik_id") VALUES ( 3, TO_DATE('2019/07/03','YYYY/MM/DD'), TO_DATE('10:20','HH24:MI'),17.93, 3,1);
INSERT INTO "176553_wypozyczenie" (id,data_wyp, godzina_wyp, kaucja, "176553_klient_id", "176553_pracownik_id") VALUES ( 4, TO_DATE('2019/07/05','YYYY/MM/DD'), TO_DATE('12:42','HH24:MI'),32.15, 4,4);
INSERT INTO "176553_wypozyczenie" (id,data_wyp, godzina_wyp, kaucja, "176553_klient_id", "176553_pracownik_id") VALUES ( 5, TO_DATE('2019/08/06','YYYY/MM/DD'), TO_DATE('11:30','HH24:MI'),21.15, 5,10);
INSERT INTO "176553_wypozyczenie" (id,data_wyp, godzina_wyp, kaucja, "176553_klient_id", "176553_pracownik_id") VALUES ( 6, TO_DATE('2019/07/16','YYYY/MM/DD'), TO_DATE('13:19','HH24:MI'),15, 6,4);
INSERT INTO "176553_wypozyczenie" (id,data_wyp, godzina_wyp, kaucja, "176553_klient_id", "176553_pracownik_id") VALUES ( 7, TO_DATE('2019/07/19','YYYY/MM/DD'), TO_DATE('09:00','HH24:MI'),32.53, 7,2);
INSERT INTO "176553_wypozyczenie" (id,data_wyp, godzina_wyp, kaucja, "176553_klient_id", "176553_pracownik_id") VALUES ( 8, TO_DATE('2019/08/26','YYYY/MM/DD'), TO_DATE('14:00','HH24:MI'),34.86, 8,1);
INSERT INTO "176553_wypozyczenie" (id,data_wyp, godzina_wyp, kaucja, "176553_klient_id", "176553_pracownik_id") VALUES ( 9, TO_DATE('2019/08/01','YYYY/MM/DD'), TO_DATE('09:00','HH24:MI'),13, 9,3);
INSERT INTO "176553_wypozyczenie" (id,data_wyp, godzina_wyp, kaucja, "176553_klient_id", "176553_pracownik_id") VALUES ( 10, TO_DATE('2019/08/11','YYYY/MM/DD'), TO_DATE('12:00','HH24:MI'),43, 10,10);

INSERT INTO "176553_pozycje" ("176553_wypozyczenie_id","176553_sprzet_id", data_zwrotu, godzina_zwrotu, cena) VALUES (1,1,TO_DATE('2019/07/01','YYYY/MM/DD'),TO_DATE('12:42','HH24:MI'),30);
INSERT INTO "176553_pozycje" ("176553_wypozyczenie_id","176553_sprzet_id", data_zwrotu, godzina_zwrotu, cena) VALUES (2,8,TO_DATE('2019/07/01','YYYY/MM/DD'),TO_DATE('14:00','HH24:MI'),60);
INSERT INTO "176553_pozycje" ("176553_wypozyczenie_id","176553_sprzet_id", data_zwrotu, godzina_zwrotu, cena) VALUES (3,7,TO_DATE('2019/07/04','YYYY/MM/DD'),TO_DATE('09:00','HH24:MI'),100);
INSERT INTO "176553_pozycje" ("176553_wypozyczenie_id","176553_sprzet_id", data_zwrotu, godzina_zwrotu, cena) VALUES (4,6,TO_DATE('2019/07/05','YYYY/MM/DD'),TO_DATE('18:17','HH24:MI'),null);
INSERT INTO "176553_pozycje" ("176553_wypozyczenie_id","176553_sprzet_id", data_zwrotu, godzina_zwrotu, cena) VALUES (5,5,TO_DATE('2019/08/06','YYYY/MM/DD'),TO_DATE('12:30','HH24:MI'),5);
INSERT INTO "176553_pozycje" ("176553_wypozyczenie_id","176553_sprzet_id", data_zwrotu, godzina_zwrotu, cena) VALUES (6,4,TO_DATE('2019/07/17','YYYY/MM/DD'),TO_DATE('09:00','HH24:MI'),10.32);
INSERT INTO "176553_pozycje" ("176553_wypozyczenie_id","176553_sprzet_id", data_zwrotu, godzina_zwrotu, cena) VALUES (7,3,TO_DATE('2019/07/19','YYYY/MM/DD'),TO_DATE('15:00','HH24:MI'),null);
INSERT INTO "176553_pozycje" ("176553_wypozyczenie_id","176553_sprzet_id", data_zwrotu, godzina_zwrotu, cena) VALUES (8,2,TO_DATE('2019/08/26','YYYY/MM/DD'),TO_DATE('16:30','HH24:MI'),15.45);
INSERT INTO "176553_pozycje" ("176553_wypozyczenie_id","176553_sprzet_id", data_zwrotu, godzina_zwrotu, cena) VALUES (9,10,TO_DATE('2019/08/02','YYYY/MM/DD'),TO_DATE('09:00','HH24:MI'),15);
INSERT INTO "176553_pozycje" ("176553_wypozyczenie_id","176553_sprzet_id", data_zwrotu, godzina_zwrotu, cena) VALUES (10,9,TO_DATE('2019/08/11','YYYY/MM/DD'),TO_DATE('17:15','HH24:MI'),0);



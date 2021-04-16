select * from "176553_kategoria"order by id;
select * from "176553_klient" order by id;
select * from "176553_pracownik"order by id;
select * from "176553_pozycje"order by id;
select * from "176553_wypozyczenie"order by id;
select * from "176553_sprzet"order by id;
select * from "176553_naprawa"order by id;
select * from "176553_stanowisko"order by id;
select * from "176553_producent"order by id;
select * from "176553_klasyfikacja"order by id;


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
INSERT INTO "176553_sprzet" (id, nazwa, opis, nr_inwentarzony, cena_dzien, cena_godzina, dostepnosc, "176553_producent_id") VALUES (7,'lodka', 'czteroosobowa','rwe4', 25, 100,'N', 4);
INSERT INTO "176553_sprzet" (id, nazwa, opis, nr_inwentarzony, cena_dzien, cena_godzina, dostepnosc, "176553_producent_id") VALUES (8,'rower wodny', 'dwuosobowa','43g6', 15, 50,'T', 4);
INSERT INTO "176553_sprzet" (id, nazwa, opis, nr_inwentarzony, cena_dzien, cena_godzina, dostepnosc, "176553_producent_id") VALUES (9,'boja SP', NULL,'908d', 0, 0,'N', 4);
INSERT INTO "176553_sprzet" (id, nazwa, opis, nr_inwentarzony, cena_dzien, cena_godzina, dostepnosc, "176553_producent_id") VALUES (10,'gogle', NUlL,'97le', 15, 5,'T', 2);

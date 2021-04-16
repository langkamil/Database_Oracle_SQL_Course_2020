INSERT INTO "176553_klient" (id, imie, nazwisko, telefon, email, rabat, ulica, numer, kod, miasto) VALUES (1, 'Michal', 'Blok', '123456789', 'michalblok@wp.pl', 2, 'Kolorowa', '2', '83-123', 'Luban');
INSERT INTO "176553_klient" (id, imie, nazwisko, telefon, email, rabat, ulica, numer, kod, miasto) VALUES (2, 'Jakub', 'Hinc', '111111111', 'jakubhinc@wp.pl', 4, 'Szkolna', '7', '23-132', 'Kartuzy');
INSERT INTO "176553_klient" (id, imie, nazwisko, telefon, email, rabat, ulica, numer, kod, miasto) VALUES (3, 'Marlena', 'Bobrowska', '323232121', 'marlenabobr@o2.pl', 1, 'Cicha', '24', '42-532', 'Lublin');
INSERT INTO "176553_klient" (id, imie, nazwisko, telefon, email, rabat, ulica, numer, kod, miasto) VALUES (4, 'Adriana', 'Boczek', '122121121', 'adrianaboczek@gmail.com', 0, 'Wiejska', '87', '22-909', 'Krakow');
INSERT INTO "176553_klient" (id, imie, nazwisko, telefon, email, rabat, ulica, numer, kod, miasto) VALUES (5, 'Anna', 'Rubik', '345980765', 'annarubik@gmail.com', 0, 'Sokratesa', '43', '83-400', 'Koscierzyna');
INSERT INTO "176553_klient" (id, imie, nazwisko, telefon, email, rabat, ulica, numer, kod, miasto) VALUES (6, 'Robert', 'Klich', '321543232', 'robertlich@wp.pl', NULL, 'Dworska', '322', '83-422', 'Barkoczyn');
INSERT INTO "176553_klient" (id, imie, nazwisko, telefon, email, rabat, ulica, numer, kod, miasto) VALUES (7, 'Sandra', 'Niema', '123421211', 'sandraniema@o2.pl', 5, 'Poziomkowa', '4', '32-211', 'Rekownica');
INSERT INTO "176553_klient" (id, imie, nazwisko, telefon, email, rabat, ulica, numer, kod, miasto) VALUES (8, 'Alicja', 'Szreder', '504828316', 'alicjaszred@o2.pl', 3, 'Dolna', '98', '54-453', 'Wodogrzmoty');
INSERT INTO "176553_klient" (id, imie, nazwisko, telefon, email, rabat, ulica, numer, kod, miasto) VALUES (9, 'Aleksander', 'Mazur', '787252444', 'olekmazur@wp.pl', 3, 'Zwyciêstwa', '12S/3', '30-213', 'Pieklo');
INSERT INTO "176553_klient" (id, imie, nazwisko, telefon, email, rabat, ulica, numer, kod, miasto) VALUES (10, 'Edward', 'Acki', '665324908', 'acki123@wp.pl', NULL, 'Woronicza', '170', '54/3', 'Wisla');


INSERT INTO "176553_stanowisko" (id, nazwa, opis) VALUES (1, 'Kasjer', 'Pracuje  przy kasie');
INSERT INTO "176553_stanowisko" (id, nazwa, opis) VALUES (2, 'Kierownik',NULL);
INSERT INTO "176553_stanowisko" (id, nazwa, opis) VALUES (3, 'Magazynier', 'Pracuje w magazynie');
INSERT INTO "176553_stanowisko" (id, nazwa, opis) VALUES (4, 'Inne', NULL);


INSERT INTO "176553_pracownik" (id, imie, nazwisko, "176553_stanowisko_id") VALUES (1, 'Jerzy', 'Gleba', 1);
INSERT INTO "176553_pracownik" (id, imie, nazwisko, "176553_stanowisko_id") VALUES (2, 'Adam', 'Szmit', 1);
INSERT INTO "176553_pracownik" (id, imie, nazwisko, "176553_stanowisko_id") VALUES (3, 'Anna', 'Rola', 2);
INSERT INTO "176553_pracownik" (id, imie, nazwisko, "176553_stanowisko_id") VALUES (4, 'Krystyna', 'Ropa', 3);
INSERT INTO "176553_pracownik" (id, imie, nazwisko, "176553_stanowisko_id") VALUES (5, 'Walerian', 'Kos', 4);
INSERT INTO "176553_pracownik" (id, imie, nazwisko, "176553_stanowisko_id") VALUES (6, 'Joanna', 'Dobra', 3);
INSERT INTO "176553_pracownik" (id, imie, nazwisko, "176553_stanowisko_id") VALUES (7, 'Damian', 'Rok', 4);
INSERT INTO "176553_pracownik" (id, imie, nazwisko, "176553_stanowisko_id") VALUES (8, 'Artur', 'Konan', 3);
INSERT INTO "176553_pracownik" (id, imie, nazwisko, "176553_stanowisko_id") VALUES (9, 'Szymon', 'Brew', 3);
INSERT INTO "176553_pracownik" (id, imie, nazwisko, "176553_stanowisko_id") VALUES (10, 'Robert', 'Rak', 2);

INSERT INTO "176553_producent" (id, nazwa, telefon, ulica, numer, kod, miasto) VALUES (1, 'Adidadid', '123422553', 'Czarna', '21', '83-400', 'Koscierzyna');
INSERT INTO "176553_producent" (id, nazwa, telefon, ulica, numer, kod, miasto) VALUES (2, 'Kolor', '321432546', 'Miodowa', '153', '54-653', 'Rzeszow');
INSERT INTO "176553_producent" (id, nazwa, telefon, ulica, numer, kod, miasto) VALUES (3, 'Robus', '221432664', 'Niebieska', '98', '43-830', 'Wroclaw');
INSERT INTO "176553_producent" (id, nazwa, telefon, ulica, numer, kod, miasto) VALUES (4, 'Bemax', '867432533', 'Kolorowa', '37', '22-423', 'Bydgoszcz');
INSERT INTO "176553_producent" (id, nazwa, telefon, ulica, numer, kod, miasto) VALUES (5, 'Doskoza', '665449038', 'Galaktyczna', '1', '12-420', 'Poznañ');

INSERT INTO "176553_sprzet"  (id, nazwa, opis, nr_inwentarzony, cena_dzien, cena_godzina, dostepnosc, "176553_producent_id") VALUES (1, 'kajak', 'jednoosobowy','21fs',25.50, 10.00, 'T',4);
INSERT INTO "176553_sprzet"  (id, nazwa, opis, nr_inwentarzony, cena_dzien, cena_godzina, dostepnosc, "176553_producent_id") VALUES (2, 'narty wodne', 'mêskie','q31e',10.00, 5.15, 'N',1);
INSERT INTO "176553_sprzet"  (id, nazwa, opis, nr_inwentarzony, cena_dzien, cena_godzina, dostepnosc, "176553_producent_id") VALUES (3, 'narty wodne', 'damskie','q31w',15.00,10.30 , 'T',1);
INSERT INTO "176553_sprzet"  (id, nazwa, opis, nr_inwentarzony, cena_dzien, cena_godzina, dostepnosc, "176553_producent_id") VALUES (4, 'dmuchañce', 'dla dzieci','qw32',10.32, 3.12, 'T',2);
INSERT INTO "176553_sprzet"  (id, nazwa, opis, nr_inwentarzony, cena_dzien, cena_godzina, dostepnosc, "176553_producent_id") VALUES (5, 'pletwy', NULL,'bh7s',15.90,7.99, 'N',3);
INSERT INTO "176553_sprzet"  (id, nazwa, opis, nr_inwentarzony, cena_dzien, cena_godzina, dostepnosc, "176553_producent_id") VALUES (6, 'rowerek wodny', 'czteroosobowy','vs2g',40.00, 10.00, 'T',4);
INSERT INTO "176553_sprzet"  (id, nazwa, opis, nr_inwentarzony, cena_dzien, cena_godzina, dostepnosc, "176553_producent_id") VALUES (7, 'motorowka', 'tylko dla osob z patentem sternika!','32re',500.00,100.00 , 'N',5);
INSERT INTO "176553_sprzet"  (id, nazwa, opis, nr_inwentarzony, cena_dzien, cena_godzina, dostepnosc, "176553_producent_id") VALUES (8, 'boja SP', 'sprzet tylko dla ratownika','spe2',0.00, 0.00, 'T',5);
INSERT INTO "176553_sprzet"  (id, nazwa, opis, nr_inwentarzony, cena_dzien, cena_godzina, dostepnosc, "176553_producent_id") VALUES (9, 'maska', NULL, 'dq21',5.50, 1.00, 'N',2);
INSERT INTO "176553_sprzet"  (id, nazwa, opis, nr_inwentarzony, cena_dzien, cena_godzina, dostepnosc, "176553_producent_id") VALUES (10, 'kamizelka ratunkowa', NULL ,'2sqs',13.50, 7.00, 'T',2);

INSERT INTO "176553_kategoria" (id, nazwa, opis) VALUES (1, 'rozrywka', 'do zabawy');
INSERT INTO "176553_kategoria" (id, nazwa, opis) VALUES (2, 'ratunkowe', NULL);
INSERT INTO "176553_kategoria" (id, nazwa, opis) VALUES (3, 'nauka', 'do nauki');
INSERT INTO "176553_kategoria" (id, nazwa, opis) VALUES (4, 'inne', NULL);

INSERT INTO "176553_klasyfikacja" ("176553_kategoria_id", "176553_sprzet_id") VALUES (1, 4);
INSERT INTO "176553_klasyfikacja" ("176553_kategoria_id", "176553_sprzet_id") VALUES (1, 6);
INSERT INTO "176553_klasyfikacja" ("176553_kategoria_id", "176553_sprzet_id") VALUES (1, 2);
INSERT INTO "176553_klasyfikacja" ("176553_kategoria_id", "176553_sprzet_id") VALUES (1, 3);
INSERT INTO "176553_klasyfikacja" ("176553_kategoria_id", "176553_sprzet_id") VALUES (1, 1);
INSERT INTO "176553_klasyfikacja" ("176553_kategoria_id", "176553_sprzet_id") VALUES (2, 8);
INSERT INTO "176553_klasyfikacja" ("176553_kategoria_id", "176553_sprzet_id") VALUES (2, 10);
INSERT INTO "176553_klasyfikacja" ("176553_kategoria_id", "176553_sprzet_id") VALUES (3, 5);
INSERT INTO "176553_klasyfikacja" ("176553_kategoria_id", "176553_sprzet_id") VALUES (3, 9);
INSERT INTO "176553_klasyfikacja" ("176553_kategoria_id", "176553_sprzet_id") VALUES (4, 7);

INSERT INTO "176553_wypozyczenie" (id, data_wyp, godzina_wyp, kaucja, "176553_klient_id", "176553_pracownik_id") VALUES (1,to_date('23/07/18','DD/MM/RR'),to_date('08:00','HH24:MI'),15.50,1,1);





select "176553_sprzet".NAZWA as "nazwa_sprzetu", nr_inwentarzony, "176553_producent".NAZWA as "nazwa_producenta" 
from "176553_producent", "176553_sprzet" 
where "176553_producent".NAZWA like 'Bemax' 
order by "176553_sprzet".ID;

select "176553_klient".imie, "176553_klient".nazwisko, 


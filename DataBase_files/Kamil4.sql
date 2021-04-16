-- usuwamy wszystkie stare tabele
begin
 for rek in (select table_name from user_tables)
 loop
 execute immediate 'drop table '||rek.table_name||' cascade constraints';
 end loop;
end;
/
-- usuwamy wszystkie stare sekwencje
begin
 for rek in (select sequence_name from user_sequences)
 loop
 execute immediate 'drop sequence '||rek.sequence_name;
 end loop;
end;
/
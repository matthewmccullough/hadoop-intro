A = load 'nameslice1.csv' using PigStorage(','); 
B = foreach A generate $2 as id;
C = ORDER B BY $0 ASC;
dump C;
store C into 'idnames.out';
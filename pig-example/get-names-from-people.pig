Person = load 'people.csv' using PigStorage(','); 
Names = foreach Person generate $2 as name;
OrderedNames = ORDER Names BY name DESC;
GroupedNames = GROUP OrderedNames BY name;
NameCount = FOREACH GroupedNames GENERATE group, COUNT(OrderedNames);
store NameCount into 'names.out';
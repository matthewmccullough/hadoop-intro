#Format the filesystem
hadoop namenode -format

#Optinal: Run the DFS daemons on localhost
#start-dfs.sh

#Import data
#Usage: hadoop fs -put <localsrc> ... <dst>
hadoop fs -rmr input
hadoop fs -put localinput input

#Check if the files are there
hadoop fs -lsr input

#Run the grep on all the files in localinput
hadoop jar /Applications/Dev/hadoop-family/hadoop-0.20.1/hadoop-*-examples.jar grep input/* output 'dfs[a-z.]+'

#Look at the files remotely
hadoop fs -cat output/part*

#pull the files local
hadoop fs -get output output 
cat output/*
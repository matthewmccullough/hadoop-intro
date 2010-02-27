rm -rf output

#Format the filesystem
hadoop namenode -format

#Optinal: Run the DFS daemons on localhost
#start-dfs.sh

#Import data
#Usage: hadoop fs -put <localsrc> ... <dst>
hadoop fs -rmr remoteinput

#Upload files
hadoop fs -mkdir remoteinput
hadoop fs -put localinput/*xml* remoteinput

#Check if the files are there
hadoop fs -lsr remoteinput

#Run the grep on all the files in localinput
#hadoop fs -mkdir output 
hadoop jar /Applications/Dev/hadoop-family/hadoop-0.20.1/hadoop-*-examples.jar grep remoteinput output 'dfs[a-z.]+'

#Look at the files remotely
hadoop fs -cat output/part*

#pull the files local
hadoop fs -get output localoutput
cat localoutput/output/*
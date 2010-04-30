#Remove the last run's output dir
rm -rf localoutput
rm -rf localoutput
#Remove the local equiv to the remote input
rm -rf remoteinput
rm -rf remoteoutput

#Format the filesystem
hadoop namenode -format

#Optinal: Run the DFS daemons on localhost
#start-dfs.sh

#Import data
#Usage: hadoop fs -put <localsrc> ... <dst>
hadoop fs -rmr remoteinput

#Upload files
hadoop fs -mkdir remoteinput
hadoop fs -put localinput/*.log remoteinput

#Check if the files are there
hadoop fs -lsr remoteinput

#Run the grep on all the files in localinput
#hadoop fs -mkdir output 
hadoop jar /Applications/Dev/hadoop-family/hadoop-0.20.1/hadoop-*-examples.jar grep remoteinput remoteoutput '[a-z.]+html'

#Look at the files remotely
hadoop fs -cat remoteoutput/part*

#pull the files local
hadoop fs -get remoteoutput localoutput
cat localoutput/*
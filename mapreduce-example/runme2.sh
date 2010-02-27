rm -rf output2
hadoop jar /Applications/Dev/hadoop-family/hadoop-0.20.1/hadoop-*-examples.jar grep input output2 '[a-z.]*err[a-z.]*'
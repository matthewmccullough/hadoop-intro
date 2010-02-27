rm -rf output
hadoop jar /Applications/Dev/hadoop-family/hadoop-0.20.1/hadoop-*-examples.jar grep input output '[a-z.]+html'
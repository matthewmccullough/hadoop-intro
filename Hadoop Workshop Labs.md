#Hadoop Workshop Student Guide

## Install Hadoop and Subprojects
Download core binaries:
    http://hadoop.apache.org/common/releases.html
    http://www.apache.org/dyn/closer.cgi/hadoop/core/
    http://mirror.cc.columbia.edu/pub/software/apache/hadoop/core/hadoop-0.20.2/
    
Download ancillary projects (Pig, Hive, HBase, Zookeeper, Avro, Chukwa):
    http://mirror.cc.columbia.edu/pub/software/apache/hadoop/

### Cloudera's VMWare Image
    http://www.cloudera.com/developers/downloads/virtual-machine/
    http://cloudera-vm.s3.amazonaws.com/cloudera-training-0.3.3.tar.bz2

### VMWare Player, Fusion
    http://www.vmware.com/download/player/


## Examine input files
    cd /home/training/git/data/input
    tail -1000 all-shakespeare


## Tail Hadoop Logs
* Open a separate terminal window

    cd /usr/lib/hadoop-0.20/logs
    tail -f *

## Format the HDFS File System
    hadoop namenode -format


##Map Reduce

### Calculate Pi
    hadoop jar hadoop-0.20.1-examples.jar pi 4 1000

    http://code.google.com/edu/parallel/tools/hadoopvm/index.html

### Reset the processing (delete old files)
    hadoop fs -rmr shakes*

### Parse all of Shakespeare's works
* Grep yields unsorted output
hadoop jar $HADOOP_HOME/hadoop-*-examples.jar grep file:/home/training/git/data/input shakespeare_freq '\w+'

### Examine the file
hadoop fs -lsr shakespeare_freq/*
hadoop fs -cat shakespeare_freq/part-00000 | more

### Examine the job logs
hadoop fs -cat shakespeare_freq/_logs/history/* | more


## HDFS
### Put a file
hadoop fs -put ~/cloudera/cloudera_black.png .
hadoop fs -lsr .
hadoop fsck /
hadoop fsck -racks


## HBase
start-hbase.sh
hbase shell
create 'blogposts', 'post', 'image'

put 'blogposts', 'post1', 'post:title', 'Hello World'
put 'blogposts', 'post1', 'post:author', 'The Author'
put 'blogposts', 'post1', 'post:body', 'This is a blog post'
put 'blogposts', 'post1', 'image:header', 'image1.jpg'
put 'blogposts', 'post1', 'image:bodyimage', 'image2.jpg'

get 'blogposts', 'post1'


##Pig
pig

A = load 'shakespeare_freq/part-00000' using PigStorage('\t') AS (rawcount:int, rawword: chararray); 
explain A;

B = foreach A generate $1 as word, $0 as count;
C = ORDER B BY count ASC;

illustrate C;

dump C;
store C into 'shakespeare_words.output';

Y = LIMIT C 5;
dump Y;

quit;

hadoop fs -cat shakespeare_words.output/part-00000


##Hive
hive
### Clean up logs
hadoop fs -rmr shakespeare_freq/_logs

SHOW TABLES;
CREATE TABLE shakespeare (freq INT, word STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE;
DESCRIBE shakespeare;

LOAD DATA INPATH "shakespeare_freq" INTO TABLE shakespeare;

SELECT * FROM shakespeare LIMIT 10;

SELECT * FROM shakespeare WHERE freq > 100 SORT BY freq ASC LIMIT 10;
exit;


## Configuring Hadoop
cd /usr/lib/hadoop-0.20/conf


## Managing Hadoop

cd /usr/lib/hadoop-0.20/bin
sudo -u hadoop start-all.sh
sudo -u hadoop stop-all.sh

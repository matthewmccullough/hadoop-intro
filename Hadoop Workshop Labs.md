#Hadoop Workshop Student Guide
This is a guide to the exercises Matthew executes during his Hadoop training sessions. Once Hadoop is set up, most of the commands can be run in any order. The only over-arching requirement is that the Shakespeare files have been MapReduced, as they are used as inputs to other Pig and Hive processes.

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

## Go to the Hadoop home directory
    cd $HADOOP_HOME

## Examine input files
    cd /home/training/git/data/input
    tail -1000 all-shakespeare

## Tail Hadoop Logs
Open a separate terminal window

    cd /usr/lib/hadoop-0.20/logs
    tail -f *

## Format the HDFS File System
    hadoop namenode -format

## HDFS
### Put a file
    hadoop fs -put ~/cloudera/cloudera_black.png .
    hadoop fs -lsr .
    hadoop fsck /
    hadoop fsck -racks

### Reset the processing (delete old files)
    hadoop fs -rmr shakes*


## Map Reduce

### List all example tools
    hadoop jar $HADOOP_HOME/hadoop*examples.jar

### Calculate Pi
    hadoop jar hadoop-*-examples.jar pi 4 1000
    
Look at the source code for Pi

    http://code.google.com/edu/parallel/tools/hadoopvm/index.html
    
### Word Count
    hadoop jar $HADOOP_HOME/hadoop*examples.jar wordcount thrillers.txt wordcountoutput
    
### Parse all of Shakespeare's works
Grep yields unsorted output

    hadoop jar $HADOOP_HOME/hadoop-*-examples.jar grep file:/home/training/git/data/input shakespeare_freq '\w+'
    
    hadoop jar $HADOOP_HOME/hadoop*examples.jar grep thriller.txt grepoutputdir '\w+'

### Examine the file
    hadoop fs -lsr shakespeare_freq/*
    hadoop fs -cat shakespeare_freq/part-00000 | more

### Examine the job logs
    hadoop fs -cat shakespeare_freq/_logs/history/* | more


## Streaming
    cd /home/training/git/data
    cat thriller.txt
    cut -f 2 -d , thriller.txt

    hadoop jar $HADOOP_HOME/contrib/streaming/hadoop*streaming*.jar -input thriller.txt -output outputfromstreaming -mapper 'cut -f 2 -d ,' -reducer 'uniq'
    
Fails if we haven't uploaded the file to HDFS. We can upload it or we can address it via a file:// URL. This is because our default in 

### Sort reverse
    sort -r <SOMEFILE>
    
Work this into a streaming job


##Pig
Get a pig prompt

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


### Pig Again
    A = load 'myfile' as (t, u, v);
    C = filter A by t == 1;
    D = join C by t, B by x;
    E = group D by u;
    F = foreach E generate group, COUNT($1);

## HBase
On Mac

    start-hbase.sh

    hbase shell
    create 'blogposts', 'post', 'image'

### Check the metadata created    
    hadoop fs -lsr /
    
### Put some data into HBase
    put 'blogposts', 'post1', 'post:title', 'Hello World'
    put 'blogposts', 'post1', 'post:author', 'The Author'
    put 'blogposts', 'post1', 'post:body', 'This is a blog post'
    put 'blogposts', 'post1', 'image:header', 'image1.jpg'
    put 'blogposts', 'post1', 'image:bodyimage', 'image2.jpg'

    get 'blogposts', 'post1'


##Hive
    hive

### Clean up logs prior to running Hive
    hadoop fs -rmr shakespeare_freq/_logs

    SHOW TABLES;
    DROP TABLE shakespeare;
    
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
or
    cd $HADOOP_HOME/bin
    sudo -u hadoop start-all.sh
    sudo -u hadoop stop-all.sh
    
## Rebalancing
    su - hadoop /usr/lib/hadoop/bin/start-balancer.sh


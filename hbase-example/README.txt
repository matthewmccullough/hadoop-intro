Configure your hadoop-0.20.1/conf/hdfs-site.xml

<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>

<!-- Put site-specific property overrides in this file. -->

<configuration>
  <!-- Matthew 2010-01-13 -->
  <property>
         <name>fs.default.name</name>
         <value>localhost:9000</value>
  </property>
  <property>
         <name>mapred.job.tracker</name>
         <value>localhost:9001</value>
  </property>
  <property>
        <name>dfs.replication</name>
        <value>1</value>
  </property>
</configuration>


Then run the HDFS daemons:
start-dfs.sh

Then run the Hive daemon:
start-hbase.sh

Then get an HBase shell:
hbase shell

Sample script:

hbase>
help
create "mylittletable", "mylittlecolumnfamily"
describe "mylittletable"
put "mylittletable", "x"
put 'mylittletable', 'r2', 'mylittlecolumnfamily', 'x'
get "mylittletable", "x"
scan "mylittletable"

Informational server:
http://localhost:60030/regionserver.jsp

To stop hbase:
stop-hbase.sh
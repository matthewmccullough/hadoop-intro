/* Create:  this will create a table if it does not exist, or disable
   & update column families if the table already does exist.  The table 
   will be enabled when the create statement returns */

def hbase = HBaseBuilder.connect()

hbase.create( 'myTable' ) {
 family( 'familyOne' ) {
   inMemory = true
   bloomFilter = false
 }
 // create second family w/ the default options:
 family 'familyTwo'
}
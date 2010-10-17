// Reference:
// http://wiki.apache.org/hadoop/Hbase/Groovy

hbase.update( 'myTable' ) {
  new File( 'someFile.csv' ).eachLine { line ->
    def values = line.split(',')
    row( values[0] ) {
      col 'fam1:val1', values[1]
      col 'fam1:val2', values[2]
    }
  }
}
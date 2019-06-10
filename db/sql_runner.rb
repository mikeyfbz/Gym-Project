require( 'pg' )

class SqlRunner

  def self.run( sql, values = [] )
    begin
      db = PG.connect({ dbname: 'dbrfhjq6hnpi9b',
                         host: 'ec2-75-101-128-10.compute-1.amazonaws.com
                         ',
                        user: 'ldqmsjtdplxnox',
                        password: '603e58fdb06438c8bbadbcd9555a1ae0d4e81a0b32b7b30d712c3d3a29af6abf' })
      db.prepare("query", sql)
      result = db.exec_prepared( "query", values )
    ensure
      db.close() if db != nil
    end
    return result
  end

end

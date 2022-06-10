# coding: utf-8
# hanoi tower benchmark


def make_hanoi_data( num )
  data = { :A=>[], :B=>[], :C=>[] }
  num.times {
    data[:A] << num
    num -= 1
  }
  return data
end

def solve_hanoi_recursive( n, data, ta, tb, tc )
  if n == 1
    data[tc] << data[ta].pop()
    puts_hanoi_data( "move #{ta}:#{data[tc][-1]} >#{tc}", data )
  else
    solve_hanoi_recursive( n-1, data, ta, tc, tb )
    solve_hanoi_recursive( 1,   data, ta, tb, tc )
    solve_hanoi_recursive( n-1, data, tb, ta, tc )
  end

  return data
end

def puts_hanoi_data( s, data )
  n = data[:A].size + data[:B].size + data[:C].size
  fmt = "%s=%-#{n*2}s "

  s << "   "
  data.each {|k,v|
    s << sprintf( fmt, k, v.join(",") )
  }
#  puts s
end

def hanoi( num )
  data = make_hanoi_data( num )
  puts_hanoi_data( "start      ", data )
  result = solve_hanoi_recursive( num, data, :A, :B, :C )
end


200.times {
  hanoi( 8 )
}

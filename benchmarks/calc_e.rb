def calc_e
  n = 1
  while true
    e = (1 + 1.0/n) ** n
    error = ((e - 2.718281828459045) / 2.71828182845904).abs
    break  if error < 1e-6  # 1ppm
    n += 1
  end

  return [n, e]
end

10.times { calc_e }

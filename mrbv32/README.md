# mrbv32

mruby bytecode file (.mrb) viewer and disassembler for mruby version 3.2

## Usage
```
mrbv32 [opt] .rb or .mrb file
```

Option

-v   Verbose  
-i   with indent  
-d   Disassemble  
-r   with register variables.

If you have mrbc (mruby compiler) You can specify .rb file for display.

## Examples
### mruby code
```
puts "Hello", "Ruby"
```

#### Results
```
$mrbv32 sample.rb
==== RITE FILE HEADER ====
Ident/Ver:RITE0300  Size:97 ($61)  Compiler:0000

==== IREP SECTION size:69 ($45) ver:0300 ===
[IREP] size:57 nlocals:1 nregs:5 reps:0 clen:0 ilen:13
[POOL] plen:2
[SYMS] slen:1

==== END SECTION size:8 ($8) ===
```

#### -v option
```
$mrbv32 -v sample.rb
==== RITE FILE HEADER ====
Ident/Ver:RITE0300  Size:97 ($61)  Compiler:0000

==== IREP SECTION size:69 ($45) ver:0300 ===
[IREP] size:57 nlocals:1 nregs:5 reps:0 clen:0 ilen:13
[POOL] plen:2
  0: type=0 len=5 "Hello"
  1: type=0 len=4 "Ruby"
[SYMS] slen:1
  0: len=4 "puts"

==== END SECTION size:8 ($8) ===
```

#### -d option
```
$mrbv32 -d sample.rb
==== RITE FILE HEADER ====
Ident/Ver:RITE0300  Size:97 ($61)  Compiler:0000

==== IREP SECTION size:69 ($45) ver:0300 ===
[IREP] size:57 nlocals:1 nregs:5 reps:0 clen:0 ilen:13
 000 51 OP_STRING     R[a=2] = str_dup(Pool[b=0]="Hello")
 003 51 OP_STRING     R[a=3] = str_dup(Pool[b=1]="Ruby")
 006 2d OP_SSEND      R[a=1] = self.send(Syms[b=0]=:puts,R[a+1=2]..,R[a+n+1=4]:R[a+n+2=5]..) [n=2,k=0]
 010 38 OP_RETURN     return R[a=1] (normal)
 012 69 OP_STOP       stop VM
[POOL] plen:2
[SYMS] slen:1

==== END SECTION size:8 ($8) ===
```

#### -dr option
```
$mrbv32 -dr sample.rb
==== RITE FILE HEADER ====
Ident/Ver:RITE0300  Size:97 ($61)  Compiler:0000

==== IREP SECTION size:69 ($45) ver:0300 ===
[IREP] size:57 nlocals:1 nregs:5 reps:0 clen:0 ilen:13
 000 51 OP_STRING     [ 2, 0, -] R[a=2] = str_dup(Pool[b=0]="Hello")
 003 51 OP_STRING     [ 3, 1, -] R[a=3] = str_dup(Pool[b=1]="Ruby")
 006 2d OP_SSEND      [ 1, 0, 2] R[a=1] = self.send(Syms[b=0]=:puts,R[a+1=2]..,R[a+n+1=4]:R[a+n+2=5]..) [n=2,k=0]
 010 38 OP_RETURN     [ 1, -, -] return R[a=1] (normal)
 012 69 OP_STOP       [ -, -, -] stop VM
[POOL] plen:2
[SYMS] slen:1

==== END SECTION size:8 ($8) ===
```



### mruby code example 2
```
def func1
  puts "This is func1"
end

class Class1
  def method1
    puts "This is Class1"
  rescue
    nil
  end
  def method2
  end
end

begin
  raise
rescue
  puts
end

def func2
  puts "This is func2"
end
```

#### Result -vi option
```
$mrbv32 -vi sample.rb
==== RITE FILE HEADER ====
Ident/Ver:RITE0300  Size:521 ($209)  Compiler:0000

==== IREP SECTION size:473 ($1d9) ver:0300 ===
[IREP] size:149 nlocals:1 nregs:3 reps:3 clen:1 ilen:60
[CATCH] clen:1
[POOL] plen:0
[SYMS] slen:6
  0: len=5 "func1"
  1: len=6 "Class1"
  2: len=5 "raise"
  3: len=13 "StandardError"
  4: len=4 "puts"
  5: len=5 "func2"

> [IREP-0] size:57 nlocals:2 nregs:5 reps:0 clen:0 ilen:13
  [POOL] plen:1
    0: type=0 len=13 "This is func1"
  [SYMS] slen:1
    0: len=4 "puts"

> [IREP-1] size:58 nlocals:1 nregs:3 reps:2 clen:0 ilen:18
  [POOL] plen:0
  [SYMS] slen:2
    0: len=7 "method1"
    1: len=7 "method2"

> > [IREP-1-0] size:112 nlocals:2 nregs:5 reps:0 clen:1 ilen:38
    [CATCH] clen:1
    [POOL] plen:1
      0: type=0 len=14 "This is Class1"
    [SYMS] slen:2
      0: len=4 "puts"
      1: len=13 "StandardError"

> > [IREP-1-1] size:28 nlocals:2 nregs:3 reps:0 clen:0 ilen:8
    [POOL] plen:0
    [SYMS] slen:0

> [IREP-2] size:57 nlocals:2 nregs:5 reps:0 clen:0 ilen:13
  [POOL] plen:1
    0: type=0 len=13 "This is func2"
  [SYMS] slen:1
    0: len=4 "puts"

==== LVAR SECTION size:20 ($14) ===
0000  00 00 00 00 ff ff ff ff  ff ff ff ff              ............

==== END SECTION size:8 ($8) ===
```

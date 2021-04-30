# mrbv3

mruby bytecode file (.mrb) viewer and disassembler for IREP version 3.

## Usage
```
mrbv3 [opt] .mrb file
```

Option

-v   Verbose  
-i   with indent  
-d   Disassemble  

If you have mrbc (mruby compiler) You can specify .rb file for display.

## Examples
### mruby code
```
puts "Hello", "Ruby"
```

#### Results
```
$mrbv3 sample.rb
==== RITE FILE HEADER ====
Ident/Ver:RITE0200  Size:97 ($61)  Compiler:0000

==== IREP SECTION size:69 ($45) ver:0300 ===
[IREP 0] size:57 nlocals:1 nregs:5 reps:0 clen:0 ilen:15
[POOL] plen:2
[SYMS] slen:1

==== END SECTION size:8 ($8) ===
```

#### -v option
```
$mrbv3 -v sample.rb
==== RITE FILE HEADER ====
Ident/Ver:RITE0200  Size:97 ($61)  Compiler:0000

==== IREP SECTION size:69 ($45) ver:0300 ===
[IREP 0] size:57 nlocals:1 nregs:5 reps:0 clen:0 ilen:15
[POOL] plen:2
  0: type=0 len=5 "Hello"
  1: type=0 len=4 "Ruby"
[SYMS] slen:1
  0: len=4 "puts"

==== END SECTION size:8 ($8) ===
```

#### -d option
```
$mrbv3 -d sample.rb
==== RITE FILE HEADER ====
Ident/Ver:RITE0200  Size:97 ($61)  Compiler:0000

==== IREP SECTION size:69 ($45) ver:0300 ===
[IREP 0] size:57 nlocals:1 nregs:5 reps:0 clen:0 ilen:15
 0000 14 OP_LOADSELF   R(a=1) = self
 0002 51 OP_STRING     R(a=2) = str_dup(Lit(b=0)="Hello" )
 0005 51 OP_STRING     R(a=3) = str_dup(Lit(b=1)="Ruby" )
 0008 2f OP_SEND       R(a=1) = call(R(a=1),Syms(b=0)=:puts ,R(a+1=2),...,R(a+c=3))
 000c 39 OP_RETURN     return R(a=1) (normal)
 000e 6b OP_STOP       stop VM
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
$mrbv3 -vi sample.rb
==== RITE FILE HEADER ====
Ident/Ver:RITE0200  Size:528 ($210)  Compiler:0000

==== IREP SECTION size:477 ($1dd) ver:0300 ===
[IREP 0] size:154 nlocals:1 nregs:3 reps:3 clen:1 ilen:67
[CATCH] clen:1
  0: type=0(rescue)   begin=$0012 end=$0018 target=$001B
[POOL] plen:0
[SYMS] slen:6
  0: len=5 "func1"
  1: len=6 "Class1"
  2: len=5 "raise"
  3: len=13 "StandardError"
  4: len=4 "puts"
  5: len=5 "func2"

> [IREP 0-0] size:57 nlocals:2 nregs:5 reps:0 clen:0 ilen:15
  [POOL] plen:1
    0: type=0 len=13 "This is func1"
  [SYMS] slen:1
    0: len=4 "puts"

> [IREP 0-1] size:59 nlocals:1 nregs:3 reps:2 clen:0 ilen:21
  [POOL] plen:0
  [SYMS] slen:2
    0: len=7 "method1"
    1: len=7 "method2"

> > [IREP 0-1-0] size:112 nlocals:2 nregs:5 reps:0 clen:1 ilen:40
    [CATCH] clen:1
      0: type=0(rescue)   begin=$0004 end=$000D target=$0010
    [POOL] plen:1
      0: type=0 len=14 "This is Class1"
    [SYMS] slen:2
      0: len=4 "puts"
      1: len=13 "StandardError"

> > [IREP 0-1-1] size:26 nlocals:2 nregs:3 reps:0 clen:0 ilen:8
    [POOL] plen:0
    [SYMS] slen:0

> [IREP 0-2] size:57 nlocals:2 nregs:5 reps:0 clen:0 ilen:15
  [POOL] plen:1
    0: type=0 len=13 "This is func2"
  [SYMS] slen:1
    0: len=4 "puts"

==== LVAR SECTION size:23 ($17) ===
(skip)

==== END SECTION size:8 ($8) ===
```

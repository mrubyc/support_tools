# benchmark programs.

## Usage

```
CFLAGS="-O2 -DNDEBUG" make
time mrubyc/sample_c/sample_no_scheduler hanoi.mrb
```


# Profiling

## MacOS Xcode

```
xcrun xctrace record --template 'Time Profiler' --output ./result.trace --launch -- <PROGRAM>
open ./result.trace
```

## Linux

```
CFLAGS="-O2 -DNDEBUG -pg" make
mrubyc/sample_c/sample_no_scheduler hanoi.mrb  # 普通に実行
gprof sample_c/sample_no_scheduler gmon.out
```

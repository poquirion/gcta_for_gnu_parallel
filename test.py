#!/usr/bin/python
import subprocess
all_chr=[]

for l in open('sorted'):
  a,b= l.split()
  all_chr.append(int(a))
print all_chr

while all_chr:
  cmd = "grep  ' {0} \| {1} ' truite.dat > chr{0}_{1}.dat".format(all_chr.pop(),all_chr.pop(0)) 
  subprocess.call(cmd,shell=True)

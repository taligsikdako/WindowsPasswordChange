@echo off
set list=%1 %2 %3 %4 %5 %6 %7 %8

(for %%a in (%list%) do ( 

   runas /user:%%a cmd
   
))

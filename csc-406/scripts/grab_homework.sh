#!/bin/bash
echo ------------------------

echo Enter homework number:
read homework_number

cp /home/zhuang/public/hw"$homework_number".zip ~/homework 
cd ~/homework 
unzip hw"$homework_number".zip 
rm hw"$homework_number".zip
cd hw"$homework_number"
cat hw"$homework_number".c

echo Homework hw$homework_number has been copied to ~/homework

echo ------------------------

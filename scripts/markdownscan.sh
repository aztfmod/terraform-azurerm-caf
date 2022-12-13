#!/bin/bash
set -x

sudo apt update && sudo apt install ruby-full
wget https://rubygems.org/rubygems/rubygems-3.2.31.tgz
tar xvf rubygems*
cd rubygems-3.2.31 && ruby setup.rb
gem install mdl
cd ../
mdl -l
mdl -r ~MD001,~MD002,~MD009,~MD013 -v docs/

status=$?

if test $status -eq 0
then
	echo "Markdown file validation is completed successfully."
else
	echo "Error! Markdown validation is failed. Please check this link about the error.\nhttps://github.com/markdownlint/markdownlint/blob/master/docs/RULES.md"
fi

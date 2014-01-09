#! /bin/bash

echo -e "\n--------------------------\n"
echo -e "Installing dependencies...\n"
bundle install

echo -e "\n--------------------------\n"
echo -e "Failing use case : requesting the payline url as soon as it is available...\n"
bundle exec ruby without_sleep.rb

echo -e "\n--------------------------\n"
echo -e "Working use case : waiting 5 seconds before requesting the payline url...\n"
bundle exec ruby with_sleep.rb

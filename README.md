# Website Replacement Script

You can search for alternate spoken phrases for talon by viewing the latest `final_file-[data].json` file within this repo. If you want or need the latest data, you will need to generate it by following the steps below.

Steps
1. sanity check this script
   * run `CreateAlts.rb`
     * the program should generate a new `final_fil-[data].json`
2. start talon on your desktop then use the [talon_command_extractor](https://github.com/stolen-sugar/talon_command_extractor) to get the most the most up to date `base_commands` and `alt_commands` from github
3. replace the existing `base_commands.json` and `alt_commands.json` files with the ones generated from [talon_command_extractor](https://github.com/stolen-sugar/talon_command_extractor)
4. run `CreateAlts.rb`
   * the program should generate a new `final_fil-[data].json` - use this file to search for alternative spoken phrases for talon
5. beautify/format the generated `final_fil-[data].json` file so it's easier to view
6. create a pull request so others can view the latest data.



 
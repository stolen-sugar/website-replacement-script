require 'json'

base_commands_file   = File.read('./base_commands.json')
alt_commands_file_1  = File.read('./alt_past_commands.json')
alt_commands_file_2  = File.read('./alt_commands.json')
base_commands        = JSON.parse(base_commands_file) 
$alt_past_commands   = JSON.parse(alt_commands_file_1) 
$alt_commands        = JSON.parse(alt_commands_file_2) 
$command_groups      = base_commands["command_groups"]
$new_command_groups  = {"file_paths" => {}}

def format_commands commands
  new_commands = {"action" => {}}
  commands.each do |k, v|
    new_commands["action"][v] = { spoken_form: k, alternate_sopken_forms: [] }
  end

  new_commands
end

def create_base_commands
  $command_groups.each do |group|
    file_name = group["file"]
    context   = group["context"]
    commands  = format_commands group["commands"]
    unless $new_command_groups["file_paths"].has_key? file_name
      $new_command_groups["file_paths"][file_name] = {}
      unless $new_command_groups["file_paths"].has_key? "context"
        $new_command_groups["file_paths"][file_name]["context"] = {}
      end
    end
    $new_command_groups["file_paths"][file_name]["context"][context] = {}
    $new_command_groups["file_paths"][file_name]["context"][context] = commands
  end  
end

def add_alt_commands(alt_commands)
  alt_commands.each do |command_groups|
    command_groups["command_groups"].each do |command_group| 
      file_name = command_group["file"]
      context   = command_group["context"]
      
      command_group["commands"].each do |k, v|
        next unless $new_command_groups["file_paths"][file_name] && 
          $new_command_groups["file_paths"][file_name]["context"][context] &&
          $new_command_groups["file_paths"][file_name]["context"][context]["action"][v]
        $new_command_groups["file_paths"][file_name]["context"][context]["action"][v][:alternate_sopken_forms].push(k).uniq!
      end
    end
  end 
end

def create_alt_commands
    add_alt_commands($alt_past_commands)
    add_alt_commands($alt_commands)
end


def create_final_file
  File.write("./final_file-#{Time.now}.json", JSON.dump({commnad_group: $new_command_groups}))
end


create_base_commands()
create_alt_commands()
create_final_file()


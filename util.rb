
def file_exists(filename)
  return File.file?(filename)
end

## TODO: Define custom exception
## in case this file doesn't exist
def open_json_file(filename)
  file = File.open filename
  return JSON.load file
end
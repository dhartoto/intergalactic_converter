class Note

  FILE_PATH = "public/"
  FILE_NAME = "note.txt"
  FULL_PATH = FILE_PATH + FILE_NAME

  def self.import
    if file_absent?
      msg = "I can't seem to find note.txt. Please check that you've added it"\
            " to the public folder then start me up again!"
      error_response(msg)
    elsif import_file.empty?
      msg = "The notes appear to be empty. Please add some notes then start me"\
            " up again!"
      error_response(msg)
    else
      success_response
    end
  end

  private

  def self.file_absent?
    not File.exists?(FULL_PATH)
  end

  def self.import_file
    File.read(FULL_PATH)
  end

  Response = Struct.new(:loaded?, :error_message, :content)

  def self.error_response(msg)
    resp = Response.new(false, msg, nil)
  end

  def self.success_response
    resp = Response.new(true, nil, build_hash)
  end

  def self.build_hash
    file = import_file
    num_hash = {}
    file.split(/\r/).each do |line|
      arr = line.split(" is ")
      num_hash[arr[0]] = arr[1]
    end
    num_hash
  end
end

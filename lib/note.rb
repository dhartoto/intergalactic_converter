class Note

  FILE_PATH = "public/"
  FILE_NAME = "note.txt"
  FULL_PATH = FILE_PATH + FILE_NAME

  attr_accessor :success, :error_message, :content

  def initialize(options={})
    @success       = options[:success]
    @error_message = options[:error_message]
    @content       = options[:content]
  end

  def self.import
    if file_absent?
      msg = "I can't seem to find note.txt. Please check that you've added it"\
            " to the public folder then start me up again!"
      create_error_response(msg)
    elsif import_file.empty?
      msg = "The notes appear to be empty. Please add some notes then start me"\
            " up again!"
      create_error_response(msg)
    else
      new(success: true, content: build_content)
    end
  end

  def loaded?
    success
  end

  private

  def self.file_absent?
    not File.exists?(FULL_PATH)
  end

  def self.import_file
    File.read(FULL_PATH)
  end

  def self.create_error_response(msg)
    new(success: false, error_message: msg)
  end

  def self.build_content
    file = import_file
    num_hash = {}
    file.split(/\r/).each do |line|
      arr = line.split(" is ")
      num_hash[arr[0]] = arr[1]
    end
    num_hash
  end
end

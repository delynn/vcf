# encoding: US-ASCII

require 'forwardable'
require 'pry'

class VCF
  VERSION   = '1.0.0'
  VCF_TOKEN = "END:VCARD\r\n"

  include Enumerable
  extend Forwardable
  def_delegators :@io, :close

  def self.foreach(path, &block)
    open(path) do |vcf|
      vcf.each(&block)
    end
  end

  def self.open(*args)
    vcf = new(File.open(*args))

    if block_given?
      begin
        yield vcf
      ensure
        vcf.close
      end
    else
      vcf
    end
  end

  def initialize(data)
    @io = data.is_a?(String) ? StringIO.new(data) : data
  end

  def each
    if block_given?
      while card = shift
        yield card
      end
    else
      to_enum
    end
  end

  # Returns a new VCard instance with the next chunk of data from the VCF file.
  #
  # The require happens in this method in order to minimize the load time for
  # the entire gem.
  def shift
    if data = @io.gets(VCF_TOKEN)
      require 'vcf/vcard' unless defined?(VCard)
      VCard.new(data)
    end
  end
  alias_method :gets,     :shift
  alias_method :readline, :shift

  def to_json
    map(&:to_json)
  end
end

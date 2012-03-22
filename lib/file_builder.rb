require "file_builder/version"
require 'blankslate'

class FileBuilder < BlankSlate
  def self.define(&block)
    new(&block)
  end

  define_method(:_instance_exec, find_hidden_method(:instance_exec))

  def initialize(&block)
    @main = block if block_given?
    @files = {}
    @lines = []
    @indent = ''
    @partials = {}
  end

  def run(data)
    _instance_exec(data, &@main)
    @files
  end

  def file(name)
    yield self
    @files[name] = @lines
    @lines = []
  end

  def block(first_line, last_line = nil)
    ln(first_line)
    @indent += '  '
    yield self
    @indent = @indent[0..-3]
    ln(last_line) unless last_line.nil?
  end

  def ln(line = nil)
    @lines << (line.nil? ? '' : "#{@indent}#{line}")
  end

  def partial(name, objects = nil, &block)
    if block_given?
      @partials[name] = block
    else
      partial = @partials[name] or raise "Missing partial: #{name.inspect}"
      Array(objects).each { |object| partial.call(object) }
    end
  end
end

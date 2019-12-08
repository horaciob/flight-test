# frozen_string_literal: true

class Manifest
  attr_reader :list
  def initialize
    @list = []
  end

  def add(passanger, seats)
    @list.push([passanger, seats])
  end

  def show_resume
    @list.each do |passanger|
      size = passanger[1].size
      puts "* #{passanger[0]}: #{size} #{plural(size)}"
    end
  end

  def show_details
    @list.each do |passanger|
      puts "* #{passanger[0]} seats: #{passanger[1].join(', ')}"
    end
  end
end

private
def plural(size)
  return 'people' if size > 1

  'person'
end

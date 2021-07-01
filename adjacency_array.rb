require 'set'
# create and populate the adjacency array

class Square
  attr_accessor :file, :rank, :neighbors

  def initialize(file, rank, neighbors = [])
    @file = file
    @rank = rank
    @neighbors = neighbors
  end
end

def calc_neighbors(file, rank) # rubocop:todo all
  ngbrs_array = []
  valid_files = 'a'..'h'
  valid_ranks = 1..8
  (0..3).each do |i|
    temp_file = (file.ord + 1 * (-1)**i).chr
    temp_rank = rank + 2 * (-1)**(i / 2)
    ngbrs_array.push [temp_file, temp_rank] if valid_files.include?(temp_file) && valid_ranks.include?(temp_rank)
  end
  (0..3).each do |i|
    temp_file = (file.ord + 2 * (-1)**i).chr
    temp_rank = rank + 1 * (-1)**(i / 2)
    ngbrs_array.push [temp_file, temp_rank] if valid_files.include?(temp_file) && valid_ranks.include?(temp_rank)
  end
  ngbrs_array
end

def find_square(string, array)
  file = string[0]
  rank = string[1].to_i
  array.find { |square| square.file == file && square.rank == rank }
end

def match_memory_locations(array)
  array.each do |square|
    square.neighbors.map! { |neighbor| find_square(neighbor, array) }
  end
  array
end

def build_adjecency_array(array)
  ('a'..'h').each do |file|
    (1..8).each do |rank|
      array.push Square.new(file, rank, calc_neighbors(file, rank))
    end
  end
  match_memory_locations(array)
end

BOARD = build_adjecency_array([])

# BOARD.each {|square| puts square.neighbors; puts "\n"}

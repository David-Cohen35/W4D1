require "../skeleton/lib/00_tree_node.rb"
require "byebug"
class KnightPathFinder
    attr_reader :considered_positions, :root_node

    # DIFFS = [[2,-1], [2, 1], [-2, 1], [-2, -1]]

    def self.valid_moves(pos)
        x = pos[0]
        y = pos[1]
        valid_moves_arr = []

        valid_moves_arr.push([x + 2, y-1],
        [x + 2, y + 1], [x - 2, y + 1], [x - 2, y - 1], [x+1, y-2], [x+1,y+2], [x-1, y-2], [x-1,y+2])

         

        valid_moves_arr = valid_moves_arr.select { |array_1| array_1[0].between?(0,7) && array_1[1].between?(0,7) }

        valid_moves_arr
    end

    def initialize(pos_arr)
        @root_node = PolyTreeNode.new(pos_arr)
        @considered_positions = [pos_arr]
        build_move_tree
    end

    def new_move_positions(pos)
        valid_moves_init = KnightPathFinder.valid_moves(pos) 
        valid_moves_init = valid_moves_init.select { |move| !considered_positions.include?(move) }

        @considered_positions.push(*valid_moves_init)

        valid_moves_init
    end

    def build_move_tree
        queue = [root_node]


        until queue.empty?
            parent_node = queue.shift
            valid_moves = new_move_positions(parent_node.value)
            valid_moves.each do |move|
                child_node = PolyTreeNode.new(move)
                parent_node.add_child(child_node)
                # child_node.parent = parent_node
                # parent_node.children << child_node
                queue << child_node
            end
        end
    end

    
    def find_path(end_pos)
        end_node = root_node.bfs(end_pos)
        trace_path_back(end_node)
    end
    
    def trace_path_back(end_n)
        path_arr = [end_n.value]
        
        while end_n.value != root_node.value
            path_arr.unshift(end_n.parent.value)
            end_n = end_n.parent
        end
        
        path_arr
    end
end


a= KnightPathFinder.new([0,0])
# a.build_move_tree
p a.find_path([1,1]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]


# frozen_string_literal: true

module Helpers
  module Matrix
    def fit_by_row(matrix, amount, mark_with: 1, skip_aisle: false)
      ret = false
      matrix.first.size.times do |current_column|
        matrix.each_with_index do |row, row_number|
          current = row[current_column..current_column+amount-1]
          if current.count(AirplaneType::FREE_SEATS_MASK) == amount
            matrix[row_number].fill(mark_with,current_column..current_column+amount-1)
            return true
          end
        end
      end
      ret
    end
    private

    def take_them(matrix, row, column, mark)
      matrix[row].fill(mark, column..,)
    end
  end
end

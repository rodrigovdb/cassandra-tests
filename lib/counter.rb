def current_char(pos)
  items = (0..9).map { |i| i } + ('A'..'Z').map { |i| i }
  items[pos]
end

def init
  items = []
  (0..35).each do |a|
    (0..35).each do |b|
      (0..35).each do |c|
        (0..35).each do |d|
          (0..35).each do |e|
            (0..35).each do |f|
              (0..35).each do |g|
                (0..35).each do |h|
                  (0..35).each do |i|
                    (0..35).each do |j|
                      res_a = current_char a
                      res_b = current_char b
                      res_c = current_char c
                      res_d = current_char d
                      res_e = current_char e
                      res_f = current_char f
                      res_g = current_char g
                      res_h = current_char h
                      res_i = current_char i
                      res_j = current_char j
                      items << "#{res_a}#{res_b}#{res_c}#{res_d}#{res_e}#{res_f}#{res_g}#{res_h}#{res_i}#{res_j}"
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  items
end

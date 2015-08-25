module RokCms
  class Layout < ActiveRecord::Base
    validates_presence_of :name, :content
    validates_length_of :name, maximum: 255

    belongs_to :site, class_name: 'RokBase::Site'
    #belongs_to :theme
    #has_many :pages

    def get_blocks
      blocks = []
      current_block = ''
      first_match = false
      in_a_block = false

      (0..content.length).each do |i|
        previous_char = i > 0 ? content[i - 1] : nil
        current_char = content[i]

        if !['\\', '['].include?(previous_char) && current_char == '['
          first_match = true
        elsif previous_char == '[' && current_char == '['
          in_a_block = true
          first_match = false
        elsif in_a_block && current_char != ']'
          current_block << current_char
        elsif previous_char == ']' && current_char == ']'
          in_a_block = false
          blocks << current_block
          current_block = ''
        else
          first_match = false
        end
      end

      return blocks
    end
  end
end

# frozen_string_literal: true

require 'securerandom'

module Spass
  class Password
    class << self
      LETTERS  = ('a'.upto('z') + 'A'.upto('Z')).to_a.freeze
      DIGITS   = 0.upto(9).to_a.freeze
      SYMBOLS  = "~!@\#$%^&*()_+`-={}|[]\\:\"<>?,./".chars.freeze

      def generate(total_chars, num_digits, num_symbols)
        validate(total_chars, num_digits, num_symbols)
        password = []

        total_letters(total_chars, num_digits, num_symbols).times do
          password.insert(password_index(password), any_char(LETTERS))
        end
        num_digits.times { password.insert(password_index(password), any_char(DIGITS)) }
        num_symbols.times { password.insert(password_index(password), any_char(SYMBOLS)) }
        password.join('')
      end

      def generate_non_repeating(total_chars, num_digits, num_symbols)
        validate(total_chars, num_digits, num_symbols)
        password = []

        total_letters(total_chars, num_digits, num_symbols).times { non_repeat_insert(LETTERS, password) }
        num_digits.times { non_repeat_insert(DIGITS, password) }
        num_symbols.times { non_repeat_insert(SYMBOLS, password) }
        password.join('')
      end

      private

      def non_repeat_insert(chars_array, password)
        index = password_index(password)
        left_char = password.fetch(index - 1, -1)
        char = any_char(chars_array)
        char = any_char(chars_array) while (char == password[index]) || (char == left_char)
        password.insert(index, char)
      end

      def password_index(password)
        random_num(password.size)
      end

      def validate(total_chars, num_digits, num_symbols)
        if total_chars.negative? || num_digits.negative? || num_symbols.negative?
          raise('total_char, num_digits, and num_symbols cannot be set below the minimum value of 0')
        end

        raise('num_digits + num_symbols exceeds total_char') if (num_digits + num_symbols) > total_chars
      end

      def total_letters(total_chars, num_digits, num_symbols)
        total_chars - (num_digits + num_symbols)
      end

      def any_char(chars_array)
        chars_array[random_num(chars_array.size)]
      end

      def random_num(limit)
        limit.zero? ? 0 : SecureRandom.random_number(limit)
      end
    end
  end
end

# Spass::Password.generate
# puts spass.random_num(5)
# puts spass.generate_non_repeating(3, 1, 1)
puts Spass::Password.generate(3, 1, 1)

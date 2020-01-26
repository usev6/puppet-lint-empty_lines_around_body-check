# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
PuppetLint.new_check(:empty_lines_around_body) do
  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def check
    checked_block_tokens = %i[IF ELSIF ELSE UNLESS CASE CLASS DEFINE NODE]
    checked_blocks = {}

    depth = 0
    tokens.each_index do |token_idx|
      if checked_block_tokens.include?(tokens[token_idx].type)
        checked_blocks[depth] = { :start => token_idx }
      end

      if tokens[token_idx].type == :LBRACE
        depth += 1
        unless checked_blocks[depth - 1].nil?
          idx_with_problem = idx_2nd_nl(token_idx)
          unless idx_with_problem == -1
            block_type = tokens[checked_blocks[depth - 1][:start]].type.downcase
            notify(
              :warning,
              :message => "empty line at start of #{block_type} block",
              :line    => tokens[idx_with_problem].line,
              :column  => tokens[idx_with_problem].column
            )
          end
        end
      elsif tokens[token_idx].type == :RBRACE
        unless checked_blocks[depth - 1].nil?
          idx_with_problem = idx_prec_2nd_nl(token_idx)
          unless idx_with_problem == -1
            block_type = tokens[checked_blocks[depth - 1][:start]].type.downcase
            notify(
              :warning,
              :message => "empty line at end of #{block_type} block",
              :line    => tokens[idx_with_problem].line,
              :column  => tokens[idx_with_problem].column
            )
          end
          checked_blocks.delete(depth)
        end
        depth -= 1
      end
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  # rubocop:disable Metrics/MethodLength
  def idx_2nd_nl(start_idx)
    seen_newlines = 0
    tokens[(start_idx + 1)..-1].each_index do |idx_in_block|
      idx_abs = idx_in_block + start_idx + 1
      if tokens[idx_abs].type == :NEWLINE
        seen_newlines += 1
        return idx_abs if seen_newlines > 1
      elsif %i[WHITESPACE INDENT].include? tokens[idx_abs].type
        next
      else
        break
      end
    end
    -1
  end
  # rubocop:enable Metrics/MethodLength

  # rubocop:disable Metrics/MethodLength
  def idx_prec_2nd_nl(start_idx)
    seen_newlines = 0
    idx_last_nl = -1
    (start_idx - 1).downto(0).each do |idx_abs|
      if tokens[idx_abs].type == :NEWLINE
        seen_newlines += 1
        return idx_last_nl if seen_newlines > 1

        idx_last_nl = idx_abs
      elsif %i[WHITESPACE INDENT].include? tokens[idx_abs].type
        next
      else
        break
      end
    end
    -1
  end
  # rubocop:enable Metrics/MethodLength
end
# rubocop:enable Metrics/BlockLength

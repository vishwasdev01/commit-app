class CommitDiffSerializer < ActiveModel::Serializer
  def initialize(commit)
    @commit = commit
  end

  def as_json(*)
    file_name = @commit.dig(:file_name)
    status = @commit.dig(:status)
    @commit = @commit.dig(:commit)
    changes = []
    current_change = nil

    file_diffs = @commit.split(/^diff --git/).drop(1)

    file_diffs.each do |file_diff|
      lines = file_diff.lines

      if lines.first =~ %r{^ a/(.*) b/(.*)$}
        current_change = {
          'changeKind' => status,
          'headFile' => { 'path' => file_name },
          'baseFile' => { 'path' => file_name },
          'hunks' => []
        }
        changes << current_change
      end

      current_hunk = nil
      base_line_number = 0
      head_line_number = 0

      lines.each do |line|
        case line
        when /^@@ -(\d+),?\d* \+(\d+),?\d* @@/
          base_line_number = ::Regexp.last_match(1).to_i
          head_line_number = ::Regexp.last_match(2).to_i
          header = line.strip
          current_hunk = {
            'header' => header,
            'lines' => []
          }
          current_change['hunks'] << current_hunk if current_change
        when /^\+/
          if current_hunk
            content = line[1..-2]
            line_info = {
              'baseLineNumber' => base_line_number,
              'headLineNumber' => head_line_number,
              'content' => "#{content}"
            }
            head_line_number += 1
            current_hunk['lines'] << line_info
          end
        else
          if current_hunk && !line.start_with?('-', '##')
            base_line_number += 1
            head_line_number += 1
          end
        end
      end
    end

    changes.to_json
  end
end

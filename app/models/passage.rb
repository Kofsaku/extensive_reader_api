class Passage < ApplicationRecord
  enum difficulty: {
    kindergarten: 0,
    junior_high_school: 1,
    high_school: 2
  }

  enum format: {
    narrative: 0,
    expository: 1,
    conversational: 2
  }

  def self.extract_title(text)
    title_regex = /\n\nTitle: (.*?)\n\n/
    match_data = text.match(title_regex)
    return match_data[1] if match_data.present?
    text
  end

  def self.extract_content(generated_text, title)
    title_and_newlines = "\n\nTitle: #{title}\n\n"
    generated_text.sub(title_and_newlines, '')
  end

  def self.count_actual_words(content)
    content.split.length
  end
end

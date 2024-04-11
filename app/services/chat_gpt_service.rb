class ChatGptService
  require 'openai'

  def initialize
    @openai = OpenAI::Client.new(access_token: ENV['CHAT_GPT_TOKEN'])
  end

  def generate_text(parameters)
    theme = parameters[:genre]
    level = parameters[:difficulty]
    format = parameters[:format]
    word_count = parameters[:words].to_i

    response = @openai.completions(
      parameters: {
        model: "gpt-3.5-turbo-instruct",
        temperature: 0.3,
        prompt: generate_prompt(theme, level, format, word_count),
        max_tokens: 50,
      },
    )

    response['choices'].first['text']
  end

  private

  def generate_prompt(theme, level, format, word_count)
    "Create an English learning passage for learners on the topic of #{theme} suitable for #{level} person, written as a single coherent #{format} text. The passage should be around #{word_count} words long. The passage must have an intriguing and fascinating title that makes readers want to start reading immediately. The body of the passage should be a continuous flow of text using simple vocabulary understandable by #{level} person, with no subheadings, bullet points, or standalone lines. The writing should be engaging and captivating, so #{level} student readers can't wait to read the entire passage from start to finish."
  end
end

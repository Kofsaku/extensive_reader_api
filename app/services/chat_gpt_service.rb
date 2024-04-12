class ChatGptService
  require 'openai'

  def initialize
    @openai = OpenAI::Client.new(access_token: Rails.application.credentials.chat_gpt[:token])
  end

  def self.generate_text(parameters)
    theme = parameters[:genre]
    level = parameters[:difficulty]
    format = parameters[:format]
    word_count = parameters[:words].to_i
    prompt = generate_prompt(theme, level, format, word_count)

    service = ChatGptService.new
    response = service.completions(prompt)


    response['choices'].first['text']
  end

  def completions(prompt)
    @openai.completions(
      parameters: {
        model: "gpt-3.5-turbo-instruct",
        temperature: 0.3,
        prompt: prompt,
        max_tokens: 10,
      }
    )
  end

  private

  def self.generate_prompt(theme, level, format, word_count)
    "Create an English learning passage for learners on the topic of #{theme} suitable for #{level} person, written as a single coherent #{format} text. The passage should be around #{word_count} words long. The passage must have an intriguing and fascinating title that makes readers want to start reading immediately. The body of the passage should be a continuous flow of text using simple vocabulary understandable by #{level} person, with no subheadings, bullet points, or standalone lines. The writing should be engaging and captivating, so #{level} student readers can't wait to read the entire passage from start to finish."
  end
end

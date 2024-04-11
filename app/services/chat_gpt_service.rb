class ChatGptService
  require 'openai'
  THEME = "wine"
  LEVEL = "kindergarten"
  FORMAT = "EXPOSITORY"
  WORD_COUNT = 500

  def initialize
    @openai = OpenAI::Client.new(access_token: ENV['CHAT_GPT_TOKEN'])
  end

  def chat
    response = @openai.completions(
      parameters: {
        model: "gpt-3.5-turbo-instruct",
        temperature: 0.3,
        prompt: "Create an English learning passage for learners on the topic of #{THEME} suitable for #{LEVEL} person, written as a single coherent #{FORMAT} text. The passage should be around #{WORD_COUNT} words long. The passage must have an intriguing and fascinating title that makes readers want to start reading immediately. The body of the passage should be a continuous flow of text using simple vocabulary understandable by #{LEVEL} person, with no subheadings, bullet points, or standalone lines. The writing should be engaging and captivating, so #{LEVEL} student readers can't wait to read the entire passage from start to finish.",
        max_tokens: 500,
      },
      )
    response['choices'].first['text']
  end
end

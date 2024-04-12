class Api::V1::PassagesController < ApplicationController
  def create
    # パラメータを検証し、必要ならエラーレスポンスを返す
    render status: 422 and return if params[:difficulty].blank?
    render status: 422 and return if params[:format].blank?
    render status: 422 and return if params[:words].blank?
    render status: 422 and return if params[:genre].blank?

    # リクエストパラメータを整理
    text_parameters = {
      difficulty: params[:difficulty],
      format: params[:format],
      words: params[:words],
      genre: params[:genre]
    }

    # ChatGptServiceを呼び出してテキストを生成
    generated_text = ChatGptService.generate_text(text_parameters)
    title = Passage.extract_title(generated_text)
    content = Passage.extract_content(generated_text, title)
    actual_words_count = Passage.count_actual_words(content)

    parameters = {
      title: title,
      content: content,
      difficulty: params[:difficulty],
      format: params[:format],
      words_count: params[:words],
      actual_words_count: actual_words_count,
      genre: params[:genre],
      raw_generated_text: generated_text
    }

    saved_passage = Passage.create(parameters)
    puts saved_passage
    render json: { passage_details: saved_passage}
  end
end

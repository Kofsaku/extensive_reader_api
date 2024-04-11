module Api
  module V1
    class TextGeneratorsController < ApplicationController
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
        generated_text = ChatGptService.new.generate_text(text_parameters)
        puts generated_text
        # 生成されたテキストをレスポンスとして返す
        render json: { text: generated_text }
      end
    end
  end
end

module Api
  module V1
    class TextGeneratorsController < ApplicationController
      def create
        # まず、受け取ったパラメータを使って適切なパラメータを作る
        # パラメータを検証し、必要ならエラーレスポンスを返す
        render status: 422 and return if params[:difficulty].blank?
        render status: 422 and return if params[:format].blank?
        render status: 422 and return if params[:words].blank?
        render status: 422 and return if params[:genre].blank?
        # OpenAIのためのパラメータを作成
        text_parameters = {
          difficulty: params[:difficulty],
          format: params[:format],
          words: params[:words],
          genre: params[:genre]
        }
        # ここでChatGPTにリクエストを送ってレスポンスを受け取る
        # response = YourChatGPTService.request(text_parameters)
        # エラーハンドリング
        # render status: 500 and return if response.error?
        response = { text: ['Hello', 'World', 'This', 'is', 'a', 'test'].sample(params[:words].to_i).join(' ') }
        render json: response
      end
    end
  end
end

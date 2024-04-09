module Api
  module V1
    class HelloController < ApplicationController
      def index
        render json: { message: 'Hello, Wo!' }
      end
    end
  end
end

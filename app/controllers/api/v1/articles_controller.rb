module Api::V1
  class ArticlesController < BaseController

    def show
      raise ResourceNotExists.new(
          ErrorCode::NOT_EXISTS_CODE, ErrorCode::NOT_EXISTS_MSG % ["article"]) unless article.present?
      render json: article
    end

    def create
      validate_required_params([:title, :date, :body], article_params)
      new_article = ::Articles::Creator.new(article_params).perform
      render json: new_article
    end

    def index
      render json: articles, serializer: ArticlesSerializer, tag: params[:tag_name]
    end

    private

    def article_params
      params.require(:article).permit(:title, :date, :body, tags:[])
    end

    def article
      raise ParameterMissing.new(
          ErrorCode::PARM_MISSING_CODE, ErrorCode::PARM_MISSING_MSG % ["id"]) unless params[:id].present?
      @article ||= Article.find_by(id: params[:id])
    end

    def articles
      raise ParameterInvalid.new(
          ErrorCode::PARM_INVALID_CODE, 'invalid date') unless valid_date?(params[:date])
      @articles ||= Article.where(date: params[:date])
                        .where(":tag_name = ANY (tags)", tag_name: params[:tag_name])
                        .order(created_at: :desc)
    end
  end
end

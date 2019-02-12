require 'rails_helper'

describe Api::V1::ArticlesController do
  let(:json) { JSON.parse(response.body) }
  describe '#show' do
    let!(:article) { create(:article) }
    context 'when all good' do
      before do
        get :show, params: { id: article.id }
      end

      it 'return 200' do
        expect(response).to have_http_status(200)
      end

      it 'return article' do
        expect(response.header['Content-Type']).to match(/json/)
        expect(json['id']).to eq(article.id)
      end
    end

    context 'when find with incorrect id' do
      before do
        get :show, params: { id: 123 }
      end

      it 'return 404' do
        expect(response).to have_http_status(404)
      end

      it 'return NOT_EXISTS_CODE error code' do
        expect(response.header['Content-Type']).to match(/json/)
        expect(json['code']).to eq(Exceptions::ErrorCode::NOT_EXISTS_CODE)
      end
    end

    context 'when find without id' do
      before do
        get :show
      end

      it 'return 400' do
        expect(response).to have_http_status(400)
      end

      it 'return PARM_MISSING_CODE error code' do
        expect(response.header['Content-Type']).to match(/json/)
        expect(json['code']).to eq(Exceptions::ErrorCode::PARM_MISSING_CODE)
      end
    end
  end

  describe '#create' do
    context 'when all good' do
      before do
        post :create, params: { article: {
            title: 'Test title',
            body: 'Test body',
            date: Date.current,
            tags: ['tag1', 'tag2']
        } }
      end

      it 'return 200' do
        expect(response).to have_http_status(200)
      end

      it 'return new created article' do
        expect(response.header['Content-Type']).to match(/json/)
        expect(json['title']).to eq('Test title')
      end
    end

    context 'when missing required params' do
      before do
        post :create, params: { article: {
            title: 'Test title',
            body: 'Test body',
            tags: ['tag1', 'tag2']
        } }
      end

      it 'return 400' do
        expect(response).to have_http_status(400)
      end

      it 'return PARM_MISSING_CODE error code' do
        expect(response.header['Content-Type']).to match(/json/)
        expect(json['code']).to eq(Exceptions::ErrorCode::PARM_MISSING_CODE)
      end
    end
  end

  describe '#index' do
    let(:article_date) { Date.current.strftime("%Y%m%d")}
    let!(:article1) { create(:article, tags: ['tag1', 'tag2']) }
    let!(:article2) { create(:article, tags: ['tag1']) }
    context 'when all good' do
      before do
        get :index, params: { date: article_date, tag_name: 'tag1'}
      end

      it 'return 200' do
        expect(response).to have_http_status(200)
      end

      it 'return the article list' do
        expect(response.header['Content-Type']).to match(/json/)
        expect(json['tag']).to eq('tag1')
        expect(json['count']).to eq(3)
        expect(json['articles'].size).to eq(2)
        expect(json['related_tags'].size).to eq(2)
      end
    end

    context 'when query with undefined tag' do
      before do
        get :index, params: { date: article_date, tag_name: 'tag3'}
      end

      it 'return 200' do
        expect(response).to have_http_status(200)
      end

      it 'return the empty list' do
        expect(response.header['Content-Type']).to match(/json/)
        expect(json['tag']).to eq('tag3')
        expect(json['count']).to eq(0)
        expect(json['articles']).to be_empty
        expect(json['related_tags']).to be_empty
      end
    end

    context 'when query with invalid date' do
      before do
        get :index, params: { date: 'invalid_date', tag_name: 'tag3'}
      end

      it 'return 200' do
        expect(response).to have_http_status(400)
      end

      it 'return PARM_INVALID_CODE error code' do
        expect(response.header['Content-Type']).to match(/json/)
        expect(json['code']).to eq(Exceptions::ErrorCode::PARM_INVALID_CODE)
      end
    end
  end
end

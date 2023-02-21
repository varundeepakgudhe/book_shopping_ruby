require 'rails_helper'
include AuthHelper

RSpec.describe BooksController, type: :controller do
  before(:each) do
    login_user
  end

  describe "GET index" do
    let(:book1) { create(:book, author: "rohit") }
    let(:book2) { create(:book) }
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
      expect(response.status).to eq(200)
    end

    it "assigns @books instance variable" do
      get :index
      expect(assigns(:books)).to eq([book1, book2])
    end

    it "filter @books based on rating" do
      review1 = FactoryBot.create(:review, rating: 3, book: book1)
      review2 = FactoryBot.create(:review, rating: 1, book: book2)
      get :index,params: {rating: 2}
      expect(assigns(:books)).to eq([book1])
    end

    it "filter @books based on author" do
      book =  create(:book, author: "ponzi")
      get :index, params: {author: "ponzi"}
      expect(assigns(:books)).to eq([book])
    end
  end

  describe "GET show" do
    let(:book1) { create(:book, author: "rohit") }
    it "renders show template" do
      # book1 = FactoryBot.create(
      get :show, params: {id: book1.id}
      expect(response).to render_template("show")
      expect(response.status).to eq(200)
    end

    it "renders show with correct book object" do
      # book1 = FactoryBot.create(:book, author: "rohit")
      get :show, params: {id: book1.id}
      expect(assigns(:book)).to eq(book1)
    end

    it "render reviews count correctly" do
      review1 = FactoryBot.create(:review, rating: 3, book: book1)
      review2 = FactoryBot.create(:review, rating: 1, book: book1)
      get :show, params: {id: book1.id}
      expect(assigns(:reviews).count).to eq 2
    end
  end

  describe "GET new" do
    it "renders new template" do
      get :new
      expect(response).to render_template("new")
    end
  end
end

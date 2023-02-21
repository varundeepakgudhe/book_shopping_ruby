require 'rails_helper'
include AuthHelper

RSpec.describe BooksController, type: :controller do
  # before(:each) do
  #   login_user
  # end

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
      login_admin
      get :new
      expect(response).to render_template("new")
    end
    it "do not render new template" do
      login_user
      get :new
      expect(response.status).to be 401
    end
  end

  describe "GET edit" do
    let(:book1) { create(:book, author: "rohit") }
    # login_admin
    it "renders edit template" do
      login_admin
      get :edit, params: {id: book1.id}
      expect(response).to render_template("edit")
    end
    it "do not render edit template" do
      login_user
      get :edit, params: {id: book1.id}
      expect(response.status).to be 401
    end
  end


  describe "POST create" do

    it "create a book correctly" do
      login_admin
      book1 = FactoryBot.build(:book)
      post :create, params: { book: {name: book1.name, author: book1.author, publisher: book1.publisher, price: book1.price, stock: book1.stock}}
      expect(assigns(:book).errors.count).to be 0
    end


    it "Missing name attribute" do
      login_admin
      book1 = FactoryBot.build(:book)
      post :create, params: { book: { author: book1.author, publisher: book1.publisher, price: book1.price, stock: book1.stock}}
      expect(assigns(:book).errors.count).not_to be 0
    end

    it "Missing author attribute" do
      login_admin
      book1 = FactoryBot.build(:book)
      post :create, params: { book: {name: book1.name, publisher: book1.publisher, price: book1.price, stock: book1.stock}}
      expect(assigns(:book).errors.count).not_to be 0
    end

    it "Missing publisher attribute" do
      login_admin
      book1 = FactoryBot.build(:book)
      post :create, params: { book: {name: book1.name, author: book1.author, price: book1.price, stock: book1.stock}}
      expect(assigns(:book).errors.count).not_to be 0
    end

    it "Missing price attribute" do
      login_admin
      book1 = FactoryBot.build(:book)
      post :create, params: { book: {name: book1.name, author: book1.author,publisher: book1.publisher, stock: book1.stock}}
      expect(assigns(:book).errors.count).not_to be 0
    end

    it "Missing stock attribute" do
      login_admin
      book1 = FactoryBot.build(:book)
      post :create, params: { book: {name: book1.name, author: book1.author,publisher: book1.publisher, price: book1.price}}
      expect(assigns(:book).errors.count).not_to be 0
    end

    it "cannot create a book without admin" do
      login_user
      book1 = FactoryBot.build(:book)
      post :create, params: { book: {name: book1.name, author: book1.author, publisher: book1.publisher, price: book1.price, stock: book1.stock}}
      # redirected to root with a message of "unauthorized"
      expect(response.status).to be 401
    end
  end


  describe "PUT update" do

    CONST_AUTHOR = "real"
    let(:book1) { create(:book, author: "fake") }
    it "update book successfully" do
      login_admin
      patch :update, params: {id: book1.id, book: {author: CONST_AUTHOR}}
      book_fetch = Book.find_by(id: book1.id)
      expect(book_fetch.author).to eq(CONST_AUTHOR)
    end
    it "user cannot update book" do
      login_user
      patch :update, params: {id: book1.id, book: {author: CONST_AUTHOR}}
      # redirected to root since unauthorized
      expect(response.status).to be 401
    end
  end

  describe "DELETE destroy" do

    let(:book1) { create(:book, author: "fake") }
    it "destroy book successfully" do
      login_admin
      delete :destroy, params: {id: book1.id}
      book_count = Book.where(id: book1.id).count
      expect(book_count).to eq 0
    end
    it "user cannot destroy book" do
      login_user
      delete :destroy, params: {id: book1.id}
      # redirected to root since unauthorized
      expect(response.status).to be 401
    end
  end
end

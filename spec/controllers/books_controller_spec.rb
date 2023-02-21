RSpec.describe BooksController, type: :controller do
  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "assigns @books" do
      book = FactoryBot.create(:book, name:"Mylifemyrules",author:"Varun",publisher:"NCSU",stock:"100",price:1000.0)
      get :index
      expect(assigns(:books)).to eq([book])
    end
  end
end

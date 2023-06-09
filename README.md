# Audibel
#### We sell books.

### Setup
* bundle install
* rails db:migrate
* rails s

### Pages

#### user
* sign up for new account
  * click on `sign up` link on the navbar, fill up the required information and click on sign up button.
  * `address`, `phone number` and `credit card number` are optional fields.
* login
  * click on `Login` link on the navbar.
* Edit profile
  * on the home page click on `Edit profile` link.
  * or click on your username on navbar.
* delete your account
  * go to your edit profile page and click on `cancel my account` at the bottom of the form.
* View all books on the website
  * click on `Books` link on the navbar.
* List books with an average rating above a certain rating.
  * in the Books page use the rating filter given on the left side of the page.
* List books written by specific author
  * in the Books page use the author filter given on the left side of the page. 
* Buy a book/books
  * Select the book you want to buy from the books listing page.
  * click on purchase this book.
  * fill transaction details and click `Complete purchase`
* Check transaction history
  * Click on `My Transactions` in the home page.
* write a book review
  * In the show book page click on `write a review for this book` button.
  * fill the review form
* Edit your review
  * under your review there is a button to edit.
* List review written by specific username or bookname.
  * in the home page click on `List/Search all reviews`
  * here you can search by username or bookname.

#### admin

* Login
  * click on `Login` link on the navbar.
  * To login, username:'admin', password: 'goldfish1234'
* Edit profile
  * Click on `Admin panel` in the navbar
  * click on `edit profile` link.
* View all the books that are available on the website
  * Click on `Manage books` in the admin panel
* List books written by specific author
  * Click on `Manage books` in the admin panel
  * Use the author filter.
* View all users signed up in the site.
  * in the admin panel click on `Manage users` link
* List reviews written by a specific username or book name
  * use the filter on the `Manage books` page
* Create/view/edit/delete users
  * Use the `Manage users` page.
* Create/view/edit/delete books
  * Use the `Manage books` page.
* Create/view/edit/delete reviews
  * Use the `Manage reviews` page.

#### Testing
Book Model
`rspec spec/models/book_spec.rb`

Book Controller
`rspec spec/controllers/books_controller_spec.rb`

#### Extra Credits

* Form Prefilling
  * The forms are prefilled if the user profile is completed. 
  * To complete the profile, edit the profile to add the attributes.

* Handle Race Conditions
  * Using pessimistic lock feature of the rails, we are handling race conditions

* Implement Cart-Like Feature
  * In the books index page, update the quantity field and click on 'Add to Cart' button.
  * If the book is already in the cart, then 'Go to Cart' button is shown.
  * To view the cart, click on Cart link in Navbar or click on 'My Personal Cart' at home page.
  * Click on 'Checkout' button to complete the order purchase.
  * To complete the purchase, fill the remaining fields in the Purchase page manually, if you have not completed the user profile earlier.
  * The transaction is complete.

#!/usr/bin/env bash
ssh my_grocery_price_book_www@my-grocery-price-book.co.za 'cd current;RAILS_ENV=production bundle exec rake db:structure:dump'
scp my_grocery_price_book_www@my-grocery-price-book.co.za:~/current/db/structure.sql db/structure.sql

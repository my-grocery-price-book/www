# == Schema Information
#
# Table name: invites
#
#  id            :integer          not null, primary key
#  price_book_id :integer
#  name          :string
#  email         :string
#  status        :string           default("sent"), not null
#  token         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class InvitesControllerTest < ActionController::TestCase
  setup do
    @shopper = create_shopper
    @price_book = PriceBook.create!(shopper: @shopper)
    sign_in @shopper, scope: :shopper
  end

  context 'GET new' do
    should 'render the new page with form' do
      get :new, book_id: @price_book.to_param
      assert_response :success
      assert response.body.include?('Invite')
      assert response.body.include?('<form')
    end
  end

  context 'POST create' do
    should 'create invite' do
      assert_difference('Invite.count') do
        post :create, book_id: @price_book.to_param,
                      invite: { name: 'Joe', email: 'joe@mail.com' }
      end

      assert_redirected_to price_book_pages_path
    end

    should 'send an email' do
      assert_difference('ActionMailer::Base.deliveries.size') do
        post :create, book_id: @price_book.to_param,
                      invite: { name: 'Joe', email: 'joe@mail.com' }
      end
    end

    should 'render new on failure' do
      assert_no_difference('Invite.count') do
        post :create, book_id: @price_book.to_param, invite: { name: 'Joe', email: '' }
      end

      assert_response :success
      assert response.body.include?('Invite')
      assert response.body.include?('<form')
    end
  end

  context 'GET show' do
    setup do
      @invite = Invite.create!(price_book: @price_book, name: 'Joe', email: 'joe@barber.com')
    end

    should 'be success' do
      get :show, id: @invite.to_param
      assert_response :success
      assert response.body.include?('Accept')
      assert response.body.include?('Reject')
    end

    should 'redirect to price_book_pages if accepted' do
      @invite.update!(status: 'accepted')
      get :show, id: @invite.to_param
      assert_redirected_to price_book_pages_path
    end

    should 'redirect to price_book_pages if rejected' do
      @invite.update!(status: 'rejected')
      get :show, id: @invite.to_param
      assert_redirected_to price_book_pages_path
    end
  end

  context 'PATCH accept' do
    setup do
      @invite = Invite.create!(price_book: @price_book,
                               name: 'Joe',
                               email: 'joe@barber.com')
    end

    should 'redirect to price_book_pages' do
      patch :accept, id: @invite.to_param
      assert_redirected_to price_book_pages_path
    end

    should 'accept the invite' do
      patch :accept, id: @invite.to_param
      @invite.reload
      assert_equal 'accepted', @invite.status
    end

    should 'alert if already rejected' do
      @invite.update!(status: 'rejected')
      patch :accept, id: @invite.to_param
      assert_equal flash['alert'], 'Token expired'
    end
  end

  context 'PATCH reject' do
    setup do
      @invite = Invite.create!(price_book: @price_book,
                               name: 'Joe',
                               email: 'joe@barber.com')
    end

    should 'redirect to price_book_pages' do
      patch :reject, id: @invite.to_param
      assert_redirected_to price_book_pages_path
    end

    should 'reject the invite' do
      patch :reject, id: @invite.to_param
      @invite.reload
      assert_equal 'rejected', @invite.status
    end

    should 'alert if already accepted' do
      @invite.update!(status: 'accepted')
      patch :reject, id: @invite.to_param
      assert_equal flash['alert'], 'Token expired'
    end
  end
end

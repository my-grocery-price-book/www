# frozen_string_literal: true

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
      get :new, params: { book_id: @price_book.to_param }
      assert_response :success
      assert response.body.include?('Invite')
      assert response.body.include?('<form')
    end
  end

  context 'POST create' do
    should 'create invite' do
      assert_difference('Invite.count') do
        post :create, params: { book_id: @price_book.to_param,
                                invite: { name: 'Joe', email: 'joe@mail.com' } }
      end

      assert_redirected_to book_pages_path(@price_book)
    end

    should 'send an email' do
      assert_difference('ActionMailer::Base.deliveries.size') do
        post :create, params: { book_id: @price_book.to_param,
                                invite: { name: 'Joe', email: 'joe@mail.com' } }
      end
    end

    should 'render new on failure' do
      assert_no_difference('Invite.count') do
        post :create, params: { book_id: @price_book.to_param, invite: { name: 'Joe', email: '' } }
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
      get :show, params: { id: @invite.to_param }
      assert_response :success
      assert response.body.include?('Accept')
      assert response.body.include?('Reject')
    end

    should 'redirect to root_path if already accepted' do
      @invite.update!(status: 'accepted')
      get :show, params: { id: @invite.to_param }
      assert_redirected_to root_path
      assert_not_nil flash[:alert]
    end

    should 'redirect to root_path if already rejected' do
      @invite.update!(status: 'rejected')
      get :show, params: { id: @invite.to_param }
      assert_redirected_to root_path
      assert_not_nil flash[:alert]
    end
  end

  context 'PATCH accept' do
    setup do
      @invite = Invite.create!(price_book: @price_book,
                               name: 'Joe',
                               email: 'joe@barber.com')
    end

    should 'accept the invite' do
      patch :accept, params: { id: @invite.to_param }
      assert_redirected_to book_pages_path(@price_book)
      assert_not_nil flash[:notice]
      @invite.reload
      assert_equal 'accepted', @invite.status
    end

    should 'alert if already rejected' do
      @invite.update!(status: 'rejected')
      patch :accept, params: { id: @invite.to_param }
      assert_equal flash['alert'], 'Token expired'
    end
  end

  context 'PATCH reject' do
    setup do
      @invite = Invite.create!(price_book: @price_book,
                               name: 'Joe',
                               email: 'joe@barber.com')
    end

    should 'reject the invite' do
      patch :reject, params: { id: @invite.to_param }
      assert_redirected_to root_path
      assert_not_nil flash[:notice]
      @invite.reload
      assert_equal 'rejected', @invite.status
    end

    should 'alert if already accepted' do
      @invite.update!(status: 'accepted')
      patch :reject, params: { id: @invite.to_param }
      assert_equal flash['alert'], 'Token expired'
    end
  end
end

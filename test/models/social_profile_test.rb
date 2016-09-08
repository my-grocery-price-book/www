# frozen_string_literal: true
require 'test_helper'

describe SocialProfile do
  subject { SocialProfile.new(@token) }
  before do
    @token = 'testtoken123'
  end

  describe 'connects successfully' do
    describe 'with facebook' do
      before do
        stub_url = "https://#{ENV['ONE_ALL_SUBDOMAIN']}.api.oneall.com/connections/#{@token}.json"
        stub_request(:get, stub_url)
          .to_return(status: 200, headers: {},
                     body: File.read("#{Rails.root}/test/fixtures/oneall_facebook_response.json"))
      end

      it 'must be authenticated' do
        subject.must_be :authenticated?
      end

      it 'must have facebook provider' do
        subject.provider.must_equal 'facebook'
      end

      it 'must have email' do
        subject.email.must_equal 'joebarber@example.com'
      end
    end

    describe 'with google plus' do
      before do
        stub_url = "https://#{ENV['ONE_ALL_SUBDOMAIN']}.api.oneall.com/connections/#{@token}.json"
        stub_request(:get, stub_url)
          .to_return(status: 200, headers: {},
                     body: File.read("#{Rails.root}/test/fixtures/oneall_google_plus_response.json"))
      end

      it 'with google plus' do
        subject.must_be :authenticated?
      end

      it 'must have google provider' do
        subject.provider.must_equal 'google'
      end

      it 'must have email' do
        subject.email.must_equal 'test@example.com'
      end
    end
  end

  describe 'connects 404' do
    describe 'with facebook' do
      before do
        stub_url = "https://#{ENV['ONE_ALL_SUBDOMAIN']}.api.oneall.com/connections/#{@token}.json"
        stub_request(:get, stub_url)
          .to_return(status: 404, headers: {},
                     body: File.read("#{Rails.root}/test/fixtures/oneall_404_response.json"))
      end

      it 'must be authenticated' do
        subject.wont_be :authenticated?
      end
    end
  end
end

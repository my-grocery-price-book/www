# @param [Hash] shopper_args
# @return [Shopper]
def create_shopper(shopper_args = {})
  Shopper.create!({password: '123123123',
                   password_confirmation: '123123123',
                   email: 'email@example.com',
                   confirmed_at: Time.now}.merge(shopper_args))
end

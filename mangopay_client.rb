require 'httparty'

class MangopayClient

  include HTTParty

  base_uri 'https://api.sandbox.mangopay.com/v2'
  format :json

  headers 'Accept' => 'application/json'
  headers 'Content-Type' => 'application/json'

  def initialize(key, secret)
    @key = key
    @secret = secret
  end

  def get(path)
    response = self.class.get "/#{@key}#{path}", :basic_auth => {:username => @key, :password => @secret}
    response.parsed_response.merge("code" => response.code)          
  end

  def post(path, params = {})
    response = self.class.post "/#{@key}#{path}", 
      :body => params.to_json,
      :basic_auth => {:username => @key, :password => @secret}

    response.parsed_response.merge("code" => response.code)
  end


  # Create a user and returns its ID
  def create_user
    random_key = "#{Time.now.to_i}-#{(0...3).map { ('a'..'z').to_a[rand(26)] }.join}"

    response = self.post('/users/natural',
      :Email => "user-#{random_key}@host.tld",
      :FirstName => "User #{random_key}",
      :LastName => "User #{random_key}",
      :Birthday => Time.now.to_i,
      :Nationality => "FR",
      :CountryOfResidence => "FR"
    )

    return response["Id"]
  end


  # Create a web paying an returns its url
  def create_web_payin(opts)
    amount = opts[:amount]
    wallet_id = opts[:wallet_id]
    user_id = opts[:user_id]

    response = self.post(
      '/payins/card/web', 
      :AuthorId => user_id, 
      :DebitedFunds => {
        :Currency => 'EUR',
        :Amount => amount
      },
      :Fees => {
        :Currency => 'EUR',
        :Amount => 0
      }, 
      :CreditedWalletId => wallet_id,
      :ReturnURL => 'http://callback.url',
      :Culture => 'FR',
      :CardType => 'CB_VISA_MASTERCARD',
      :SecureMode => 'FORCE'
    )

    puts "Created web payin ##{response['Id']}"
    return response["RedirectURL"]
  end


end

require "neon_crm/configuration"
require "neon_crm/version"
require "net/http"

module NeonCrm
  #Get userSessionId
  def self.get_user_session_id
    config = NeonCrm::Configuration.new
    url = URI.parse("https://api.neoncrm.com/neonws/services/api/common/login?login.apiKey=#{config.api_key}&login.orgid=#{config.org_id}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    response = http.request(Net::HTTP::Get.new(url.request_uri))
    response_params = JSON.parse response.body
    user_session_id = response_params['loginResponse']['userSessionId']
  end

  #Create Account
  def self.create_account(opts = {})
    mappings = {"phone" => "individualAccount.primaryContact.phone1", "organization" => "individualAccount.organizationName",
                "address" => "individualAccount.primaryContact.addresses.address.addressLine1", "country" => "individualAccount.primaryContact.addresses.address.county",
                "city" => "individualAccount.primaryContact.addresses.address.city", "gender" => "individualAccount.primaryContact.gender.code",
                "source" => "individualAccount.source.name", "first_name" => "individualAccount.primaryContact.firstName",
                "last_name" => "individualAccount.primaryContact.lastName", "email" => "individualAccount.primaryContact.email1"}
    params = Hash[opts.map {|k, v| [mappings[k], v] }]
    params['responseType'] = 'json'
    params['userSessionId'] = get_user_session_id
    address_hash = {"individualAccount.primaryContact.addresses.address.isPrimaryAddress" => "true",
                    "individualAccount.primaryContact.addresses.address.isShippingAddress" => "false",
                    "individualAccount.primaryContact.addresses.address.addressType.id" => "1",
                    "individualAccount.primaryContact.addresses.address.addressType.name" => "Business"}
    params = params.merge(address_hash)
    url = URI.parse('https://api.neoncrm.com/neonws/services/api/account/createIndividualAccount')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(url.request_uri)
    request.set_form_data(params)
    response = http.request(request)
    response_params = JSON.parse response.body
    p response.body
    return false if response_params['createIndividualAccountResponse']['operationResult'] == "FAIL"
    true
  end
end

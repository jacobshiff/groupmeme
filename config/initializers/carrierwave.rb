# CarrierWave.configure do |config|
#   # config.fog_provider = 'fog/aws'                        # required
#   config.fog_credentials = {
#     provider:              'AWS',                        # required
#     aws_access_key_id:     ENV['s3_access_key_id'],                        # required
#     aws_secret_access_key: ENV['s3_secret_access_key'],                        # required
#     # region:                'us-east-1',                  # optional, defaults to 'us-east-1'
#     # host:                  's3.amazonaws.com',           # optional, defaults to nil
#     # endpoint:              's3.amazonaws.com' # optional, defaults to nil
#   }
#   config.fog_directory  = 'groupmeme'                          # required
#   config.fog_public     = false                                        # optional, defaults to true
#   config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # optional, defaults to {}
# end

# # Eventually move towards this language so can test locally
# # CarrierWave.configure do |config|
# #   if Rails.env.test?
# #     config.storage = :file
# #   else
# #     config.fog_provider = 'fog/aws'
# #     config.fog_credentials = {
# #       provider: 'AWS',
# #       aws_access_key_id: Rails.application.secrets.aws_access_key_id,
# #       aws_secret_access_key: Rails.application.secrets.aws_secret_access_key,
# #       region: Rails.application.secrets.s3_region
# #     }
# #     config.fog_directory = Rails.application.secrets.s3_bucket
# #     config.fog_attributes = {
# #       'Cache-Control' => "max-age=#{365.days.to_i}"
# #     }
# #     config.cache_dir = "#{::Rails.root}/tmp/uploads"
# #   end
# # end
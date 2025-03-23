require 'rdkafka' # gem 'rdkafka-ruby'
require 'tempfile'

if Rails.env.development?
  KAFKA_BROKER = 'localhost:9092'
  KAFKA_CONFIG['bootstrap.servers'] = KAFKA_BROKER
else
  ### Configuration for Heroku Kafka, details on the env variables are in the README
  KAFKA_GROUP_ID = ENV.fetch('KAFKA_PREFIX', '') + ENV.fetch('KAFKA_GROUP_ID')
  KAFKA_CONFIG = {}
  tmp_ca_file = Tempfile.new('ca_certs')
  tmp_ca_file.write(ENV.fetch('KAFKA_TRUSTED_CERT'))
  tmp_ca_file.close

  KAFKA_CONFIG['bootstrap.servers'] = ENV.fetch('KAFKA_URL').gsub('kafka+ssl://', '')
  KAFKA_CONFIG['security.protocol'] = 'ssl'
  KAFKA_CONFIG['ssl.ca.location'] = tmp_ca_file.path
  KAFKA_CONFIG['ssl.key.pem'] = ENV.fetch('KAFKA_CLIENT_CERT_KEY')
  KAFKA_CONFIG['ssl.certificate.pem'] = ENV.fetch('KAFKA_CLIENT_CERT')
  KAFKA_CONFIG['enable.ssl.certificate.verification'] = false
end
KAFKA_PRODUCER = Rdkafka::Config.new(KAFKA_CONFIG).producer
KAFKA_CONSUMER = Rdkafka::Config.new(KAFKA_CONFIG.merge({
                                                          "auto.offset.reset": 'earliest',
                                                          "group.id": KAFKA_GROUP_ID
                                                        })).consumer

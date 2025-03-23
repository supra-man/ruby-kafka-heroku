# SETUP KAFKA IN HEROKU USING RUBY

This repo is to help developers implement kafka in an application deployed in kafka using ```rdkafka-ruby``` gem.
### STEP 1:
Add the kafka.rb files in ```config/initializers```

### STEP 2:
Call the kafka producer using ```KAFKA_PRODUCER.produce(topic: "YOUR_TOPIC_NAME", payload: "Your Kafka Message")```

### STEP 3:
Run cosumer.rb to consume the messages

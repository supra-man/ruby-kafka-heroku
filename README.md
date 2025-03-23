# SETUP KAFKA IN HEROKU USING RUBY


### STEP 1:
Add the kafka.rb files in ```config/initializers```

### STEP 2:
Call the kafka producer using ```KAFKA_PRODUCER.produce(topic: "YOUR_TOPIC_NAME", payload: "Your Kafka Message")```

### STEP 3:
Run cosumer.rb to consume the messages

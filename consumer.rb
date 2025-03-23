def consume_message
  KAFKA_CONSUMER.each do |message|
    Rails.logger.info "Kafka Received received: #{message.payload} (offset: #{message.offset})"
  end
end

consume_message
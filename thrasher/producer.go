package main

import (
	"fmt"
	"sync"

	"github.com/Shopify/sarama"
)

var (
	testTopicPrefix = "thrasher_test"
	testBroker      = "127.0.0.1:9092"
)

func testProduce(topic string, limit int, wg *sync.WaitGroup) <-chan struct{} {
	var produceDone = make(chan struct{})
	p, err := sarama.NewAsyncProducer([]string{testBroker}, sarama.NewConfig())
	if err != nil {
		fmt.Println(err)
		return nil
	}

	go func() {
		defer close(produceDone)
		defer wg.Done()
		for i := 0; i < limit; i++ {
			msg := fmt.Sprintf(`{"userId":"%v","messageId":"random string"}`, i)
			fmt.Println(msg)
			msgBytes := sarama.StringEncoder(msg)
			if err != nil {
				fmt.Println(err)
				continue
			}
			select {
			case p.Input() <- &sarama.ProducerMessage{
				Topic: topic,
				Value: sarama.ByteEncoder(msgBytes),
			}:
			case err := <-p.Errors():
				fmt.Printf("Failed to send message to kafka, err: %s, msg: %s\n", err, msgBytes)
			}
		}
	}()

	return produceDone
}

func main() {
	wg := &sync.WaitGroup{}
	wg.Add(1)
	testProduce(testTopicPrefix, 10000, wg)
	wg.Wait()
}

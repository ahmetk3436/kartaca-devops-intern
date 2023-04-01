package main

import (
	"context"
	"encoding/json"
	"log"
	"math/rand"
	"net/http"
	"time"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

type City struct {
	CityName string `bson:"il_adi" json:"il_adi"`
}

func main() {
	clientOptions := options.Client().ApplyURI("mongodb://localhost:27021/?directConnection=true")
	client, err := mongo.Connect(context.Background(), clientOptions)
	if err != nil {
		log.Fatal(err)
	}
	ctx, cancel := context.WithTimeout(context.Background(), 30*time.Second)
	defer cancel()
	err = client.Ping(ctx, nil)
	if err != nil {
		log.Fatal(err)
	}
	db := client.Database("stajdb")
	collection := db.Collection("iller")

	rand.Seed(time.Now().UnixNano())
	router := http.NewServeMux()
	router.HandleFunc("/", hello)
	router.HandleFunc("/staj", func(w http.ResponseWriter, r *http.Request) {
		cities := []City{}
		cursor, err := collection.Find(context.Background(), bson.M{})
		if err != nil {
			log.Fatal(err)
		}
		defer cursor.Close(context.Background())
		for cursor.Next(context.Background()) {
			var city City
			if err := cursor.Decode(&city); err != nil {
				log.Fatal(err)
			}
			cities = append(cities, city)
		}
		if err := cursor.Err(); err != nil {
			log.Fatal(err)
		}
		randomCity := cities[rand.Intn(len(cities))]
		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(randomCity)
	})

	log.Fatal(http.ListenAndServe(":5555", router))
}

func hello(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("Hello Go!"))
}

# GRAPHQL API TWITTER CLI

This project was built using Ruby on Rails and GraphQl. The purpose was to create a GraphQl API gathering the data from the Twitter API; just for learning a bit of graphql and Rails :p. 

### Requirements:

* Ruby version ~> 2.6.3

* Rails version ~> 6.0.0

* Sqlite3 version ~> 3.24.0

### Configuration

### Installation

Run the next commands:

```
$ bundle install
```

Then proceed with:

```
$ rails s
```
The API will be hosted in http://localhost:3000 if you run it locally OR the heroku url will be in the description for performing requests.

### Queries examples

```
# Retrieving tweets
query {
    tweets(searchParam:"We sincerely hope this tweet was read in the language of HAS.", limit: 10) {
    results {
        id
        text
        date
        photoUrl
        photoShortUrl
        photoLinkTwitter
        videoUrl
        videoShortUrl
        videoLinkTwitter
        gifUrl
        gifShortUrl
        gifLinkTwitter
        likes
        rts
        textUrls {
          name
          content {
            displayUrl
            url
          }
        }
        hashtags {
          name
          content {
               text
          }
        }
    }
    totalTweets
    topHashtags
  }
}
```


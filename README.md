# pellect.io web frontend

## Status Check

/

Example

```shell
curl https://api-pellectio.appspot.com
```

Response

```json
{
    "status": "OK",
    "topic": "check.alive",
    "message": "OK",
    "timestamp": 1512373211
}
```

## Item Feed

/feed?s=#{category}&p=#{page}&n=#{size}

Example

```shell
curl https://api-pellectio.appspot.com/feed?s=book&p=1&n=3
```

Response

```json
[
    {
        "asin": "0141182601",
        "region": "DE",
        "title": "A Clockwork Orange (Penguin Modern Classics)",
        "summary": "Well, this book is not about milk ...",
        "tags": "book",
        "keywords": "",
        "stream": "book",
        "publish_date": 1501269813,
        "published": true,
        "image": {
            "url": "https://images-eu.ssl-images-amazon.com/images/I/41fCCWE%2BvBL._SL160_.jpg",
            "height": 160,
            "width": 104
        }
    },
    {
        "asin": "1451690312",
        "region": "DE",
        "title": "Fahrenheit 451: A Novel",
        "summary": "Give the people contests they win by remembering the words to more popular songs.... Don't give them slippery stuff like philosophy or sociology to tie things up with. That way lies melancholy.",
        "tags": "book",
        "keywords": "",
        "stream": "book",
        "publish_date": 1501269704,
        "published": true,
        "image": {
            "url": "https://images-eu.ssl-images-amazon.com/images/I/4126afOm8zL._SL160_.jpg",
            "height": 160,
            "width": 97
        }
    },
    {
        "asin": "1447221095",
        "region": "DE",
        "title": "Dirk Gently's Holistic Detective Agency",
        "summary": "What do a dead cat, a computer whiz-kid, an Electric Monk who believes the world is pink, quantum mechanics, a Chronologist over two hundred years old, Samuel Taylor Coleridge (poet), and pizza have in common?",
        "tags": "book",
        "keywords": "",
        "stream": "book",
        "publish_date": 1501255308,
        "published": true,
        "image": {
            "url": "https://images-eu.ssl-images-amazon.com/images/I/51NCtByp%2BlL._SL160_.jpg",
            "height": 160,
            "width": 106
        }
    }
]
```

## Get Item Details

/item/#{region}/#{asin}

Example

```shell
https://api-pellectio.appspot.com/item/DE/0099908808
```

Response

```json
{
    "asin": "0099908808",
    "region": "DE",
    "title": "The Snows Of Kilimanjaro And Other Stories (Roman)",
    "review": "Presents Hemingway stories, in which men and women of passion live, fight, love and die in scenes of dramatic intensity. They range from the haunting tragedy on the snow-capped peak of Kilimanjaro, to brutal America with its deceptive calm, and war-ravaged Europe.",
    "formatted_price": "EUR 6,99",
    "price": 699,
    "currency": "EUR",
    "sales_rank": 21317,
    "group": "book",
    "related": [
        {
            "asin": "0099908603",
            "region": "DE",
            "title": "For Whom The Bell Tolls",
            "image": {
                "url": "https://images-eu.ssl-images-amazon.com/images/I/51gTvUm6VjL._SL160_.jpg",
                "height": 160,
                "width": 99
            }
        },
        {
            "asin": "0099908409",
            "region": "DE",
            "title": "The Old Man and the Sea",
            "image": {
                "url": "https://images-eu.ssl-images-amazon.com/images/I/51GDabp6SXL._SL160_.jpg",
                "height": 160,
                "width": 99
            }
        }
    ],
    "summary": "\nPresents Hemingway stories, in which men and women of passion live, fight, love and die in scenes of dramatic intensity\n",
    "affiliate_url": "https://www.amazon.de/dp/0099908808/?tag=ptio-21",
    "image": {
        "url": "https://images-eu.ssl-images-amazon.com/images/I/51GnPnVtqRL.jpg",
        "height": 500,
        "width": 309
    }
}
```


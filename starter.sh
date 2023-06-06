#!/bin/bash

# Post user
URL="http://localhost:8084/superapp/users"
REQUEST_BODY='{
    "email": "daniel@gmail.com",
    "username": "danie_ben_avi",
    "role": "SUPERAPP_USER",
    "avatar": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQn6_7Rjd6cnCGyX8Cc9BxkI2R2uCsno_Q45SAvG1sYMg&s"
}'
curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d "$REQUEST_BODY" "$URL"



# Post user details
URL="http://localhost:8084/superapp/objects?userSuperapp=2023b.LiorAriely&userEmail=daniel@gmail.com"
REQUEST_BODY='{
    "objectId": {},
    "type": "USER_DETAILS",
    "alias": "USER_DETAILS",
    "active": true,
    "location": {
        "lat": 10.200,
        "lng": 10.200
    },
    "createdBy": {
        "userId": {
            "superapp": "2023b.LiorAriely",
            "email": "daniel@gmail.com"
        }
    },
    "objectDetails": {
        "name": "Danie Ben Avi",
        "phoneNum": "+972543298411",
        "preferences": [
            "Anime",
            "Tennis"
        ]
    }
}'
curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d "$REQUEST_BODY" "$URL"



# Post Demo object
URL="localhost:8084/superapp/objects?userSuperapp=2023b.LiorAriely&userEmail=daniel@gmail.com"
REQUEST_BODY='{
    "objectId": {},
    "type": "DEFAULT",
    "alias": "OBJECT_FOR_COMMAND_WITHOUT_TARGET_OBJECT",
    "active": true,
    "location": {
        "lat": 10.200,
        "lng": 10.200
    },
    "createdBy": {
        "userId": {
            "superapp": "2023b.LiorAriely",
            "email": "daniel@gmail.com"
        }
    },
    "objectDetails": {}
}'

# Make the POST request
curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d "$REQUEST_BODY" "$URL"



URL="localhost:8084/superapp/objects?userSuperapp=2023b.LiorAriely&userEmail=daniel@gmail.com"
REQUEST_BODY='{
    "objectId": {},
    "type": "PRODUCT",
    "alias": "PRODUCT",
    "active": true,
    "location": {
        "lat": 10.200,
        "lng": 10.200
    },
    "createdBy": {
        "userId": {
            "superapp": "2023b.LiorAriely",
            "email": "daniel@gmail.com"
        }
    },
    "objectDetails": {
        "name": "Camera",
        "image": "https://www.fujifilm.co.il/wp-content/uploads/2019/02/XT30.jpg",
        "description": "Fujifilm xt30",
        "contact":"+972543298411",
        "price": 699.99,
        "preferences": [
            "Photography"
        ]
    }
    }'
curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d "$REQUEST_BODY" "$URL"

 
URL="localhost:8084/superapp/objects?userSuperapp=2023b.LiorAriely&userEmail=daniel@gmail.com"
REQUEST_BODY='{
    "objectId": {},
    "type": "PRODUCT",
    "alias": "PRODUCT",
    "active": true,
    "location": {
        "lat": 10.200,
        "lng": 10.200
    },
    "createdBy": {
        "userId": {
            "superapp": "2023b.LiorAriely",
            "email": "daniel@gmail.com"
        }
    },
    "objectDetails": {
        "name": "Anime book",
        "image": "https://upload.wikimedia.org/wikipedia/en/a/a3/One_Piece%2C_Volume_1.jpg",
        "description": "One Piece chapter 1",
        "contact":"+972543298411",
        "price": 99.99,
        "preferences": [
            "Anime"
        ]
    }
    
}'
curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d "$REQUEST_BODY" "$URL"

URL="localhost:8084/superapp/objects?userSuperapp=2023b.LiorAriely&userEmail=daniel@gmail.com"
REQUEST_BODY='    "objectId": {},
    "type": "PRODUCT",
    "alias": "PRODUCT",
    "active": true,
    "location": {
        "lat": 10.200,
        "lng": 10.200
    },
    "createdBy": {
        "userId": {
            "superapp": "2023b.LiorAriely",
            "email": "daniel@gmail.com"
        }
    },
    "objectDetails": {
        "name": "Hiking boots",
        "image": "https://www.switchbacktravel.com/sites/default/files/articles%20/Hiking%20Boots%20%28Lowa%20Renegade%20GTX%20on%20rock%29%20%28m%29.jpg",
        "description": "New Hiking boots",
        "contact":"+972543298411",
        "price": 1999.49,
        "preferences": [
            "Anime"
        ]
    }
}'
curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d "$REQUEST_BODY" "$URL"

URL="localhost:8084/superapp/objects?userSuperapp=2023b.LiorAriely&userEmail=daniel@gmail.com"
REQUEST_BODY='{
    "objectId": {},
    "type": "EVENT",
    "alias": "EVENT",
    "active": true,
    "location": {
        "lat": 10.200,
        "lng": 10.200
    },
    "createdBy": {
        "userId": {
            "superapp": "2023b.LiorAriely",
            "email": "daniel@gmail.com"
        }
    },
    "objectDetails": {
        "name": "Tennis tournament",
        "date" : 1688101200000,
        "location":"Tennis court reut",
        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRv7AmZgql_nTl_LSMaJ4pk8U4uGqZQomwW4ga3O1FcFN-av92YYIXWacg8oe075DcymAs&usqp=CAU",
        "description": "A Tennis tournament in reut Tennis court. \nWinning prize of 1000$",
        "contact":"+972543298411",
        "preferences": [
            "Tennis"
        ],
        "attendees":["daniel@gmail.com"]
    }
}'
curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d "$REQUEST_BODY" "$URL"


URL="localhost:8084/superapp/objects?userSuperapp=2023b.LiorAriely&userEmail=daniel@gmail.com"
REQUEST_BODY='{
    "objectId": {},
    "type": "EVENT",
    "alias": "EVENT",
    "active": true,
    "location": {
        "lat": 10.200,
        "lng": 10.200
    },
    "createdBy": {
        "userId": {
            "superapp": "2023b.LiorAriely",
            "email": "daniel@gmail.com"
        }
    },
    "objectDetails": {
        "name": "Anime watching",
        "date" : 1690707600000,
        "location":"Tel-Aviv University",
        "image": "https://assets-prd.ignimgs.com/2022/08/17/top25animecharacters-blogroll-1660777571580.jpg",
        "description": "An Anime watching event",
        "contact":"+972543298411",
        "preferences": [
            "Anime"
        ],
        "attendees":[]
    }
}'
curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d "$REQUEST_BODY" "$URL"

URL="localhost:8084/superapp/objects?userSuperapp=2023b.LiorAriely&userEmail=daniel@gmail.com"
REQUEST_BODY='{
    "objectId": {},
    "type": "EVENT",
    "alias": "EVENT",
    "active": true,
    "location": {
        "lat": 10.200,
        "lng": 10.200
    },
    "createdBy": {
        "userId": {
            "superapp": "2023b.LiorAriely",
            "email": "daniel@gmail.com"
        }
    },
    "objectDetails": {
        "name": "Anime lesson",
        "date" : 1688115600000,
        "location":"Tel-Aviv University",
        "image": "https://assets-prd.ignimgs.com/2022/08/17/top25animecharacters-blogroll-1660777571580.jpg",
        "description": "An Anime watching event",
        "contact":"+972543298411",
        "preferences": [
            "Anime", "Art"
        ],
        "attendees":["daniel@gmail.com"]
    }
}'
curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d "$REQUEST_BODY" "$URL"

URL="localhost:8084/superapp/objects?userSuperapp=2023b.LiorAriely&userEmail=daniel@gmail.com"
REQUEST_BODY='{
    "objectId": {},
    "type": "EVENT",
    "alias": "EVENT",
    "active": true,
    "location": {
        "lat": 10.200,
        "lng": 10.200
    },
    "createdBy": {
        "userId": {
            "superapp": "2023b.LiorAriely",
            "email": "daniel@gmail.com"
        }
    },
    "objectDetails": {
        "name": "Acting class",
        "date" : 1672592400000,
        "location":"Tel-Aviv University",
        "image": "https://www.usnews.com/dims4/USNEWS/0e1873c/2147483647/crop/1998x1333+0+0/resize/970x647/quality/85/?url=https%3A%2F%2Fwww.usnews.com%2Fcmsmedia%2Fe2%2F7f%2Fb9f8dce24147b0b536fe7b91df60%2F200928-actingschool-stock.jpg",
        "description": "An Anime watching event",
        "contact":"+972543298411",
        "preferences": [
            "Acting"
        ],
        "attendees":["daniel@gmail.com"]
    }
}
'
curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d "$REQUEST_BODY" "$URL"
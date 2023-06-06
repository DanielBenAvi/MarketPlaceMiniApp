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

# Post user
USER_URL="http://localhost:8084/superapp/users"
USER_REQUEST_BODY='{
    "_id": "2023b.LiorAriely_demo2@gmail.com",
    "role": "SUPERAPP_USER",
    "userName": "demo2",
    "avatar": "https://firebasestorage.googleapis.com/v0/b/social-hive-places.appspot.com/o/files%2F3854991.png?alt=media&token=8dae5aa6-a518-407e-9b9f-879f92134add",
    "_class": "superapp.data.UserEntity"
}'
USER_RESPONSE=$(curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d "$USER_REQUEST_BODY" "$USER_URL")

# Post user details
USER_DETAILS_URL="http://localhost:8084/superapp/objects?userSuperapp=2023b.LiorAriely&userEmail=demo2@gmail.com"
USER_DETAILS_REQUEST_BODY='{
    "objectId": {},
    "type": "USER_DETAILS",
    "alias": "userDetails",
    "active": true,
    "location": {
        "x": 10,
        "y": 11
    },
    "createdBy": "2023b.LiorAriely_demo2@gmail.com",
    "objectDetails": {
        "name": "demo2",
        "phoneNum": "123123213",
        "preferences": [
            "Acroyoga",
            "Acting"
        ]
    }
}'
USER_DETAILS_RESPONSE=$(curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d "$USER_DETAILS_REQUEST_BODY" "$USER_DETAILS_URL")

# Extract user details object ID
USER_DETAILS_OBJECT_ID=$(echo "$USER_DETAILS_RESPONSE" | jq -r '._id')

# Post private dating profile
PRIVATE_PROFILE_URL="http://localhost:8084/superapp/objects?userSuperapp=2023b.LiorAriely&userEmail=demo2@gmail.com"
PRIVATE_PROFILE_REQUEST_BODY='{
    "objectId": {},
    "type": "PRIVATE_DATING_PROFILE",
    "alias": "privateDatingProfile",
    "active": true,
    "location": {
        "x": 10,
        "y": 10
    },
    "createdBy": "2023b.LiorAriely_demo2@gmail.com",
    "objectDetails": {
        "publicProfile": {
            "nickName": "demo2",
            "gender": "FEMALE",
            "age": 23,
            "bio": "demo2 bio",
            "pictures": [
                "https://firebasestorage.googleapis.com/v0/b/social-hive-places.appspot.com/o/files%2F3854991.png?alt=media&token=8dae5aa6-a518-407e-9b9f-879f92134add"
            ]
        },
        "dateOfBirthday": "1999-06-16T00:00:00.000",
        "phoneNumber": "123123213",
        "distanceRange": 100,
        "maxAge": 48,
        "minAge": 18,
        "genderPreferences": [
            "MALE",
            "FEMALE"
        ],
        "matches": [],
        "likes": []
    }
}'

# Make the POST request to create the private dating profile
PRIVATE_PROFILE_RESPONSE=$(curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d "$PRIVATE_PROFILE_REQUEST_BODY" "$PRIVATE_PROFILE_URL")
PRIVATE_PROFILE_OBJECT_ID=$(echo "$PRIVATE_PROFILE_RESPONSE" | jq -r '._id')

# Update the user details with the private dating profile child
USER_DETAILS_CHILD_URL="http://localhost:8084/superapp/objects/$USER_DETAILS_OBJECT_ID/children"
USER_DETAILS_CHILD_REQUEST_BODY='{
    "$ref": "OBJECTS",
    "$id": "'"$PRIVATE_PROFILE_OBJECT_ID"'"
}'

# Make the PUT request to add the private dating profile as a child of the user details
curl -X PUT -H "Content-Type: application/json" -H "Accept: application/json" -d "$USER_DETAILS_CHILD_REQUEST_BODY" "$USER_DETAILS_CHILD_URL"

# Post user 1
USER_URL="http://localhost:8084/superapp/users"
USER_REQUEST_BODY='{
    "_id": "2023b.LiorAriely_demo2@gmail.com",
    "role": "SUPERAPP_USER",
    "userName": "demo2",
    "avatar": "https://www.shutterstock.com/image-vector/avatar-redhaired-woman-portrait-young-600w-2078932504.jpg"
}'
USER_RESPONSE=$(curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d "$USER_REQUEST_BODY" "$USER_URL")

# Post user details 1
USER_DETAILS_URL="http://localhost:8084/superapp/objects?userSuperapp=2023b.LiorAriely&userEmail=demo2@gmail.com"
USER_DETAILS_REQUEST_BODY='{
    "objectId": {},
    "type": "USER_DETAILS",
    "alias": "userDetails",
    "active": true,
    "location": {
        "x": 10,
        "y": 11
    },
    "createdBy": "2023b.LiorAriely_demo2@gmail.com",
    "objectDetails": {
        "name": "demo2",
        "phoneNum": "123123213",
        "preferences": [
            "Acroyoga",
            "Acting"
        ]
    }
}'
USER_DETAILS_RESPONSE=$(curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d "$USER_DETAILS_REQUEST_BODY" "$USER_DETAILS_URL")

# Extract user details 1 object ID
USER_DETAILS_OBJECT_ID=$(echo "$USER_DETAILS_RESPONSE" | jq -r '._id')

# Post private dating profile 1
PRIVATE_PROFILE_URL="http://localhost:8084/superapp/objects?userSuperapp=2023b.LiorAriely&userEmail=demo2@gmail.com"
PRIVATE_PROFILE_REQUEST_BODY='{
    "objectId": {},
    "type": "PRIVATE_DATING_PROFILE",
    "alias": "privateDatingProfile",
    "active": true,
    "location": {
        "x": 10,
        "y": 10
    },
    "createdBy": "2023b.LiorAriely_demo2@gmail.com",
    "objectDetails": {
        "publicProfile": {
            "nickName": "demo2",
            "gender": "FEMALE",
            "age": 23,
            "bio": "demo2 bio",
            "pictures": [
                "https://www.shutterstock.com/image-vector/avatar-redhaired-woman-portrait-young-600w-2078932504.jpg"
            ]
        },
        "dateOfBirthday": "1999-06-16T00:00:00.000",
        "phoneNumber": "123123213",
        "distanceRange": 100,
        "maxAge": 48,
        "minAge": 18,
        "genderPreferences": [
            "MALE",
            "FEMALE"
        ],
        "matches": [],
        "likes": []
    }
}'

# Make the POST request to create private dating profile 1
PRIVATE_PROFILE_RESPONSE=$(curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d "$PRIVATE_PROFILE_REQUEST_BODY" "$PRIVATE_PROFILE_URL")
PRIVATE_PROFILE_OBJECT_ID=$(echo "$PRIVATE_PROFILE_RESPONSE" | jq -r '._id')

# Update user details 1 with the private dating profile 1 child
USER_DETAILS_CHILD_URL="http://localhost:8084/superapp/objects/$USER_DETAILS_OBJECT_ID/children"
USER_DETAILS_CHILD_REQUEST_BODY='{
    "$ref": "OBJECTS",
    "$id": "'"$PRIVATE_PROFILE_OBJECT_ID"'"
}'

# Make the PUT request to add private dating profile 1 as a child of user details 1
curl -X PUT -H "Content-Type: application/json" -H "Accept: application/json" -d "$USER_DETAILS_CHILD_REQUEST_BODY" "$USER_DETAILS_CHILD_URL"

# Post user 2
USER_REQUEST_BODY='{
    "_id": "2023b.LiorAriely_demo3@gmail.com",
    "role": "SUPERAPP_USER",
    "userName": "demo3",
    "avatar": "https://st4.depositphotos.com/29453910/37778/v/1600/depositphotos_377785328-stock-illustration-hand-drawn-modern-woman-avatar.jpg"
}'
USER_RESPONSE=$(curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d "$USER_REQUEST_BODY" "$USER_URL")

# Post user details 2
USER_DETAILS_URL="http://localhost:8084/superapp/objects?userSuperapp=2023b.LiorAriely&userEmail=demo3@gmail.com"
USER_DETAILS_REQUEST_BODY='{
    "objectId": {},
    "type": "USER_DETAILS",
    "alias": "userDetails",
    "active": true,
    "location": {
        "x": 10,
        "y": 11
    },
    "createdBy": "2023b.LiorAriely_demo3@gmail.com",
    "objectDetails": {
        "name": "demo3",
        "phoneNum": "987654321",
        "preferences": [
            "Yoga",
            "Cooking"
        ]
    }
}'
USER_DETAILS_RESPONSE=$(curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d "$USER_DETAILS_REQUEST_BODY" "$USER_DETAILS_URL")

# Extract user details 2 object ID
USER_DETAILS_OBJECT_ID=$(echo "$USER_DETAILS_RESPONSE" | jq -r '._id')

# Post private dating profile 2
PRIVATE_PROFILE_URL="http://localhost:8084/superapp/objects?userSuperapp=2023b.LiorAriely&userEmail=demo3@gmail.com"
PRIVATE_PROFILE_REQUEST_BODY='{
    "objectId": {},
    "type": "PRIVATE_DATING_PROFILE",
    "alias": "privateDatingProfile",
    "active": true,
    "location": {
        "x": 10,
        "y": 10
    },
    "createdBy": "2023b.LiorAriely_demo3@gmail.com",
    "objectDetails": {
        "publicProfile": {
            "nickName": "demo3",
            "gender": "MALE",
            "age": 25,
            "bio": "demo3 bio",
            "pictures": [
                "https://st4.depositphotos.com/29453910/37778/v/1600/depositphotos_377785328-stock-illustration-hand-drawn-modern-woman-avatar.jpg"
            ]
        },
        "dateOfBirthday": "1997-05-21T00:00:00.000",
        "phoneNumber": "987654321",
        "distanceRange": 80,
        "maxAge": 40,
        "minAge": 20,
        "genderPreferences": [
            "FEMALE"
        ],
        "matches": [],
        "likes": []
    }
}'

# Make the POST request to create private dating profile 2
PRIVATE_PROFILE_RESPONSE=$(curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d "$PRIVATE_PROFILE_REQUEST_BODY" "$PRIVATE_PROFILE_URL")
PRIVATE_PROFILE_OBJECT_ID=$(echo "$PRIVATE_PROFILE_RESPONSE" | jq -r '._id')

# Update user details 2 with the private dating profile 2 child
USER_DETAILS_CHILD_URL="http://localhost:8084/superapp/objects/$USER_DETAILS_OBJECT_ID/children"
USER_DETAILS_CHILD_REQUEST_BODY='{
    "$ref": "OBJECTS",
    "$id": "'"$PRIVATE_PROFILE_OBJECT_ID"'"
}'

# Make the PUT request to add private dating profile 2 as a child of user details 2
curl -X PUT -H "Content-Type: application/json" -H "Accept: application/json" -d "$USER_DETAILS_CHILD_REQUEST_BODY" "$USER_DETAILS_CHILD_URL"

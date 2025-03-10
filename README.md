# PetConnect

## Database Entity Relation Diagram

```mermaid
erDiagram
    User ||--o{ Shelter : owns
    User ||--o{ ShelterMember : "is member of"
    User ||--o{ Pet : creates
    User ||--o{ Bookmark : has
    User ||--o{ Message : sends
    User }|--o{ Message : receives
    User ||--o{ ShelterMessageAssignment : "is assigned"
    User ||--o| AvatarImage : has

    Shelter ||--o{ ShelterMember : has
    Shelter ||--o{ Pet : houses
    Shelter ||--o{ Message : "receives via"
    Shelter ||--o| AvatarImage : has
    Shelter ||--o{ Address : has

    Pet ||--o{ PetImage : has
    Pet ||--o{ Bookmark : "is bookmarked in"

    Image ||--o| AvatarImage : "is used in"
    Image ||--o| PetImage : "is used in"

    Message ||--o| ShelterMessageAssignment : "is assigned in"

    User {
        String id PK "UUID"
        String firstName
        String lastName
        String username "UNIQUE"
        String email "UNIQUE"
        String passwordHash
        String avatarImageId FK "UUID, UNIQUE"
        DateTime createdAt
    }

    Shelter {
        String id PK "UUID"
        String name
        String description
        String phone
        String email
        String website
        String ownerId FK "UUID"
        String avatarImageId FK "UUID, UNIQUE"
        String addressId FK "UUID"
        DateTime createdAt
    }

    Address {
        String id PK "UUID"
        String shelterId FK "UUID"
        String address1
        String address2
        String formattedAddress
        String city
        String region
        String postalCode
        String country
        Float lat
        Float lng
        DateTime createdAt
    }

    ShelterMember {
        String shelterId PK,FK "UUID"
        String userId PK,FK "UUID"
        DateTime joinedAt
    }

    Pet {
        String id PK "UUID"
        String name
        String description
        String species
        String breed
        String gender
        DateTime birthDate
        PetStatus status "ENUM"
        String createdByUserId FK "UUID"
        String shelterId FK "UUID"
        DateTime createdAt
    }

    Image {
        String id PK "UUID"
        String url
        String key "UNIQUE"
        String bucket
        String fileType
        BigInt fileSize
        DateTime uploadedAt
    }

    AvatarImage {
        String id PK "UUID"
        String imageId FK "UUID, UNIQUE"
        DateTime createdAt
    }

    PetImage {
        String id PK "UUID"
        String petId FK "UUID"
        String imageId FK "UUID, UNIQUE"
        Boolean isPrimary
        DateTime createdAt
    }

    Bookmark {
        String userId PK,FK "UUID"
        String petId PK,FK "UUID"
        DateTime createdAt
    }

    Message {
        String id PK "UUID"
        String senderId FK "UUID"
        String receiverId FK "UUID"
        String content
        Boolean isRead
        String shelterId FK "UUID"
        DateTime sentAt
    }

    ShelterMessageAssignment {
        String messageId PK,FK "UUID"
        String userId FK "UUID"
        DateTime assignedAt
    }
```

```plantuml
@startuml ER Diagram

entity "User" {
  *id : UUID <<PK>>
  --
  firstName : VARCHAR(100)
  lastName : VARCHAR(100)
  username : VARCHAR(50) <<unique>>
  email : VARCHAR(100) <<unique>>
  passwordHash : VARCHAR(255)
  avatarImageId : UUID <<FK>>
  createdAt : DateTime
}

entity "Shelter" {
  *id : UUID <<PK>>
  --
  name : VARCHAR(100)
  description : TEXT
  phone : VARCHAR
  email : VARCHAR
  website : VARCHAR
  ownerId : UUID <<FK>>
  avatarImageId : UUID <<FK>>
  addressId : UUID <<FK>>
  createdAt : DateTime
}

entity "Address" {
  *id : UUID <<PK>>
  --
  shelterId : UUID <<FK>>
  address1 : VARCHAR(255)
  address2 : VARCHAR(255)
  formattedAddress : VARCHAR(255)
  city : VARCHAR(100)
  region : VARCHAR(100)
  postalCode : VARCHAR(20)
  country : VARCHAR(100)
  lat : Float
  lng : Float
  createdAt : DateTime
}

entity "ShelterMember" {
  *shelterId : UUID <<PK,FK>>
  *userId : UUID <<PK,FK>>
  --
  joinedAt : DateTime
}

entity "Pet" {
  *id : UUID <<PK>>
  --
  name : VARCHAR(50)
  description : TEXT
  species : VARCHAR(50)
  breed : VARCHAR(50)
  gender : VARCHAR(50)
  birthDate : DateTime
  status : ENUM(AVAILABLE, ADOPTED, PENDING)
  createdByUserId : UUID <<FK>>
  shelterId : UUID <<FK>>
  createdAt : DateTime
}

entity "Image" {
  *id : UUID <<PK>>
  --
  url : VARCHAR(255)
  key : VARCHAR(255) <<unique>>
  bucket : VARCHAR(100)
  fileType : VARCHAR(50)
  fileSize : BigInt
  uploadedAt : DateTime
}

entity "AvatarImage" {
  *id : UUID <<PK>>
  --
  imageId : UUID <<FK>>
  createdAt : DateTime
}

entity "PetImage" {
  *id : UUID <<PK>>
  --
  petId : UUID <<FK>>
  imageId : UUID <<FK>>
  isPrimary : Boolean
  createdAt : DateTime
}

entity "Bookmark" {
  *userId : UUID <<PK,FK>>
  *petId : UUID <<PK,FK>>
  --
  createdAt : DateTime
}

entity "Message" {
  *id : UUID <<PK>>
  --
  senderId : UUID <<FK>>
  receiverId : UUID <<FK>>
  content : TEXT
  isRead : Boolean
  shelterId : UUID <<FK>>
  sentAt : DateTime
}

entity "ShelterMessageAssignment" {
  *messageId : UUID <<PK,FK>>
  --
  userId : UUID <<FK>>
  assignedAt : DateTime
}

' Relationships
User ||--o{ Shelter : "owns"
User ||--o{ Pet : "creates"
User ||--o{ Message : "sends"
User ||--o{ Message : "receives"
User ||--o{ ShelterMember : "member of"
User ||--o{ Bookmark : "bookmarks"
User ||--o{ ShelterMessageAssignment : "assigned to"
User ||--o| AvatarImage : "has avatar"

Shelter ||--o{ ShelterMember : "has members"
Shelter ||--o{ Pet : "owns"
Shelter ||--o{ Message : "related to"
Shelter ||--o{ Address : "located at"
Shelter ||--o| AvatarImage : "has avatar"

Pet ||--o{ PetImage : "has images"
Pet ||--o{ Bookmark : "bookmarked by"

Image ||--o| AvatarImage : "used as"
Image ||--o| PetImage : "used as"

Message ||--o| ShelterMessageAssignment : "assigned"

@enduml
```

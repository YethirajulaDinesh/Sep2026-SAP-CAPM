// namespace poapplication;

// using { managed  } from '@sap/cds/common';

// entity Albums : managed {
//     key ID      : Integer;
//     title       : String(120);
//     description : String(255);
//     viewCount   : Integer;

//     photos      : Association to many Photos
//                     on photos.album = $self;
// }

// entity Locations : managed {
//     key ID      : Integer;
//     name        : String(200);
//     shortName   : String(50);

//     photos      : Association to many Photos
//                     on photos.location = $self;
// }

// entity Members : managed {
//     key ID      : Integer;
//     name        : String(255);
//     phoneNum    : String(20);
//     email       : String(200);
//     address     : String(255);

//     photos      : Association to many Photos
//                     on photos.member = $self;
// }

// entity Photos : managed {
//     key ID          : Integer;

//     album           : Association to Albums;
//     location        : Association to Locations;
//     member          : Association to Members;

//     title           : String(120);
//     description     : String(255);
//     privacy         : String(20);
//     uploadDate      : Date;
//     viewCount       : Integer;
//     imagePath       : String(50);

//     comments        : Association to many Comments
//                         on comments.photo = $self;

//     tags            : Association to many TagPhotos
//                         on tags.photo = $self;
// }

// entity Comments : managed {
//     key ID          : Integer;

//     photo           : Association to Photos;

//     postDate        : Date;
//     content         : String(255);
// }

// entity Tags : managed {
//     key ID          : Integer;
//     title           : String(120);

//     photoLinks      : Association to many TagPhotos
//                         on photoLinks.tag = $self;
// }

// entity TagPhotos : managed {
//     key ID          : Integer;

//     tag             : Association to Tags;
//     photo           : Association to Photos;
// }
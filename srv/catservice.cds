// using { poapplication as db } from '../db/schema3';

// service CatalogService {

//     entity Albums     as projection on db.Albums;
//     entity Locations  as projection on db.Locations;
//     entity Members    as projection on db.Members;
//     entity Photos     as projection on db.Photos;
//     entity Comments   as projection on db.Comments;
//     entity Tags       as projection on db.Tags;
//     entity TagPhotos  as projection on db.TagPhotos;

//     // Album Actions
//     action createAlbum(
//         title       : String,
//         description : String
//     ) returns String;

//     action deleteAlbum(
//         ID : Integer
//     ) returns String;

//     // Member Actions
//     action createMember(
//         name      : String,
//         phoneNum  : String,
//         email     : String,
//         address   : String
//     ) returns String;

//     action deleteMember(
//         ID : Integer
//     ) returns String;

//     // Location Actions
//     action createLocation(
//         name      : String,
//         shortName : String
//     ) returns String;

//     action deleteLocation(
//         ID : Integer
//     ) returns String;

//     // Photo Actions
//     action createPhoto(
//         albumID     : Integer,
//         locationID  : Integer,
//         memberID    : Integer,
//         title       : String,
//         description : String,
//         privacy     : String,
//         imagePath   : String
//     ) returns String;

//     action deletePhoto(
//         ID : Integer
//     ) returns String;

//     action updatePhotoViews(
//         ID        : Integer,
//         viewCount : Integer
//     ) returns String;

//     // Comment Actions
//     action addComment(
//         photoID : Integer,
//         content : String
//     ) returns String;

//     action deleteComment(
//         ID : Integer
//     ) returns String;

//     // Tag Actions
//     action createTag(
//         title : String
//     ) returns String;

//     action assignTagToPhoto(
//         tagID   : Integer,
//         photoID : Integer
//     ) returns String;

//     action removeTagFromPhoto(
//         tagID   : Integer,
//         photoID : Integer
//     ) returns String;
// }

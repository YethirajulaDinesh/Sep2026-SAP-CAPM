// const cds = require('@sap/cds');

// module.exports = cds.service.impl(async function () {

//     const {
//         popdata
//     } = this.entities;

//     // Create Album
//     this.on('createAlbum', async (req) => {
//         const { title, description } = req.data;

//         await INSERT.into(Albums).entries({
//            popdata
//         });

//         return req.data;
//     });

//     // Delete Album
//     this.on('deleteAlbum', async (req) => {
//         const { ID } = req.data;

//         await DELETE.from(Albums).where({ ID });

//         return 'Album deleted successfully';
//     });

//     // Create Member
//     this.on('createMember', async (req) => {

//         const {popdata } = req.data;

//         await INSERT.into(Members).entries({
//             popdata
//         });

//         return 'Member created successfully';
//     });

//     // Delete Member
//     this.on('deleteMember', async (req) => {

//         const { ID } = req.data;

//         await DELETE.from(Members).where({ ID });

//         return 'Member deleted successfully';
//     });

//     // Create Location
//     this.on('createLocation', async (req) => {

//         const { name, shortName } = req.data;

//         await INSERT.into(Locations).entries({
//             name,
//             shortName
//         });

//         return 'Location created successfully';
//     });

//     // Delete Location
//     this.on('deleteLocation', async (req) => {

//         const { ID } = req.data;

//         await DELETE.from(Locations).where({ ID });

//         return 'Location deleted successfully';
//     });

//     // Create Photo
//     this.on('createPhoto', async (req) => {

//         const {
//             albumID,
//             locationID,
//             memberID,
//             title,
//             description,
//             privacy,
//             imagePath
//         } = req.data;

//         await INSERT.into(Photos).entries({
//             album_ID: albumID,
//             location_ID: locationID,
//             member_ID: memberID,
//             title,
//             description,
//             privacy,
//             uploadDate: new Date(),
//             viewCount: 0,
//             imagePath
//         });

//         return 'Photo created successfully';
//     });

//     // Delete Photo
//     this.on('deletePhoto', async (req) => {

//         const { ID } = req.data;

//         await DELETE.from(Photos).where({ ID });

//         return 'Photo deleted successfully';
//     });

//     // Update Photo Views
//     this.on('updatePhotoViews', async (req) => {

//         const { ID, viewCount } = req.data;

//         await UPDATE(Photos)
//             .set({ viewCount })
//             .where({ ID });

//         return req.data;
//     });

//     // Add Comment
//     this.on('addComment', async (req) => {

//         const { photoID, content } = req.data;

//         await INSERT.into(Comments).entries({
//             photo_ID: photoID,
//             postDate: new Date(),
//             content
//         });

//         return 'Comment added successfully';
//     });

//     // Delete Comment
//     this.on('deleteComment', async (req) => {

//         const { ID } = req.data;

//         await DELETE.from(Comments).where({ ID });

//         return 'Comment deleted successfully';
//     });

//     // Create Tag
//     this.on('createTag', async (req) => {

//         const { title } = req.data;

//         await INSERT.into(Tags).entries({
//             title
//         });

//         return 'Tag created successfully';
//     });

//     // Assign Tag To Photo
//     this.on('assignTagToPhoto', async (req) => {

//         const { tagID, photoID } = req.data;

//         await INSERT.into(TagPhotos).entries({
//             tag_ID: tagID,
//             photo_ID: photoID
//         });

//         return 'Tag assigned to photo successfully';
//     });

//     // Remove Tag From Photo
//     this.on('removeTagFromPhoto', async (req) => {

//         const { tagID, photoID } = req.data;

//         await DELETE.from(TagPhotos)
//             .where({
//                 tag_ID: tagID,
//                 photo_ID: photoID
//             });

//         return 'Tag removed from photo successfully';
//     });

// });
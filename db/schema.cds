/* namespace poapplication.db;
 

//syntax for identifier 
//type ![EmployeeName] : String(50);

type nameStr : String(50);
type nameInt : Integer;

using { poappliation.common as common } from './common';
using { managed, temporal } from '@sap/cds/common';

entity students : common.adress , common.feeasp , managed, temporal {
    key studentID: nameInt;
    studentUName: common.nameStr;
    fatherName: common.nameStr;
    motherName: common.nameStr;
    contactNo: common.PhoneNumber; 
    email: common.Email;
    Gender : common.Gender; 
    Status : common.status;
    abc: Association to one classes;
    lib: Association to many library on lib.parent=$self;
}
 
entity classes : managed, temporal{
     key classid : Integer;
     className : common.nameStr;
     teacherName : common.nameStr;
}

entity library : managed, temporal{
    key bookId: nameInt;
    bookName:nameStr;
    author:nameStr;
    date_of_issue: Date;
    studentName: nameStr;
    returnDate:Date;
    parent: Association to students;
}
 
 

entity Employees{
    employeeId:Integer;
    employeeName:String(50);
    salary:String(10);
    department:String(50);
    currencyCode:String(100);
    city:String(100);
    country:String(100);
    division:Association to one Divisions;
 
 
 }
 entity Divisions{
    key divisionId:Integer;
    divisionName:String(100);
    city:String(100);
    country:String(100);
 }  */


namespace poapplication.db;



entity album {
    key ID          : Integer;
    Title           : String(120);
    Description     : String(255);
    View            : Integer;

    photos          : Association to many photo
                        on photos.Album = $self;
}

entity location {
    key ID          : Integer;
    Name            : String(200);
    Shortname       : String(50);

    photos          : Association to many photo
                        on photos.Location = $self;
}

entity member {
    key ID          : Integer;
    Name            : String(255);
    PhoneNum        : String(20);
    Email           : String(200);
    Address         : String(255);

    photos          : Association to many photo
                        on photos.Member = $self;
}

entity photo {
    key ID          : Integer;

    Album           : Association to album;
    Location        : Association to location;
    Member          : Association to member;

    Title           : String(120);
    Description     : String(255);
    Privacy         : String(20);
    UploadDate      : Date;
    View            : Integer;
    ImagePath       : String(50);

    comments        : Composition of many comment
                        on comments.Photo = $self;

    tagphotos       : Composition of many tagphoto
                        on tagphotos.Photo = $self;
}

entity comment {
    key ID          : Integer;

    Photo           : Association to photo;

    PostDate        : Date;
    Content         : String(255);
}

entity tag {
    key ID          : Integer;
    Title           : String(120);

    tagphotos       : Composition of many tagphoto
                        on tagphotos.Tag = $self;
}

entity tagphoto {
    key ID          : Integer;

    Tag             : Association to tag;
    Photo           : Association to photo;
}

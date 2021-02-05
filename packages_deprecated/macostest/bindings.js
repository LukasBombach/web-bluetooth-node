const { Photo } = require("./build/Release/macostest");

const photo = new Photo();

console.log(photo.caption);
console.log(photo.photographer);

console.log(photo.setCaption("setCaption"));
console.log(photo.setPhotographer("setPhotographer"));

console.log(photo.caption);
console.log(photo.photographer);

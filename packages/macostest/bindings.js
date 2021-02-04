const { Photo } = require("./build/Release/macostest");

const photo = new Photo();

console.log(photo.setCaption("setCaption"));
console.log(photo.setPhotographer("setPhotographer"));

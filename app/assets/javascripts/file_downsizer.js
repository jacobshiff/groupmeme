$(function() {
  document.getElementById('meme-file-input').onchange = function (e) {

  var image_orientation; // i believe the scope for this could be moved lower down
  var target = document.getElementById('target');
  var imagefile = e.target.files[0]
  var filetype = imagefile.type;

  if(filetype === "image/gif"){
    readGIF(imagefile);
  }
  else if (filetype === "image/jpeg" || filetype === "image/jpeg" || filetype === "image/png" || filetype === "image/tiff") {
    compressImage()
  }
  else {
    alert("This file type is not allowed.")
  }
  
  function readGIF(imagefile){
    var image = imagefile
    var reader = new FileReader();
    var newinputImageType = document.createElement("input");
    newinputImageType.type = 'hidden';
    newinputImageType.name = 'filetype';
    newinputImageType.value = image.type; // put result from canvas into new hidden input
    form.appendChild(newinputImageType);
    reader.onload = function(file) {
      var img = new Image();
      img.src = file.target.result;
      img.id="preview-image"
      $('#target').html(img);
      $('img#preview-image').css( "width", "100%" )
    }
    reader.readAsDataURL(image);
  }

  function compressImage(){
    loadImage.parseMetaData(imagefile, function (data) {
      if (data.exif) { // This will only be for JPEGs
        image_orientation = data.exif.get('Orientation');
        loadImage(
          imagefile,
          function (img) {
            $(target).html(img);
            img.style = 'width:100%';
            var canvas = document.getElementsByTagName('canvas');
            var resized = canvas[0].toDataURL(filetype);
            var newinput = document.createElement("input");
            newinput.type = 'hidden';
            newinput.name = 'images[]';
            newinput.value = resized; // put result from canvas into new hidden input
            form.appendChild(newinput);

            var newinputImageType = document.createElement("input");
            newinputImageType.type = 'hidden';
            newinputImageType.name = 'filetype';
            newinputImageType.value = filetype; // put result from canvas into new hidden input
            form.appendChild(newinputImageType);
              // document.body.appendChild(img);
            },
            {
              maxWidth: 600,
              // maxHeight: 300,
              // minWidth: 100,
              // minHeight: 50,
              canvas: true,
              orientation: image_orientation
            }
          );  

      } else { // This will only be for TIFFs and PNGs
        loadImage(
          imagefile,
          function (img) {
            img.style = 'width:100%';
            $(target).html(img);
            var canvas = document.getElementsByTagName('canvas');
            var resized = canvas[0].toDataURL(filetype);
            var newinput = document.createElement("input");
            newinput.type = 'hidden';
            newinput.name = 'images[]';
            newinput.value = resized; // put result from canvas into new hidden input
            form.appendChild(newinput);

            var newinputImageType = document.createElement("input");
            newinputImageType.type = 'hidden';
            newinputImageType.name = 'filetype';
            newinputImageType.value = filetype; // put result from canvas into new hidden input
            form.appendChild(newinputImageType);
              // document.body.appendChild(img);
            },
            {
              maxWidth: 600,
              // maxHeight: 300,
              // minWidth: 100,
              // minHeight: 50,
              canvas: true,
            }
          );  

      }


    });

    }
  };

});

// 'use strict';

// $(function() {
//   var fileinput = document.getElementById('meme-fileinput');

//   var max_width = 600;
//   var max_height = 600;

//   var target = document.getElementById('target');

//   var form = document.getElementById('form');

//   $('input#meme-fileinput').on('change', function(){
//     var file_type = fileinput.files[0].type
//     if ( !( window.File && window.FileReader && window.FileList && window.Blob ) ) {
//       alert('The File APIs are not fully supported in this browser.');
//       return false;
//       }
//     else {
//       if(file_type === "image/gif"){
//         gifReader(fileinput.files)
//       }
//       else if (file_type === "image/jpeg" || file_type === "image/jpeg" || file_type === "image/png" || file_type === "image/tiff") {
//         downsizeReader(fileinput.files) 
//       }
//       else {
//         alert("This file type is not allowed.")
//       }
//     }
//   })

  // function gifReader(files){
  //   var image = files[0]
  //   var reader = new FileReader();
  //   var newinputImageType = document.createElement("input");
  //   newinputImageType.type = 'hidden';
  //   newinputImageType.name = 'filetype';
  //   newinputImageType.value = image.type; // put result from canvas into new hidden input
  //   form.appendChild(newinputImageType);
  //   reader.onload = function(file) {
  //     var img = new Image();
  //     img.src = file.target.result;
  //     img.id="preview-image"
  //     $('#target').html(img);
  //     $('img#preview-image').css( "width", "100%" )
  //   }
  //   reader.readAsDataURL(image);
  // }


//   function downsizeReader(files) {

//       // remove the existing canvases and hidden inputs if user re-selects new pics
//       var existinginputs = document.getElementsByName('images[]');
//       var existingcanvases = document.getElementsByTagName('canvas');
//       while (existinginputs.length > 0) { // it's a live list so removing the first element each time
//         // DOMNode.prototype.remove = function() {this.parentNode.removeChild(this);}
//         form.removeChild(existinginputs[0]);
//         preview.removeChild(existingcanvases[0]);
//       } 

//       for (var i = 0; i < files.length; i++) {
//         processfile(files[i]); // process each file at once
//       }
//       fileinput.value = ""; //remove the original files from fileinput
//       // TODO remove the previous hidden inputs if user selects other files
//   }

//   function processfile(file) {  
//       if( !( /image/i ).test( file.type ) )
//           {
//               alert( "File "+ file.name +" is not an image." );
//               return false;
//           }
//       var filetype = file.type;
//       var reader = new FileReader();
//       reader.readAsArrayBuffer(file);
//       reader.onload = function(event) {
//         var blob = new Blob([event.target.result]);
//         window.URL = window.URL || window.webkitURL;
//         var blobURL = window.URL.createObjectURL(blob);
//         var image = new Image();
//         image.src = blobURL;
//         //preview.appendChild(image); // preview commented out, I am using the canvas instead
//         image.onload = function() {
//           // have to wait till it's loaded
//           var resized = resizeMe(image, filetype); // send it to canvas
//           var newinput = document.createElement("input");
//           newinput.type = 'hidden';
//           newinput.name = 'images[]';
//           newinput.value = resized; // put result from canvas into new hidden input
//           form.appendChild(newinput);
//           var newinputImageType = document.createElement("input");
//           newinputImageType.type = 'hidden';
//           newinputImageType.name = 'filetype';
//           newinputImageType.value = filetype; // put result from canvas into new hidden input
//           form.appendChild(newinputImageType);
//         }
//       }
//     };


//   // === RESIZE ====

//   function resizeMe(img, filetype) {
//     var canvas = document.createElement('canvas');

//     var width = img.width;
//     var height = img.height;

//     // calculate the width and height, constraining the proportions
//     if (width > height) {
//       if (width > max_width) {
//         //height *= max_width / width;
//         height = Math.round(height *= max_width / width);
//         width = max_width;
//       }
//     } else {
//       if (height > max_height) {
//         //width *= max_height / height;
//         width = Math.round(width *= max_height / height);
//         height = max_height;
//       }
//     }

//     // resize the canvas and draw the image data into it
//     canvas.width = width;
//     canvas.height = height;
//     var ctx = canvas.getContext("2d");
//     ctx.drawImage(img, 0, 0, width, height);
//     canvas.style = 'width:100%'
//     $(target).html(canvas); // do the actual resized preview

//     return canvas.toDataURL(filetype); // get the data from canvas as 70% JPG (can be also PNG, etc.)

//   }



// });
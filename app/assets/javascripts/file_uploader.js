var fileinput = document.getElementById('fileinput');

var max_width = 600;
var max_height = 600;

var preview = document.getElementById('preview');

var form = document.getElementById('form');

function processfile(file) {  
    if( !( /image/i ).test( file.type ) )
        {
            alert( "File "+ file.name +" is not an image." );
            return false;
        }
    var filetype = file.type;
    var reader = new FileReader();
    reader.readAsArrayBuffer(file);
    reader.onload = function(event) {
      var blob = new Blob([event.target.result]);
      window.URL = window.URL || window.webkitURL;
      var blobURL = window.URL.createObjectURL(blob);
      var image = new Image();
      image.src = blobURL;
      //preview.appendChild(image); // preview commented out, I am using the canvas instead
      image.onload = function() {
        // have to wait till it's loaded
        var resized = resizeMe(image, filetype); // send it to canvas
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
      }
    }
  };

function readfiles(files) {
  
    // remove the existing canvases and hidden inputs if user re-selects new pics
    var existinginputs = document.getElementsByName('images[]');
    var existingcanvases = document.getElementsByTagName('canvas');
    while (existinginputs.length > 0) { // it's a live list so removing the first element each time
      // DOMNode.prototype.remove = function() {this.parentNode.removeChild(this);}
      form.removeChild(existinginputs[0]);
      preview.removeChild(existingcanvases[0]);
    } 
  
    for (var i = 0; i < files.length; i++) {
      processfile(files[i]); // process each file at once
    }
    fileinput.value = ""; //remove the original files from fileinput
    // TODO remove the previous hidden inputs if user selects other files
}

fileinput.onchange = function(){
  if ( !( window.File && window.FileReader && window.FileList && window.Blob ) ) {
    alert('The File APIs are not fully supported in this browser.');
    return false;
    }
  readfiles(fileinput.files);
}

// === RESIZE ====

function resizeMe(img, filetype) {
  debugger
  var canvas = document.createElement('canvas');

  var width = img.width;
  var height = img.height;

  // calculate the width and height, constraining the proportions
  if (width > height) {
    if (width > max_width) {
      //height *= max_width / width;
      height = Math.round(height *= max_width / width);
      width = max_width;
    }
  } else {
    if (height > max_height) {
      //width *= max_height / height;
      width = Math.round(width *= max_height / height);
      height = max_height;
    }
  }
  
  // resize the canvas and draw the image data into it
  canvas.width = width;
  canvas.height = height;
  var ctx = canvas.getContext("2d");
  ctx.drawImage(img, 0, 0, width, height);
  
  preview.appendChild(canvas); // do the actual resized preview
  
  return canvas.toDataURL(filetype); // get the data from canvas as 70% JPG (can be also PNG, etc.)

}

$(function() {
  $('textarea.meme-text').on('change', function(event){
    var top_text = $('textarea#top-text').val()
    var bottom_text = $('textarea#bottom-text').val()
    var title = $('#meme-title-text').val()
    // Sets to a hidden field in form
    $('input#top_text').val(top_text)
    $('input#bottom_text').val(bottom_text)
    $('input#meme-title-input').val(title)
  })

  $('input#meme-title-text').on('change', function(event){
    var title = $('#meme-title-text').val()
    // Sets to a hidden field in form
    $('input#meme-title-input').val(title)
  })

// Prevent enter from submitting form on tag field
$("#tag-autocomplete").bind("keypress", function (e) {
    if (e.keyCode == 13) {
        return false;
    }
});

  // progress bar
  $('#meme-upload-submit').on('click', function(event){    
    var progress_bar_html = '<div id="progressDiv" class="progress"><div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%"></div></div>'
    $('#progressDivtarget').html(progress_bar_html)
  })

});
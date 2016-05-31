var fileinput = document.getElementById('fileinput');

var max_width = 600;
var max_height = 600;

var preview = document.getElementById('preview');

var form = document.getElementById('form');

$(function() {
  $('#pictureInput').on('change', function(event) {
    var files = event.target.files;
    var file = files[0]
    // debugger  
    // var image = files[0]
    // var blob = new Blob(files);
    // var blobURL = URL.createObjectURL(blob);
    // here's the file size
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
        var resized = resizeMe(image); // send it to canvas
        var newinput = document.createElement("input");
        newinput.type = 'hidden';
        newinput.name = 'images[]';
        newinput.value = resized; // put result from canvas into new hidden input
        form.appendChild(newinput);
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

  function drawCanvas(img) {
    var max_width = 600;
    var max_height = 600;
    var width = img.width;
    var height = img.height;
    var canvas = document.getElementById("canvas");
    var ctx = canvas.getContext("2d");

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
    // ctx.clearRect(0, 0, canvas.width, canvas.height);
    ctx.drawImage(img, 0, 0, width, height);
    return canvas.toDataURL("image/jpeg",0.7);
    // ctx.drawImage(image, 33, 90, 104, 124, 21, 20, 87, 104);
  }



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
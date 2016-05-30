$(function() {
  $('#pictureInput').on('change', function(event) {
    var files = event.target.files;
    var image = files[0]
    // here's the file size
    var reader = new FileReader();
    reader.onload = function(file) {
      var img = new Image();
      img.src = file.target.result;
      img.id="preview-image"
      drawCanvas(img)
      $('#target').html(img);
      $('img#preview-image').css( "width", "100%" )
    }
    reader.readAsDataURL(image);
    console.log(files);
  });


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
  // ctx.drawImage(image, 33, 90, 104, 124, 21, 20, 87, 104);
  }


// // set url
//   $('#meme-upload-submit').on('click', function(event){
    
//     var template_temp = $('img#preview-image').attr('src');
//     $('input#template_temp').val(template_temp)
//   })


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

  // $('input#meme-upload-submit').on('click', function(event){
  //   var top_text = $('textarea#top-text').val()
  //   var bottom_text = $('textarea#bottom-text').val()
  //   $.ajax({
  //     url: '/flatiron-school/memes/mememaker',
  //     data: 'POST',
  //     success: function(){
  //     }
  //   })
  //   debugger
  // })
});
$(function() {
  $('#pictureInput').on('change', function(event) {
    var files = event.target.files;
    var image = files[0]
    // here's the file size
    console.log(image.size);
    var reader = new FileReader();
    reader.onload = function(file) {
      var img = new Image();
      console.log(file);
      img.src = file.target.result;
      img.id="preview-image"
      $('#target').html(img);
      $('img#preview-image').css( "width", "100%" )
    }
    reader.readAsDataURL(image);
    console.log(files);
  });


  $('textarea.meme-text').on('change', function(event){
    var top_text = $('textarea#top-text').val()
    var bottom_text = $('textarea#bottom-text').val()
    // Sets to a hidden field in form
    $('input#top_text').val(top_text)
    $('input#bottom_text').val(bottom_text)
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
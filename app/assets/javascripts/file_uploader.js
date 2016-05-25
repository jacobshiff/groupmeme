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
      $('img#preview-image').css( "max-width", "100%" )
    }
    reader.readAsDataURL(image);
    console.log(files);
  });
});
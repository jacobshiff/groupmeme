// See file_downsizer.js for filesizing code
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
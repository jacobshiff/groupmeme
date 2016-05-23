$(document).ready(function(){
  $('.index-meme-container').each(
    function(){
      var $this = $(this);
      $this.css('margin-top', $this.parent().height() - $this.height());
  });
})

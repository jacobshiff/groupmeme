$(document).ready(function(){
  bindClick()
});

function bindClick(){
  $('div.form-group button.btn').click(function(event){
    event.preventDefault();
    event.stopPropagation();
    var content = $('input.form-control').val();
    var url = $(this).parent().attr('href')
    submitComment(content, url);
  });
}

function submitComment(content, url){
  $.ajax({
    url: url,
    type: 'POST',
    data: {comment: {content: content}},
    success: function(response){
      var new_comment = build_new_comment(response);
      $('ul.commentList').append(new_comment);
      $('input.form-control').val("");
      // Scroll to bottom
      var psconsole = $('.commentList');
      if(psconsole.length){
        psconsole.scrollTop(psconsole[0].scrollHeight - psconsole.height());
      }
    }
  })
}

function build_new_comment(response){
  // rewrite alt
  var output = '<li><div class="commenterImage"><img src="' + response.user_avatar + '" alt="' + response.username + 'avatar" /></div><div class="commentText"><p><strong><a href="/users/' + response.username + '">'+ response.username + ' </a></strong>' + response.content + '</p> <span class="date sub-text">' + response.time + '</span></div></li>'
  return output
}

function deleteComment(){
  $('li.commentItem button.delete').click(function(e){
    e.preventDefault();
    var comment = $(this).parent();
    $.ajax({
      type: 'get',
      url: destroy_comment_path,
      data: {comment: comment}
      beforeSend: function() {
        parent.animate({'backgroundColor':'#fb6c6c'},300);
      },
      success: function() {
        parent.slideUp(300,function() {
          parent.remove();
        });
      }
    });
  })
}

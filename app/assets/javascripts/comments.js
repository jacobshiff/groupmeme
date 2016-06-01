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
  comment = response
  var output = '<li class="commentItem"><div class="commenterImage"><img src="' + comment.user_avatar + '" alt="' + comment.username + 'avatar" /></div><div class="commentText"><p><strong><a href="/users/' + comment.username + '">'+comment.username +'</a></strong> '+ comment.content +'</p><span class="date sub-text">'+ comment.time +'</span></div><div class="deleteComment"><a data-remote="true" rel="nofollow" data-method="delete" href="/comment/' + comment.id + '" title="Delete this comment"><span><i class="fa fa-times fa-fw grey"></i></span></a></div></li>'
  return output

}

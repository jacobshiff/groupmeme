$(document).ready(function(){
  debugger
  bindClick();
});

function bindClick(){
  $('div.form-group button.btn').click(function(event){
    event.preventDefault();
    event.stopPropagation();
    var content = $('input.form-control').val();
    debugger 
    submitComment(content);
  });
}


function submitComment(content){
  // $.ajax({
  //   url: comment_path()
  //   type:
  //   success: function(){

  //   }
  // })
}

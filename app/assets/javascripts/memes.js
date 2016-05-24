$(document).ready(function(){
	// disable auto discover
	Dropzone.autoDiscover = false;

	var myDropzone = new Dropzone("div#meme-upload", { url: });
	// grab our upload form by its id
	var dropzone = $("#meme-upload").dropzone({
		// restrict image size to a maximum 1MB
		maxFilesize: 1,
		// changed the passed param to one accepted by
		// our rails app
		paramName: "meme[image]",
		// show remove links on each image upload
		addRemoveLinks: true
	});

	dropzone.on('success', function(file, responseText) {
		debugger;
  // return window.location.href = '/memes/' + responseText.id;
	});
});

$(document).ready(function(){
	// disable auto discover
	Dropzone.autoDiscover = false;

	// grab our upload form by its id
	$("#meme-upload").dropzone({
		// restrict image size to a maximum 1MB
		maxFilesize: 1,
		// changed the passed param to one accepted by
		// our rails app
		paramName: "meme[image]",
		// show remove links on each image upload
		addRemoveLinks: true
	});
});



var progress = $("#progressDiv").html();

BootstrapDialog.show(
{
    title: "Please wait...",
    message: progress
});
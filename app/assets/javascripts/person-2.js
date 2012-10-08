$(document).ready(function() {
    $('.video-thumb').hover(
        function () {
            $(this).next('.video-thumb-layover').show();
        },
        function () {
            $(this).next('.video-thumb-layover').hide();
        }
    );
    $('.video-thumb-layover').hover(
        function () {
            $(this).show();
        },
        function () {
            $(this).hide();
        }
    );
});



document.addEventListener('page:change', function() {
        document.getElementById('quizz-container').className += 'animated fadeIn';
});
document.addEventListener('page:fetch', function() {
        document.getElementById('quizz-container').className += 'animated fadeOut';
});

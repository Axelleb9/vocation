const quizzDetails = document.querySelector('.quizz-details');
const totalWords = document.getElementById('total-word');
const difficulty = document.getElementById('img-difficulty');
const quizzType = document.getElementById('quizz-type');
const quizzes = document.querySelectorAll('.card-index-quizzes');
const button = document.getElementById("start-quizz");

const resetColors = () => {
  quizzes.forEach((quizz) => {
    quizz.classList.remove('new-style');
    quizz.classList.remove('new-week-style');
    difficulty.innerHTML = ''
  })

}

const displayQuizzDetails = () => {
  quizzes.forEach((quizz) => {
    quizz.addEventListener('click', (event) => {
      resetColors();
      if (event.currentTarget.dataset.week == "yes") {
        quizzDetails.classList.add('display-quizz');
        event.currentTarget.classList.add("new-week-style");
        const level = event.currentTarget.dataset.difficulty;
        const type = event.currentTarget.dataset.type;
        const count = event.currentTarget.dataset.words;
        const id = event.currentTarget.dataset.id;
        const title = event.currentTarget.dataset.title;
        totalWords.innerHTML = count;
        quizzType.innerHTML = type;
        button.classList.add('call-to-btn');
        var image = document.createElement('IMG');
        image.src = 'https://res.cloudinary.com/dlodtvkez/image/upload/v1567603735/level_1.png';
        image.width = "60";
        image.height = "60";
        image.className = "iam-white";
        if (event.currentTarget.dataset.difficulty < 2.5 ) {
          image.src = 'https://res.cloudinary.com/dlodtvkez/image/upload/v1567603735/level_1.png';
          difficulty.appendChild(image);
        } else if (event.currentTarget.dataset.difficulty < 5 ) {
          image.src = 'https://res.cloudinary.com/dlodtvkez/image/upload/v1567603854/level_2.png';
          difficulty.appendChild(image);
        } else if (event.currentTarget.dataset.difficulty < 7.5 ) {
          image.src = 'https://res.cloudinary.com/dlodtvkez/image/upload/v1567603872/level_3.png';
          difficulty.appendChild(image);
        } else {
          image.src = 'https://res.cloudinary.com/dlodtvkez/image/upload/v1567603762/level_4.png';
          difficulty.appendChild(image);
        }

      } else {
        quizzDetails.classList.add('display-quizz');
        event.currentTarget.classList.add('new-style');
        const level = event.currentTarget.dataset.difficulty;
        const type = event.currentTarget.dataset.type;
        const count = event.currentTarget.dataset.words;
        const id = event.currentTarget.dataset.id;
        const title = event.currentTarget.dataset.title;
        totalWords.innerHTML = count;
        quizzType.innerHTML = type;
        button.classList.add('call-to-btn');
        var image = document.createElement('IMG');
        image.src = 'https://res.cloudinary.com/dlodtvkez/image/upload/v1567603735/level_1.png';
        image.width = "60";
        image.height = "60";
        image.className = "iam-white";
        if (event.currentTarget.dataset.difficulty < 2.5 ) {
          image.src = 'https://res.cloudinary.com/dlodtvkez/image/upload/v1567603735/level_1.png';
          difficulty.appendChild(image);
        } else if (event.currentTarget.dataset.difficulty < 5 ) {
          image.src = 'https://res.cloudinary.com/dlodtvkez/image/upload/v1567603854/level_2.png';
          difficulty.appendChild(image);
        } else if (event.currentTarget.dataset.difficulty < 7.5 ) {
          image.src = 'https://res.cloudinary.com/dlodtvkez/image/upload/v1567603872/level_3.png';
          difficulty.appendChild(image);
        } else {
          image.src = 'https://res.cloudinary.com/dlodtvkez/image/upload/v1567603762/level_4.png';
          difficulty.appendChild(image);
        }
      }
    });
  });
}

const startQuizz = () => {
  if (button) {
    button.addEventListener('click', (event) => {
      const weekQuizz = document.querySelector('.new-week-style');
      const listQuizz = document.querySelector('.new-style');
      if (listQuizz) {
        const url = `https://www.vocation.world/lists/${listQuizz.dataset.id}/quizz`
        const devurl = `/lists/${listQuizz.dataset.id}/quizz`
        console.log(devurl)
        window.location.replace(devurl)
      } else {
        const url = `https://www.vocation.world/lists/${weekQuizz.dataset.id}/quizz`
        const devurl = `/lists/${weekQuizz.dataset.id}/quizz`
        console.log(devurl)
        window.location.replace(devurl)
      }
    })
  }
}
startQuizz();
export { displayQuizzDetails }

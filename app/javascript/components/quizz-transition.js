const answers = document.querySelectorAll('.possible-answer');
const goodAnswer = document.querySelector('.good-answer');
const wrongAnswers = document.querySelectorAll('.wrong-answer');
const arrowGood = document.getElementById('arrow-good');
const arrowWrong = document.getElementById('arrow-wrong');

function displayArrow(arrow) {
  if (arrow == "1") {
    arrowGood.classList.add('display-arrow');
  } else {
    arrowWrong.classList.add('display-arrow');
  }
};

const displayResult = () => {
  answers.forEach((answer) => {
    answer.addEventListener('click', (event) => {
      if (event.currentTarget.dataset["answer"] === "1") {
        event.currentTarget.classList.add('got-it');
        setTimeout(function() {displayArrow("1")}, 800);
        var url = `https://www.vocation.world/lists/${goodAnswer.dataset["list_id"]}/quizz_good_answer?words_list=${goodAnswer.dataset["word_list"]}`;
        var devurl = `http://localhost:3000//lists/${goodAnswer.dataset["list_id"]}/quizz_good_answer?words_list=${goodAnswer.dataset["word_list"]}`;
        // setTimeout(window.location.href = devurl, 2000);
      } else {
        var url = `https://www.vocation.world/lists/${goodAnswer.dataset["list_id"]}/quizz_wrong_answer?words_list=${goodAnswer.dataset["word_list"]}`;
        var devurl = `http://localhost:3000//lists/${goodAnswer.dataset["list_id"]}/quizz_wrong_answer?words_list=${goodAnswer.dataset["word_list"]}`;
        event.currentTarget.insertAdjacentHTML('beforeend', `<i class="fas fa-times cross-wrong-answer"></i>`);
        event.currentTarget.classList.add('oups');
        goodAnswer.classList.add('show-valid-answer');
        setTimeout(function() {displayArrow("0")}, 800);
        // setTimeout(window.location.href = devurl, 2000);
      }
    })
  })
}

export { displayResult }

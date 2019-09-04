import "bootstrap";
import { displaySubmit, undisplaySubmit, closeWithCross } from '../components/translator-submit-view'
import { initActionCable } from '../plugins/init_action_cable'
import { rotateMe, displayDetails }  from 'components/word-card-display-view'
import { switchCard } from 'components/flashcard-switch'
import { quizztransition } from '../components/quizz-transition'
// import { translate } from '../components/translate-word';

// translate()

displaySubmit();
undisplaySubmit();
closeWithCross();
rotateMe();
initActionCable();
switchCard();
displayDetails();


$(document).ready(function(){
    $('.dropdown-for-mobile').dropdown();
});


const answers = document.querySelectorAll('.possible-answer');
const goodAnswer = document.querySelector('.good-answer');
const wrongAnswers = document.querySelectorAll('.wrong-answer');
const goodForm = document.getElementById('form-good-answer');
const inputForm = document.getElementById("word");

const displayResult = () => {
  answers.forEach((answer) => {
    answer.addEventListener('click', (event) => {
      if (event.currentTarget.dataset["answer"] === "1") {
        event.currentTarget.classList.add('got-it');
        var url = `https://www.vocation.world/lists/${goodAnswer.dataset["list_id"]}/quizz_good_answer?words_list=${goodAnswer.dataset["word_list"]}`;
        var devurl = `http://localhost:3000//lists/${goodAnswer.dataset["list_id"]}/quizz_good_answer?words_list=${goodAnswer.dataset["word_list"]}`;
        // setTimeout(window.location.href = devurl, 2000);
        inputForm.value = "test";
      } else {
        var url = `https://www.vocation.world/lists/${goodAnswer.dataset["list_id"]}/quizz_wrong_answer?words_list=${goodAnswer.dataset["word_list"]}`;
        var devurl = `http://localhost:3000//lists/${goodAnswer.dataset["list_id"]}/quizz_wrong_answer?words_list=${goodAnswer.dataset["word_list"]}`;
        event.currentTarget.insertAdjacentHTML('beforeend', `<i class="fas fa-times cross-wrong-answer"></i>`);
        event.currentTarget.classList.add('oups');
        goodAnswer.classList.add('show-valid-answer');
        inputForm.value = "test";
        // setTimeout(window.location.href = devurl, 2000);
      }
    })
  })
}

displayResult();


// window.location.href = "http://localhost:3000/words?sub_cat=20&mode=red+2010";


// const openModal = document.getElementById("highpage");
// openModal.addEventListener("click", (event) => {
// 	$('#highpage').modal();
// })

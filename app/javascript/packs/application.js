import "bootstrap";
import { displaySubmit, undisplaySubmit, closeWithCross } from '../components/translator-submit-view';
import { initActionCable } from '../plugins/init_action_cable';
import { rotateMe, displayDetails }  from '../components/word-card-display-view';
import { switchCard } from '../components/flashcard-switch';
import { displayResult } from '../components/quizz-transition';
import { displayQuizzDetails } from '../components/quizz-details';
// import { translate } from '../components/translate-word';


// translate()

displaySubmit();
undisplaySubmit();
closeWithCross();
rotateMe();
initActionCable();
switchCard();
displayDetails();
displayResult();
displayQuizzDetails();



$(document).ready(function(){
    $('.dropdown-for-mobile').dropdown();
});




// window.location.href = "http://localhost:3000/words?sub_cat=20&mode=red+2010";


// const openModal = document.getElementById("highpage");
// openModal.addEventListener("click", (event) => {
// 	$('#highpage').modal();
// })

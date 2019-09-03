import "bootstrap";
import { displaySubmit, undisplaySubmit, closeWithCross } from '../components/translator-submit-view'
import { initActionCable } from '../plugins/init_action_cable'
import { rotateMe, displayDetails }  from 'components/word-card-display-view'
import { switchCard } from 'components/flashcard-switch'
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


// const openModal = document.getElementById("highpage");
// openModal.addEventListener("click", (event) => {
// 	$('#highpage').modal();
// })

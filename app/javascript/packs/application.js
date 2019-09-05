import "bootstrap";
import { displaySubmit, undisplaySubmit, closeWithCross } from '../components/translator-submit-view'
import { initActionCable } from '../plugins/init_action_cable'
import { rotateMe, displayDetails }  from 'components/word-card-display-view'
import { switchCard } from 'components/flashcard-switch'
import { displayResult } from '../components/quizz-transition'
import { displayQuizzDetails } from '../components/quizz-details'
// import { translate } from '../components/translate-word';
import AOS from 'aos';
import 'aos/dist/aos.css';

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
AOS.init({
  // Global settings:
  disable: false, // accepts following values: 'phone', 'tablet', 'mobile', boolean, expression or function
  startEvent: 'DOMContentLoaded', // name of the event dispatched on the document, that AOS should initialize on
  initClassName: 'aos-init', // class applied after initialization
  animatedClassName: 'aos-animate', // class applied on animation
  useClassNames: false, // if true, will add content of `data-aos` as classes on scroll
  disableMutationObserver: false, // disables automatic mutations' detections (advanced)
  debounceDelay: 50, // the delay on debounce used while resizing window (advanced)
  throttleDelay: 99, // the delay on throttle used while scrolling the page (advanced)


  // Settings that can be overridden on per-element basis, by `data-aos-*` attributes:
  offset: 120, // offset (in px) from the original trigger point
  delay: 0, // values from 0 to 3000, with step 50ms
  duration: 400, // values from 0 to 3000, with step 50ms
  easing: 'ease', // default easing for AOS animations
  once: false, // whether animation should happen only once - while scrolling down
  mirror: false, // whether elements should animate out while scrolling past them
  anchorPlacement: 'top-bottom', // defines which position of the element regarding to window should trigger the animation

});

$(document).ready(function(){
    $('.dropdown-for-mobile').dropdown();
});




// window.location.href = "http://localhost:3000/words?sub_cat=20&mode=red+2010";


// const openModal = document.getElementById("highpage");
// openModal.addEventListener("click", (event) => {
// 	$('#highpage').modal();
// })

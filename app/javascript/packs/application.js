import "bootstrap";
import { displaySubmit, undisplaySubmit, closeWithCross } from '../components/translator-submit-view'
import { initActionCable } from '../plugins/init_action_cable'
import { rotateMe }  from 'components/word-card-display-view'
// import { translate } from '../components/translate-word';

// translate()

displaySubmit();
undisplaySubmit();
closeWithCross();
rotateMe();
initActionCable();

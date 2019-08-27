const entryArea = document.getElementById("entry");
const submitArea = document.getElementById("submit-translation");
const banner = document.querySelector(".top-banner");
const cards = document.querySelectorAll('.word-card-container');

const displaySubmit = () => {
  entryArea.addEventListener('focus', (event) => {
    submitArea.classList.add('display-me');
    banner.classList.add('hide-me');
    cards.forEach((card) => {
      card.classList.add('linear-filter');
    });
  });
}

const undisplaySubmit = () => {
  entryArea.addEventListener('blur', (event) => {
    submitArea.classList.remove('display-me');
    banner.classList.remove('hide-me');
    cards.forEach((card) => {
      card.classList.remove('linear-filter');
    });
  });
};


export { displaySubmit, undisplaySubmit }
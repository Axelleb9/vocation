const entryArea = document.getElementById("word_entry");
const submitArea = document.getElementById("submit-translation");
const banner = document.querySelector(".top-banner");
const cards = document.querySelectorAll('.word-card-container');
const cross = document.querySelector('.fa-times');
const lang = document.getElementById('language-infos')
const subBody = document.getElementById('sub-body')

const displaySubmit = () => {
  if (entryArea) {
    entryArea.addEventListener('focus', (event) => {
      if (entryArea.value === "Enter text"){
        entryArea.value = ""
      }
      cross.classList.remove('d-none');
      lang.classList.add('hide-language');
      submitArea.classList.add('display-me');
      banner.classList.add('hide-me');
      cards.forEach((card) => {
        card.classList.add('linear-filter');
      });
    });
  }
};

const undisplaySubmit = () => {
  if (subBody) {
    subBody.addEventListener('click', (event) => {
      if (entryArea.value === "") {
        entryArea.value = "Enter text"
      };
      cross.classList.add('d-none');
      lang.classList.remove('hide-language');
      submitArea.classList.remove('display-me');
      banner.classList.remove('hide-me');
      cards.forEach((card) => {
        card.classList.remove('linear-filter');
      });
    });
  };
};

const closeWithCross = () => {
  if (cross) {
    cross.addEventListener('click', (event) => {
      console.log(event.currentTarget)
      entryArea.value = "Enter text";
      cross.classList.add('d-none');
      lang.classList.remove('hide-language');
      submitArea.classList.remove('display-me');
      banner.classList.remove('hide-me');
      cards.forEach((card) => {
        card.classList.remove('linear-filter');
      });
    });
  }
};



export { displaySubmit, undisplaySubmit, closeWithCross }

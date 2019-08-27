const entryArea = document.getElementById("entry");
const submitArea = document.getElementById("submit-translation");
const banner = document.querySelector(".top-banner");
const cards = document.querySelectorAll('.word-card-container');
const cross = document.querySelector('.fa-times');

const displaySubmit = () => {
  entryArea.addEventListener('focus', (event) => {
    if (entryArea.value === "Enter text"){
      entryArea.value = ""
    }
    cross.classList.remove('d-none');
    submitArea.classList.add('display-me');
    banner.classList.add('hide-me');
    cards.forEach((card) => {
      card.classList.add('linear-filter');
    });
  });
}

const undisplaySubmit = () => {
  entryArea.addEventListener('blur', (event) => {
    if (entryArea.value === "") {
      entryArea.value = "Enter text"
    };
    cross.classList.add('d-none');
    submitArea.classList.remove('display-me');
    banner.classList.remove('hide-me');
    cards.forEach((card) => {
      card.classList.remove('linear-filter');
    });
  });
};

const closeWithCross = () => {
  cross.addEventListener('click', (event) => {
    if (entryArea.value === "") {
      entryArea.value = "Enter text"
    };
    cross.classList.add('d-none');
    submitArea.classList.remove('display-me');
    banner.classList.remove('hide-me');
    cards.forEach((card) => {
      card.classList.remove('linear-filter');
    });
  });
};



export { displaySubmit, undisplaySubmit, closeWithCross }

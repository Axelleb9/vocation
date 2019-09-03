const entryArea = document.getElementById("word_entry");
const banner = document.querySelector(".top-banner");
const cards = document.querySelector('.all-words');
const cross = document.querySelector('.fa-times');
const lang = document.getElementById('language-infos');
const subBody = document.getElementById('sub-body');
const appName = document.getElementById('app-name');

const displaySubmit = () => {
  if (entryArea) {
    entryArea.addEventListener('focus', (event) => {
      if (entryArea.value === "Enter text"){
        entryArea.value = ""
      }
      cross.classList.remove('d-none');
      appName.innerHTML = ""
      lang.classList.add('hide-language');
      banner.classList.add('hide-me');
      cards.style.opacity = 0.5;
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
      appName.innerHTML = "<strong>V</strong>ocation";
      banner.classList.remove('hide-me');
      cards.style.opacity = 1;
    });
  };
};

const closeWithCross = () => {
  if (cross) {
    cross.addEventListener('click', (event) => {
      appName.innerHTML = "<strong>V</strong>ocation";
      entryArea.value = "Enter text";
      cross.classList.add('d-none');
      lang.classList.remove('hide-language');
      banner.classList.remove('hide-me');
      cards.style.opacity = 1;
    });
  }
};



export { displaySubmit, undisplaySubmit, closeWithCross }

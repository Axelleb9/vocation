const entryArea = document.getElementById("entry")
const submitArea = document.getElementById("submit-translation")
const banner = document.querySelector(".top-banner")

const displaySubmit = () => {
  entryArea.addEventListener('focus', (event) => {
    submitArea.classList.add('display-me');
    banner.classList.add('hide-me');
  });
}

const undisplaySubmit = () => {
  entryArea.addEventListener('blur', (event) => {
    submitArea.classList.remove('display-me');
    banner.classList.remove('hide-me');
  });
};


export { displaySubmit, undisplaySubmit }

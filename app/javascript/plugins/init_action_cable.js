const example = document.getElementById("example");
const synonyms = document.getElementById("synonyms");
const nature = document.getElementById("nature");
const definition = document.getElementById("definition");
const translation = document.getElementById('translation');
const entryArea = document.getElementById("word_entry");


const initActionCable = () => {
  const action = document.getElementById('connect-actioncable');
  if (action) {
    const userId = action.dataset.userId;
    App[`word_details_user_${userId}`] = App.cable.subscriptions.create(
      { channel: 'WordDetailsChannel', user_id: userId },
      { received: (data) => insertData(data) }
    )
  };
};

const insertData = (data) => {
  if (data["type"] === "example") {
    example.innerHTML = data["detail"]
  } else if (data["type"] === "definition") {
    definition.innerHTML = data["detail"][0];
    nature.innerHTML = data["natures"][0];
  } else if (data["type"] === "synonyms") {
    synonyms.innerHTML = data["detail"]
  } else if (data["type"] === "translation") {
    translation.innerHTML = data["detail"]
  }
};

export { initActionCable };

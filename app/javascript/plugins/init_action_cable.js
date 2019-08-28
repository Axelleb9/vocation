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
  console.log(data)
}

export { initActionCable };

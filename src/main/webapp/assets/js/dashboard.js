date = document.getElementById("card-date");

const today = new Date();

const day = today.getDate();
const month = today.toLocaleString('default', { month: 'long' });
const year = today.getFullYear();

const formattedDate = `${day} ${month} ${year}`;
const btn_text = `01 ${month} ${year} - ${formattedDate}`;

date.textContent = btn_text;
